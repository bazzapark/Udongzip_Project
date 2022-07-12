package com.kh.udongzip.cs.inquiry.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;

public interface InquiryService {
	
	// 문의 등록 : 개인/업체 회원
	int insertInquiry(Inquiry inquiry);
	
	// 전체 조회 : 업체 회원
	ArrayList<Inquiry> selectAgentInquiryList(int agentNo);
	
	// 전체 조회 : 개인 회원
	ArrayList<Inquiry> selectInquiryList(int memberNo);
	
	// 전체 조회 : 관리자 
	ArrayList<Inquiry> selectadminInquiryList();
	
	// 상세 조회 : 관리자/개인/업체 회원
	Inquiry selectInquiry(int inquiryNo);
	
	// 문의 수정 : 개인/업체 회원
	int updateInquiry(Inquiry inquiry);
	
	// 문의 삭제 : 개인/업체 회원
	int deleteInquiry(int inquiryNo);
	
	// 답변 등록 (수정) : 어드민
	int updateAnswer(Inquiry inquiry);

}
