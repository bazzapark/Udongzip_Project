package com.kh.udongzip.cs.inquiry.model.service;

import java.util.ArrayList;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

public interface InquiryService {
	
	// 문의 등록 : 개인/업체 회원
	int insertInquiry(Inquiry inquiry);
	
	// 전체 조회 : 업체 회원
	ArrayList<Inquiry> selectAgentInquiryList(int agentNo);
	
	// 전체 조회 : 관리자 
	ArrayList<Inquiry> selectadminInquiryList(PageInfo pi);
	
	// 상세 조회 : 관리자/개인/업체 회원
	Inquiry selectInquiry(int inquiryNo);
	
	// 문의 삭제 : 개인/업체 회원
	int deleteInquiry(int inquiryNo);
	
	// 답변 등록 (수정) : 어드민
	int updateAnswer(Inquiry inquiry);

	// 문의 카운트 조회 : 관리자
	int selectListCount();
	
	/**
	* @version 1.0
	* @author 박경화
	 */
	// 페이징 
	int selectListCount(Member member);
	
	// 전체 조회 : 개인/업체 회원, 어드민
	ArrayList<Inquiry> selectInquiryList(PageInfo pi, Member member);

}
