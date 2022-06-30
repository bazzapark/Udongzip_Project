package com.kh.udongzip.agent.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.udongzip.agent.model.vo.Agent;

@Controller
public class AgentController {
	
	@RequestMapping("enrollForm.ag")
	public String agentEnrollForm() {
		return "user/agent/agentEnrollForm";
	}
	
	/**
	* 전달 받은 파일 리네임 후 저장해야함
	*
	* @version 1.0
	* @author 박민규
	* @param Agent agent 회원가입 정보가 담긴 agent 객체
	* @return alrertMsg와 함께 메인 페이지로 redirect
	*
	*/
	@PostMapping("insert.ag")
	public String insertAgent(Agent agent, HttpSession session) {
		
		
		
		
		return "redirect:/";
		
	}

}
