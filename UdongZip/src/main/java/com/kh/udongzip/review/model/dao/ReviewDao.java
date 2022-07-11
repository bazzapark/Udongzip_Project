package com.kh.udongzip.review.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.review.model.vo.RemoveRequest;
import com.kh.udongzip.review.model.vo.Review;

@Repository
public class ReviewDao {
	
	public ArrayList<Review> selectAgentReviewList(SqlSessionTemplate sqlSession, int agentNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectAgentReviewList", agentNo);
	}
	
	public int insertRequest(SqlSessionTemplate sqlSession, RemoveRequest request) {
		return sqlSession.insert("reviewMapper.insertRequest", request);
	}

}
