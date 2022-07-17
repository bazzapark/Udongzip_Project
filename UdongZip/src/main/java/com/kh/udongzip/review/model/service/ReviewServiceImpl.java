package com.kh.udongzip.review.model.service;

import java.util.ArrayList;

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
	
	// 게시글 총 갯수
	@Override
	public int selectListCount(Member member) {
			
		return reviewDao.selectListCount(sqlSession, member);
	}

	// 리뷰 리스트
	@Override
	public ArrayList<Review> selectReviewList(PageInfo pi, Member member) {
		
		return reviewDao.selectList(sqlSession, pi, member);
	}

	// 리뷰 상세보기
	@Override
	public Review selectReview(int reviewNo) {
		
		return reviewDao.selectReview(sqlSession, reviewNo);
	}

	// 리뷰삭제
	@Override
	public int deleteReview(int reviewNo) {
		
		return reviewDao.deleteReview(sqlSession, reviewNo);
	}

	@Override
	public ArrayList<Review> selectRequestList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RemoveRequest selectRequest(int resquestNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateRequest(RemoveRequest request) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 리뷰 작성
	@Override
	public int insertReview(Review review) {

		int result = reviewDao.insertReview(sqlSession, review);
		
		return result;
	}


}
