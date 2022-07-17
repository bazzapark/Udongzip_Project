package com.kh.udongzip.agent.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.agent.model.dao.AgentDao;
import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.common.model.vo.PageInfo;

@Service
public class AgentServiceImpl implements AgentService {
	
	@Autowired
	private AgentDao agentDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// id 중복 체크 서비스
	@Override
	public int agentIdCheck(String agentId) {
		return agentDao.agentIdCheck(sqlSession, agentId);
	}
	
	// email 중복 체크 서비스
	@Override
	public int agentEmailCheck(String email) {
		return agentDao.agentEmailCheck(sqlSession, email);
	}
	
	// 업체회원 회원가입 서비스
	@Override
	public int insertAgent(Agent agent) {
		return agentDao.insertAgent(sqlSession, agent);
	}

	// 업체회원 로그인 서비스
	@Override
	public Agent loginAgent(String agentId) {
		return agentDao.loginAgent(sqlSession, agentId);
	}

	@Override
	public int updateAgent(Agent agent) {
		return agentDao.updateAgent(sqlSession, agent);
	}
	
	// id로 회원 조회(비밀번호 재설정용)
	@Override
	public Agent findPwd(String agentId) {
		return agentDao.findPwd(sqlSession, agentId);
	}
	
	// 비밀번호 변경
	@Override
	public int updatePwd(Agent agent) {
		return agentDao.updatePwd(sqlSession, agent);
	}

	@Override
	public ArrayList<Agent> selectAgentList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Agent> selectPermissionList() {
		// TODO Auto-generated method stub
		return null;
	}

	// 회원정보 불러오기(상세조회)
	@Override
	public Agent selectAgent(int agentNo) {
		return agentDao.selectAgent(sqlSession, agentNo);
	}

	// 회원 탈퇴 처리
	@Override
	public int deleteAgent(int agentNo) {
		return agentDao.deleteAgent(sqlSession, agentNo);
		
		
	}
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 업체회원 전체 조회, 가입 미승인, 검색 필터 메소드 : 어드민
	@Override
	public ArrayList<Agent> selectAgentList(PageInfo pi, HashMap<String, String> map) {
		return agentDao.selectAgentList(sqlSession, pi, map);
	}
	
	// 업체회원 전체조회, 가입 미승인, 검색필터 수 메소드 : 어드민
	@Override
	public int selectListCount(HashMap<String, String> map) {
		return agentDao.selectListCount(sqlSession, map);
	}
	
	// 업체 회원 가입 승인, 탈퇴 처리 메소드 : 어드민
	@Override
	public int adminUpdate(Agent agent) {
		return agentDao.adminUpdate(sqlSession, agent);
	}

/**
 * 
 */

}
