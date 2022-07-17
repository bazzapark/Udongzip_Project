package com.kh.udongzip.cs.inquiry.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

@Repository
public class InquiryDao {
	
	public ArrayList<Inquiry> selectAgentInquiryList(SqlSessionTemplate sqlSession, int agentNo) {
		return (ArrayList)sqlSession.selectList("csMapper.selectAgentInquiryList", agentNo);
	}
	
	// 상세 조회 : 관리자/개인/업체 회원
	public Inquiry selectInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.selectOne("csMapper.selectInquiry", inquiryNo);
	}
	
	public int deleteInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.update("csMapper.deleteInquiry", inquiryNo);
	}
	
	// 관리자 : 전체 조회
	public ArrayList<Inquiry> selectadminInquiryList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("csMapper.selectadminInquiryList", null, rowBounds);
	}
	
	// 관리자 : 답변
	public int updateAnswer(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.update("csMapper.updateAnswer", inquiry);
	}
	
	// 문의 작성 : 개인/업체 회원 
	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.insert("csMapper.insertInquiry", inquiry);
	}

	// 문의 카운트 조회 : 관리자 
	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("csMapper.selectListCount");
	}
	
	
	// 페이징
	public int selectListCount(SqlSessionTemplate sqlSession, Member member) {
		
		return sqlSession.selectOne("inquiryMapper.selectListCount", member);
	}

	// 1:1 문의 리스트 조회
	public ArrayList<Inquiry> selectList(SqlSessionTemplate sqlSession, PageInfo pi, Member member) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("inquiryMapper.selectList", member, rowBounds);
	}
	
}
