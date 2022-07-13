package com.kh.udongzip.agent.model.service;

import java.util.ArrayList;

import com.kh.udongzip.agent.model.vo.Agent;

public interface AgentService {
	
	// agent ID 중복체크
	int agentIdCheck(String agentId);
	
	// agent Email 중복체크
	int agentEmailCheck(String email);
	
	// 업체회원 회원가입
	int insertAgent(Agent agent);
	
	// 로그인
	Agent loginAgent(String agentId);
	
	// 업체 정보 수정
	int updateAgent(Agent agent);
	
	// 비밀번호 변경
	int updatePwd(Agent agent);
	
	// 비밀번호 찾기 (이메일 발송)
	Agent findPwd(String agentId);
	
	// 전체 조회 : 어드민
	ArrayList<Agent> selectAgentList();
	
	// 가입 미승인 필터 : 어드민
	ArrayList<Agent> selectPermissionList();
	
	// 상세 조회 : 어드민
	Agent selectAgent(int agentNo);
	
	// 탈퇴 처리 : 업체회원, 어드민
	int deleteAgent(int agentNo);

}
