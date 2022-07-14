package com.kh.udongzip.agent.controller;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.udongzip.agent.model.service.AgentService;
import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.SaveFileRename;
import com.kh.udongzip.member.model.service.MemberService;

@Controller
public class AgentController {
	
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	/**
	* 업체회원 회원가입 페이지 이동용 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 회원가입 페이지
	*
	*/
	@RequestMapping("enrollForm.ag")
	public String agentEnrollForm() {
		return "user/agent/agentEnrollForm";
	}
	
	/**
	* 업체회원 회원가입 ID 중복 체크 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @return 중복확인 결과
	*
	*/
	@ResponseBody
	@RequestMapping(value="idCheck.ag", produces="text/html; charset=UTF-8")
	public String IdChek(String agentId) {
		
		int agentIdCount = agentService.agentIdCheck(agentId);
		
		int memberIdCount = memberService.memberIdCheck(agentId);
			
		return ((agentIdCount + memberIdCount) > 0) ? "NNNNN" : "NNNNY";
	}
	
	/**
	* 업체회원 회원가입 email 인증 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param email
	*        가입하려는 이메일
	* @return 인증번호 발송 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="emailCheck.ag", produces="text/html; charset=UTF-8")
	public String emailChek(String email) {
		
		int result = agentService.agentEmailCheck(email);
		
		if(result > 0) {
			
			return "NNNNN";
			
		} else {
		
			int code = (int)(Math.random() * 90000 + 10000);
			
			String setFrom = "udongzip12@gmail.com";
	        String toMail = email;
	        String title = "우리동네 좋은 집, 우동집 이메일 인증 번호입니다.";
	        String content = 
	                "우동집을 방문해주셔서 감사합니다." +
	                "<br><br>" + 
	                "인증 번호는 [" + code + "]입니다." + 
	                "<br>" + 
	                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
	        
	        try {
	            
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setFrom);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content,true);
	            mailSender.send(message);
	            
	        }catch(Exception e) {
	            e.printStackTrace();
	        }
	        
	        return Integer.toString(code);
			
		}
 
	}
	
	/**
	* 업체회원 회원가입 메소드
	* 전달 받은 파일 rename 후 서버 컴퓨터에 저장 및 파일경로로 필드값 set
	*
	* @version 1.0
	* @author 박민규
	* @param gent
	* 		 회원가입 정보가 담긴 agent 객체
	* @param document
	* 		 증빙서류 이미지 파일(2개)
	* @return 메인 페이지로 redirect
	*
	*/
	@PostMapping("insert.ag")
	public String insertAgent(Agent agent,
							  List<MultipartFile> document,
							  Model model,
							  HttpSession session) {
		
		String encPwd = bCryptPasswordEncoder.encode(agent.getAgentPwd());
		
		agent.setAgentPwd(encPwd);
		
		ArrayList<String> changeNames = new ArrayList<>();
		
		for(int i = 0; i < document.size(); i++) {
			
			changeNames.add(new SaveFileRename().saveDocument(agent.getAgentNo(), document.get(i), session));
			
		};
		
		agent.setDocument1(changeNames.get(0));
		agent.setDocument2(changeNames.get(1));
		
		int result = agentService.insertAgent(agent);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "성공적으로 회원가입이 완료 되었습니다.");
			
