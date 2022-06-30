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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.udongzip.agent.model.service.AgentService;
import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.common.template.SaveFileRename;

@Controller
public class AgentController {
	
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
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
		
		System.out.println(agent);
		System.out.println(document);
		
		String encPwd = bCryptPasswordEncoder.encode(agent.getAgentPwd());
		
		agent.setAgentPwd(encPwd);
		
		ArrayList<String> changeNames = new ArrayList<>();
		
		for(int i = 0; i < document.size(); i++) {
			
			changeNames.add(new SaveFileRename().saveDocument(agent.getAgentName(), document.get(i), session));
			
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

}
