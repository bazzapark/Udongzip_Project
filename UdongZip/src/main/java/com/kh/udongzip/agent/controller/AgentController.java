 package com.kh.udongzip.agent.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	public String Idchek(String agentId) {
		
		int agentIdCount = agentService.agentIdCheck(agentId);
		
		int memberIdCount = memberService.memberIdCheck(agentId);
			
		return ((agentIdCount + memberIdCount) > 0) ? "NNNNN" : "NNNNY";
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
							 HttpSession session) {
		
		Agent loginUser = agentService.loginAgent(agentId);
		
		if(loginUser != null && bCryptPasswordEncoder.matches(agentPwd, loginUser.getAgentPwd())) {
			
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
	@RequestMapping("updateForm.ag")
	public String agentUpdateForm() {
		return "user/agent/agentUpdateForm";
	}
	
	/**
	* 업체회원 회원정보 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agent
	* 		 업체회원 정보가 담긴 객체
	* @return 업체회원 회원정보 페이지
	*
	*/
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


}
