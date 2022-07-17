package com.kh.udongzip.cs.inquiry.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.cs.inquiry.model.dao.InquiryDao;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

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
	public ArrayList<Inquiry> selectadminInquiryList(PageInfo pi) {
		return inquiryDao.selectadminInquiryList(sqlSession, pi);
	}

	// 관리자 : 카운트 조회
	@Override
	public int selectListCount() {
		return inquiryDao.selectListCount(sqlSession);
	}
	
	// 게시글 총 갯수 : 일반회원
	@Override
	public int selectListCount(Member member) {
		return inquiryDao.selectListCount(sqlSession, member);
	}
	
	// 1:1문의 리스트 조회 : 일반회원
	@Override
	public ArrayList<Inquiry> selectInquiryList(PageInfo pi, Member member) {
		
		return inquiryDao.selectList(sqlSession, pi, member);
	}
	


}
