package com.kh.udongzip.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public int deleteReview(int reviewNo) {
		// TODO Auto-generated method stub
		return 0;
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

	@Override
	public ArrayList<Review> selectAgentReviewList(int agentNo) {
		return reviewDao.selectAgentReviewList(sqlSession, agentNo);
	}

	@Override
	public int insertRequest(RemoveRequest request) {
		return reviewDao.insertRequest(sqlSession, request);
	}

}
