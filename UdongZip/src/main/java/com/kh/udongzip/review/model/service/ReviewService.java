package com.kh.udongzip.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.vo.RemoveRequest;
import com.kh.udongzip.review.model.vo.Review;

public interface ReviewService {
	
	// 내가 쓴 리뷰 전체 조회 : 개인 회원
	ArrayList<Review> selectReviewList(int memberNo);
	
	// 업체 리뷰 전체 조회
	ArrayList<Review> selectAgentReviewList(int agentNo);
	
	// 리뷰 상세 조회 : 개인회원
	Review selectReview(int reviewNo);
	
	
	// 삭제 요청 생성
	int insertRequest(RemoveRequest request);
	


/**
 * @version 1.0
 * @author 양아란
 */
	// 리뷰 전체 조회 수
	int selectListCount(Member m);
	
	// 업체 회원 리뷰 전체 조회
	ArrayList<Review> agentSelectReviewList(PageInfo pi, Member m);
	
	// 삭제 요청 목록 전체 조회 : 어드민
	ArrayList<RemoveRequest> selectRequestList(PageInfo pi, HashMap<String, String> map);
	
	// 삭제 요청 목록 전체 조회 수 : 어드민
	int selectRequestListCount(HashMap<String, String> map);
	
	// 리뷰 삭제 : 개인회원, 어드민
	int deleteReview(int reviewNo);
	
	// 삭제 요청 상세 정보 조회 : 어드민
	RemoveRequest selectRequest(int resquestNo);
	
	// 반려 처리 : 어드민
	int updateRequest(RemoveRequest request);
/**
 * 
 */
}
