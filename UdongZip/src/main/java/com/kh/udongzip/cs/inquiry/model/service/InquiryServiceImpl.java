package com.kh.udongzip.cs.inquiry.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.cs.inquiry.model.dao.InquiryDao;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	@Autowired
	private InquiryDao inquiryDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 문의 작성 : 개인/업체 회원 
	@Override
	public int insertInquiry(Inquiry inquiry) {
		return inquiryDao.insertInquiry(sqlSession, inquiry);
	}

	@Override
	public ArrayList<Inquiry> selectAgentInquiryList(int agentNo) {
		return inquiryDao.selectAgentInquiryList(sqlSession, agentNo);
	}

	// 상세 조회 : 관리자/개인/업체 회원
	@Override
	public Inquiry selectInquiry(int inquiryNo) {
		return inquiryDao.selectInquiry(sqlSession, inquiryNo);
	}

	@Override
	public int updateInquiry(Inquiry inquiry) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteInquiry(int inquiryNo) {
		return inquiryDao.deleteInquiry(sqlSession, inquiryNo);
	}

	// 관리자 : 답변
	@Override
	public int updateAnswer(Inquiry inquiry) {
		return inquiryDao.updateAnswer(sqlSession, inquiry);
	}

	@Override
	public ArrayList<Inquiry> selectInquiryList(int memberNo) {
		// TODO Auto-generated method stub
		return null;
	}

	// 관리자 : 조회
	@Override
	public ArrayList<Inquiry> selectadminInquiryList() {
		return inquiryDao.selectadminInquiryList(sqlSession);
	}


}
