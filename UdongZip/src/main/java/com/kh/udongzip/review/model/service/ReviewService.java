package com.kh.udongzip.review.model.service;

import java.util.ArrayList;

import com.kh.udongzip.review.model.vo.RemoveRequest;
import com.kh.udongzip.review.model.vo.Review;

public interface ReviewService {
	
	// 내가 쓴 리뷰 전체 조회 : 개인 회원
	ArrayList<Review> selectReviewList(int memberNo);
	
	// 리뷰 상세 조회 : 개인회원
	Review selectReview(int reviewNo);
	
	// 리뷰 삭제 : 개인회원, 어드민
	int deleteReview(int reviewNo);
	
	// 삭제 요청 목록 전체 조회 : 어드민
	ArrayList<Review> selectRequestList();
	
	// 삭제 요청 상세 정보 조회 : 어드민
	RemoveRequest selectRequest(int resquestNo);
	
	// 반려 처리 : 어드민
	int updateRequest(RemoveRequest request);

}
