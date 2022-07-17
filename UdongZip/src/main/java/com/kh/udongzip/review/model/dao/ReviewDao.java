package com.kh.udongzip.review.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;
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
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 리뷰 전체 조회수 : 개인 회원
	public int selectListCount(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("reviewMapper.selectListCount", m);
	}
	
	// 리뷰 전체 조회 : 개인 회원
	public ArrayList<Review> agentSelectReviewList(SqlSessionTemplate sqlSession, PageInfo pi, Member m) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("reviewMapper.agentSelectReviewList", m, rowBounds);
	}
	
	// 리뷰 삭제 요청 전체 조회 : 어드민
	public ArrayList<RemoveRequest> selectRequestList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("reviewMapper.selectRequestList", map, rowBounds);
	}
	
	// 리뷰 삭제 요청 전체 조회 수 : 어드민
	public int selectRequestListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("reviewMapper.selectReuqestListCount", map);
	}
	
	// 리뷰 삭제 요청 상세 조회 : 어드민
	public RemoveRequest selectRequest(SqlSessionTemplate sqlSession, int requestNo) {
		return sqlSession.selectOne("reviewMapper.selectRequest", requestNo);
	}
	
	// 리뷰 삭제 : 개인회원, 어드민
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
	// 리뷰 삭제 요청 반려 : 어드민
	public int updateRequest(SqlSessionTemplate sqlSession, RemoveRequest request) {
		return sqlSession.update("reviewMapper.updateRequest", request);
	}
/**
 * 
 */
	
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
	
	// 리뷰작성
	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
		
		return sqlSession.insert("reviewMapper.insertReview", review);
	}
}
