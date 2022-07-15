package com.kh.udongzip.member.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.kh.udongzip.agent.model.service.AgentService;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.TemporaryPassword;
import com.kh.udongzip.member.model.service.MemberService;
import com.kh.udongzip.member.model.vo.Member;


@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private TemporaryPassword temporaryPassword;
	
	/**
	* 개인회원 비밀번호 재설정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param userId
	* 		 재설정하고자 하는 아이디
	* @return 임시비밀번호 발급 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="findPwd.me", produces="text/html; charset=UTF-8")
	public String findPwd(@RequestParam("userId") String memberId) {
		
		Member member = memberService.findPwd(memberId);
		
		if(member != null) {
			
			String email = member.getMemberEmail();
			String tmpPassword = temporaryPassword.getRandomPassword(10);;
			
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
	        
	        member.setMemberPwd(bCryptPasswordEncoder.encode(tmpPassword));
	        
	        int result = memberService.updatePwd(member);
	        
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
	* 개인회원 회원가입 ID 중복 체크 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @return 중복확인 결과
	*
	*/
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String IdChek(String memberId) {
		
		int agentIdCount = agentService.agentIdCheck(memberId);
		
		int memberIdCount = memberService.memberIdCheck(memberId);
			
		return ((agentIdCount + memberIdCount) > 0) ? "NNNNN" : "NNNNY";
	}
	
	/**
	* 개인회원 회원가입 email 인증 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param email
	*        가입하려는 이메일
	* @return 인증번호 발송 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="emailCheck.me", produces="text/html; charset=UTF-8")
	public String emailChek(String email) {
		
		int result = memberService.memberEmailCheck(email);
		
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
	* 개인회원 비밀번호 변경 메소드
	* 
	*
	* @version 1.0
	* @author 박민규
	* @param memberPwd
	* 		 현재 비밀번호
	* @param newPwd
	* 		 변경할 비밀번호
	* @return 개인회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.MEMBER)
	@PostMapping("updatePwd.me")
	public String updatePwd(String memberPwd,
							String newPwd,
							Model model,
							HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if(bCryptPasswordEncoder.matches(memberPwd, loginUser.getMemberPwd())) {
			
			loginUser.setMemberPwd(bCryptPasswordEncoder.encode(newPwd));
			
			int result = memberService.updatePwd(loginUser);
			
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
		
		return "redirect:myPage.me";

	}
	
	//로그인
	@RequestMapping(value="login.me")
	public ModelAndView loginMember(
							Member member,
							String loginCheck,
							HttpServletResponse response,
							ModelAndView mv,
							HttpSession session
							) {
		
	// 암호화 후 로그인

	Member loginUser = memberService.selectMember(member);
	
	// 아이디만 일치 하는지 확인 체크
	
	// 비밀반호도 일치하는지 체크
	
	if(loginUser != null && bCryptPasswordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) { //로그인성공
		
		// 아이디 저장 체크 시
		if(loginCheck != null && loginCheck.equals("y")) {
						
			Cookie cookie = new Cookie("saveId", loginUser.getMemberId());
			cookie.setMaxAge(1 * 24 * 60 * 60);
			response.addCookie(cookie);
								
		} else { // 체크 안한 경우
								
			Cookie cookie = new Cookie("saveId", loginUser.getMemberId());
			cookie.setMaxAge(0);
			response.addCookie(cookie);
								
		};
		
		loginUser.setIdentifier("member");
		
		if(loginUser.getMemberId().equals("admin")) {
			loginUser.setIdentifier("root");
		}
		
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("alertMsg", "로그인에 성공했습니다."); //1회 알람문구
	
		mv.setViewName("redirect:/");
	}
	else { // 로그인 실패
		
		mv.addObject("errorMsg", "로그인 실패");
		mv.setViewName("common/error");
		
	}
	return mv;
	// 암호화 전
	/*
	Member loginUser = memberService.selectMember(member);
         
		
		// System.out.println(loginUser);
		
		if(loginUser == null) { // 실패
			
			mv.addObject("errorMsg","로그인 실패");
			
			mv.setViewName("common/error");
		}
		else { // 성공
			
			// session.setAttribute("loginUser", loginUser);
			// model.addAttribute("loginUser", loginUser);
			
			mv.setViewName("redirect:/");
		}
		return mv;
		*/
	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.invalidate();
		
		// 메인페이지로 url 재요청
		return "redirect:/";
	}
	
	// 회원가입 폼을 띄어주는 용도
	@RequestMapping("enrollForm.me")
	public String enrollForm() {
		
		// 회원가입 폼 띄어주기
		// /WEB-INF/views/user/member/memberEnrollForm.jsp
		
		return "user/member/memberEnrollForm";
	}
	
	// 회원가입 기능
	@RequestMapping("insert.me")
	public String insertMember(Member member, Model model, HttpSession session) {
		
// System.out.println("### MemberController : insertMember :: getMemberId = ["+ member.getMemberId() +"]");
// System.out.println("### MemberController : insertMember :: getMemberPwd = ["+ member.getMemberPwd() +"]");
// System.out.println("### MemberController : insertMember :: getMemberEmail = ["+ member.getMemberEmail() +"]");

		 // System.out.println(member);
		 
		 // 암호화 등록 완료 
		 
		// System.out.println("평문 : " + member.getMemberPwd());
		
		String encPwd = bCryptPasswordEncoder.encode(member.getMemberPwd());
		// System.out.println("암호화 : " + encPwd);
		
		member.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(member);
		
		if(result > 0) { // 성공
			
			// 1회성 알람메세지 
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");
			
			return "redirect:/";
		}
		else { // 실패
			
			model.addAttribute("errorMsg","회원가입 실패");
			return "common/error";
		}	
	}
	
	// 회원정보 수정 폼
	@RequestMapping("myPage.me")
	public String myPage() {
		
		// 회원정보 수정 폼 띄어주기
		return "user/member/myPage";
	}
	
	// 회원정보 수정
	@RequestMapping("update.me")
	public String updateMember(Member member, Model model, HttpSession session) {
		
		int result = memberService.updateMember(member);
		
		if(result > 0) {
			
		Member updateMem = memberService.selectMember(member);
			
		session.setAttribute("loginUser", updateMem);
		
		// 1회성 알람메세지 
		session.setAttribute("alertMsg", "회원정보가 수정 되었습니다.");
					
		return "redirect:myPage.me";
		}
		else {
			
			model.addAttribute("errorMsg", "회원정보 변경 실패");
			
			return "common/error";
		}
	}
	
	// 회원탈퇴 
	@RequestMapping("delete.me")
	public String deleteMemer(int memberNo, HttpSession session, Model model) {
		
		int result = memberService.deleteMember(memberNo);
		
		if(result > 0) { // 탈퇴 성공
			
			session.removeAttribute("loginUser");
			session.setAttribute("alertMsg", "성공적으로 탈퇴되었습니다.");
			
			return "redirect:/";
		}
		else { // 실패
			
			model.addAttribute("errorMsg", "회원 탈퇴 실패");
			
			return "common/error";
		}
	}
	
}