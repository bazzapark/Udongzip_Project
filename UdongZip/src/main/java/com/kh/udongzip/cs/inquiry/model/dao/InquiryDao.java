package com.kh.udongzip.cs.inquiry.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.cs.notice.model.vo.Notice;

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
	public ArrayList<Inquiry> selectadminInquiryList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("csMapper.selectadminInquiryList");
	}
	
	// 관리자 : 답변
	public int updateAnswer(SqlSessionTemplate sqlSession, Inquiry inquiry) {
		return sqlSession.update("csMapper.updateAnswer", inquiry);
	}
	
}
