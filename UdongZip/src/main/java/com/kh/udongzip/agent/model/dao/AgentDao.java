package com.kh.udongzip.agent.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.agent.model.vo.Agent;

@Repository
public class AgentDao {
	
	// 업체회원 회원가입
	public int insertAgent(SqlSessionTemplate sqlSession, Agent agent) {
		return sqlSession.insert("agentMapper.insertAgent", agent);
	}
	
	// 업체회원 로그인
	public Agent loginAgent(SqlSessionTemplate sqlSession, String agentId) {
		return sqlSession.selectOne("agentMapper.loginAgent", agentId);
	}

}
