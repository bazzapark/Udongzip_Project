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
	
	// 게시글 총 갯수
	@Override
	public int selectListCount(Member member) {
		return inquiryDao.selectListCount(sqlSession, member);
	}
	
	// 1:1문의 리스트 조회
	@Override
	public ArrayList<Inquiry> selectInquiryList(PageInfo pi, Member member) {
		
		return inquiryDao.selectList(sqlSession, pi, member);
	}

	
	@Override
	public int insertInquiry(Inquiry inquiry) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 1:1 문의 상세조회 
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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateAnswer(Inquiry inquiry) {
		// TODO Auto-generated method stub
		return 0;
	}


}
