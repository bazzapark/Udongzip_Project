package com.kh.udongzip.agent.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.agent.model.dao.AgentDao;
import com.kh.udongzip.agent.model.vo.Agent;

@Service
public class AgentServiceImpl implements AgentService {
	
	@Autowired
	private AgentDao agentDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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
	public Agent updateAgent(Agent agent) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Agent updatePwd(String newPwd) {
		// TODO Auto-generated method stub
		return null;
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

	@Override
	public Agent selectAgent(int agentNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteAgent(int agentNo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