			return "redirect:/";
			
		} else {
			
			model.addAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
		
	}
	
	/**
	* 업체회원 비밀번호 재설정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param userId
	* 		 재설정하고자 하는 아이디
	* @return 임시비밀번호 발급 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="findPwd.ag", produces="text/html; charset=UTF-8")
	public String findPwd(@RequestParam("userId") String agentId) {
		
		Agent agent = agentService.findPwd(agentId);
		
		if(agent != null) {
			
			String email = agent.getAgentEmail();
			String tmpPassword = getRandomPassword(10);;
			
			String setFrom = "udongzip12@gmail.com";
	        String toMail = email;
	        String title = "우리동네 좋은 집, 우동집 임시비밀번호입니다.";
	        String content = 
	                "임시비밀번호는 [" + tmpPassword + "]입니다." + 
	                "<br>" + 
	                "로그인 후 꼭 비밀번호를 변경해주세요.";
	        
	        try {
	            
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setFrom);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content,true);
	            mailSender.send(message);
	            
	        }catch(Exception e) {
	            e.printStackTrace();
	        }
	        
	        agent.setAgentPwd(bCryptPasswordEncoder.encode(tmpPassword));
	        
	        int result = agentService.updatePwd(agent);
	        
	        if(result > 0) {
	        	
	        	return "NNNNY";
	        	
	        } else {
	        	
	        	return "NNNNN";
	        	
	        }
			
		} else {
			
			return "NNNNN";
			
		}
		
	}
	
	/**
	* 업체회원 로그인 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agentId
	* 		 업체회원 아이디
	* @param agentPwd
	* 	     업체회원 비밀번호
	* @return 업체회원 회원가입 페이지
	*
	*/
	@PostMapping("login.ag")
	public String agentLogin(@RequestParam(value="memberId")String agentId,
							 @RequestParam(value="memberPwd")String agentPwd,
							 String loginCheck,
							 HttpServletResponse response,
							 HttpSession session) {
		
		Agent loginUser = agentService.loginAgent(agentId);
		
		if(loginUser != null && bCryptPasswordEncoder.matches(agentPwd, loginUser.getAgentPwd())) {
			
			// 아이디 저장 체크 시
			if(loginCheck != null && loginCheck.equals("y")) {
				
				Cookie cookie = new Cookie("saveId", loginUser.getAgentId());
				cookie.setMaxAge(1 * 24 * 60 * 60);
				response.addCookie(cookie);
						
			} else { // 체크 안한 경우
						
				Cookie cookie = new Cookie("saveId", loginUser.getAgentId());
				cookie.setMaxAge(0);
				response.addCookie(cookie);
						
			};
			
			// 식별자 setting
			loginUser.setIdentifier("agent");
			
			// session에 로그인 정보 및 성공 알림 메시지 저장
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 되었습니다.");
			
		} else {
			
			session.setAttribute("alertMsg", "아이디 또는 비밀번호를 확인하세요.");
			
		}
		
		return "redirect:/";
		
	}
	
	/**
	* 업체회원 로그아웃 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 메인페이지
	*
	*/
	@RequestMapping("logout.ag")
	public String agentLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	/**
	* 업체회원 내 정보 관리 페이지 이동용 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@RequestMapping("updateForm.ag")
	public String agentUpdateForm(HttpSession session) {
		
		return "user/agent/agentUpdateForm";
	}
	
	/**
	* 업체회원 회원정보 수정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agent
	* 		 업체회원 정보가 담긴 객체
	* @return 업체회원 회원정보 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("update.ag")
	public String agentUpdate(Agent agent,
							  Model model,
							  HttpSession session) {
		
		
		int result = agentService.updateAgent(agent);
		
		if(result > 0) {
			
			Agent loginUser = agentService.selectAgent(agent.getAgentNo());
			
			loginUser.setIdentifier("agent");
			
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
			
			return "redirect:updateForm.ag";
			
		} else {
			
			model.addAttribute("errorMsg", "회원 정보 수정에 실패했습니다. 잠시 후 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
	}
	
	/**
	* 업체회원 비밀번호 변경 메소드
	* 
	*
	* @version 1.0
	* @author 박민규
	* @param agentPwd
	* 		 현재 비밀번호
	* @param newPwd
	* 		 변경할 비밀번호
	* @return 업체회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("updatePwd.ag")
	public String updatePwd(String agentPwd,
							String newPwd,
							Model model,
							HttpSession session) {
		
		Agent loginUser = (Agent)session.getAttribute("loginUser");
		
		if(bCryptPasswordEncoder.matches(agentPwd, loginUser.getAgentPwd())) {
			
			loginUser.setAgentPwd(bCryptPasswordEncoder.encode(newPwd));
			
			int result = agentService.updatePwd(loginUser);
			
			if(result > 0) {
				
				session.setAttribute("loginUser", loginUser);
				session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
				
			} else {
				
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다. 잠시후 다시 시도해주세요.");
				
				return "common/error";
			}
			
		} else {
			
			session.setAttribute("alertMsg", "현재 비밀번호가 일치하지 않습니다.");
			
		}
		
		return "redirect:updateForm.ag";

	}
	
	/**
	* 업체회원 탈퇴 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 업체회원 번호
	* @param agentPwd
	* 		 비밀번호
	* @return 메인페이지로 redirect
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("delete.ag")
	public String deleteAgent(int agentNo,
							  String agentPwd,
							  Model model,
							  HttpSession session) {
		
		Agent agent = agentService.selectAgent(agentNo);
		
		if(bCryptPasswordEncoder.matches(agentPwd, agent.getAgentPwd())) {
			
			int result = agentService.deleteAgent(agentNo);
			
			if(result > 0) {
				
				session.removeAttribute("loginUser");
				session.setAttribute("alertMsg", "성공적으로 탈퇴 되었습니다. 그동안 이용해 주셔서 감사합니다.");
				
				return "redirect:/";
				
			} else {
				
				model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다. 잠시 후 다시 시도해주세요.");
				
				return "common/error";
				
			}
			
		} else {
			
			session.setAttribute("alertMsg", "회원 탈퇴에 실패했습니다. 비밀번호를 확인하세요.");
			
			return "redirect:updateForm.ag";
			
		}
		
	}
	
    public String getRandomPassword(int size) {
        char[] charSet = new char[] {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                '!', '@', '#', '$', '%', '^', '&' };

        StringBuffer sb = new StringBuffer();
        SecureRandom sr = new SecureRandom();
        sr.setSeed(new Date().getTime());

        int idx = 0;
        int len = charSet.length;
        for (int i=0; i<size; i++) {
            // idx = (int) (len * Math.random());
            idx = sr.nextInt(len);    // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
            sb.append(charSet[idx]);
        }

        return sb.toString();
    }


}
