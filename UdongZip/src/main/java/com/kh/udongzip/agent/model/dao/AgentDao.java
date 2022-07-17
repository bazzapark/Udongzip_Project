package com.kh.udongzip.agent.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.common.model.vo.PageInfo;

@Repository
public class AgentDao {
	
	// Agent 테이블 ID 중복 체크
	public int agentIdCheck(SqlSessionTemplate sqlSession, String agentId) {
		return sqlSession.selectOne("agentMapper.agentIdCheck", agentId);
	}
	
	// Agent 테이블 email 중복 체크
	public int agentEmailCheck(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("agentMapper.agentEmailCheck", email);
	}
	
	// 업체회원 회원가입
	public int insertAgent(SqlSessionTemplate sqlSession, Agent agent) {
		return sqlSession.insert("agentMapper.insertAgent", agent);
	}
	
	// 업체회원 로그인
	public Agent loginAgent(SqlSessionTemplate sqlSession, String agentId) {
		return sqlSession.selectOne("agentMapper.loginAgent", agentId);
	}
	
	// 업체회원 정보 수정
	public int updateAgent(SqlSessionTemplate sqlSession, Agent agent) {
		return sqlSession.update("agentMapper.updateAgent", agent);
	}
	
	// 업체회원 정보 조회 (상세조회)
	public Agent selectAgent(SqlSessionTemplate sqlSession, int agentNo) {
		return sqlSession.selectOne("agentMapper.selectAgent", agentNo);
	}
	
	// 업체회원 탈퇴
	public int deleteAgent(SqlSessionTemplate sqlSession, int agentNo) {
		return sqlSession.update("agentMapper.deleteAgent", agentNo);
	}
	
	// id로 회원 조회 (비밀번호 재설정용)
	public Agent findPwd(SqlSessionTemplate sqlSession, String agentId) {
		return sqlSession.selectOne("agentMapper.findPwd", agentId);
	}
	
	// 비밀번호 변경
	public int updatePwd(SqlSessionTemplate sqlSession, Agent agent) {
		return sqlSession.update("agentMapper.updatePwd", agent);
	}
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 업체회원 전체 조회, 가입 미승인, 검색 필터
	public ArrayList<Agent> selectAgentList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("agentMapper.selectAgentList", map, rowBounds);
	}
	
	// 업체회원 전체조회, 가입 미승인 업체 회원 전체 조회 수
	public int selectListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("agentMapper.selectListCount", map);
	}
	
	// 업체 회원 가입 승인, 탈퇴 처리
	public int adminUpdate(SqlSessionTemplate sqlSession, Agent agent) {
		return sqlSession.update("agentMapper.adminUpdate", agent);
	}
/**
 * 
 */

}
