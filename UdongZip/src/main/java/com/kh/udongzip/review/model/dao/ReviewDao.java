package com.kh.udongzip.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.vo.Review;

@Repository
public class ReviewDao {

	// 페이징
	public int selectListCount(SqlSessionTemplate sqlSession, Member member) {
		
		return sqlSession.selectOne("reviewMapper.selectListCount", member);
	}
	
	// 페이징 리뷰리스트
	public ArrayList<Review> selectList(SqlSessionTemplate sqlSession, PageInfo pi, Member member) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectList", member, rowBounds);
	}
	
	// 리뷰 상세보기
	public Review selectReview(SqlSessionTemplate sqlSession, int revewNo) {
		
		return sqlSession.selectOne("reviewMapper.selectReview", revewNo);
		
	}
	
	// 리뷰삭제
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
	// 리뷰작성
	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
		
		return sqlSession.insert("reviewMapper.insertReview", review);
	}
}
