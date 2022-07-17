package com.kh.udongzip.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.dao.ReviewDao;
import com.kh.udongzip.review.model.vo.RemoveRequest;
import com.kh.udongzip.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Review> selectReviewList(int memberNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Review selectReview(int reviewNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Review> selectAgentReviewList(int agentNo) {
		return reviewDao.selectAgentReviewList(sqlSession, agentNo);
	}

	@Override
	public int insertRequest(RemoveRequest request) {
		return reviewDao.insertRequest(sqlSession, request);
	}
	
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 업체 회원 리뷰 전체 조회 수 메소드
	@Override
	public int selectListCount(Member m) {
		return reviewDao.selectListCount(sqlSession, m);
	}
	
	// 업체 회원 리뷰 전체 조회 메소드
	@Override
	public ArrayList<Review> agentSelectReviewList(PageInfo pi, Member m) {
		return reviewDao.agentSelectReviewList(sqlSession, pi, m);
	}
	
	// 삭제 요청 전체 조회 메소드
	@Override
	public ArrayList<RemoveRequest> selectRequestList(PageInfo pi, HashMap<String, String> map) {
		return reviewDao.selectRequestList(sqlSession, pi, map);
	}
	
	// 삭제 요청 전체 조회 수 메소드
	@Override
	public int selectRequestListCount(HashMap<String, String> map) {
		return reviewDao.selectRequestListCount(sqlSession, map);
	}
	
	// 삭제 요청 상세 조회 메소드
	@Override
	public RemoveRequest selectRequest(int resquestNo) {
		return reviewDao.selectRequest(sqlSession, resquestNo);
	}
	
	// 리뷰 삭제 메소드
	@Override
	public int deleteReview(int reviewNo) {
		return reviewDao.deleteReview(sqlSession, reviewNo);
	}
	
	// 리뷰 삭제 요청 반려 메소드
	@Override
	public int updateRequest(RemoveRequest request) {
		return reviewDao.updateRequest(sqlSession, request);
	}
/**
 * 
 */

}
