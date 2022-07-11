package com.kh.udongzip.cs.inquiry.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;

@Repository
public class InquiryDao {
	
	public ArrayList<Inquiry> selectAgentInquiryList(SqlSessionTemplate sqlSession, int agentNo) {
		return (ArrayList)sqlSession.selectList("csMapper.selectAgentInquiryList", agentNo);
	}
	
	public Inquiry selectInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.selectOne("csMapper.selectInquiry", inquiryNo);
	}
	
	public int deleteInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		return sqlSession.update("csMapper.deleteInquiry", inquiryNo);
	}

}
