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
	// 리뷰 전체 조회수
	public int selectListCount(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("reviewMapper.selectListCount", m);
	}
	
	// 리뷰 전체 조회
	public ArrayList<Review> agentSelectReviewList(SqlSessionTemplate sqlSession, PageInfo pi, Member m) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("reviewMapper.agentSelectReviewList", m, rowBounds);
	}
	
	// 삭제 요청 전체 조회
	public ArrayList<RemoveRequest> selectRequestList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("reviewMapper.selectRequestList", map, rowBounds);
	}
	
	// 삭제 요청 전체 조회 수
	public int selectRequestListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("reviewMapper.selectReuqestListCount", map);
	}
	
	// 삭제 요청 상세 조회
	public RemoveRequest selectRequest(SqlSessionTemplate sqlSession, int requestNo) {
		return sqlSession.selectOne("reviewMapper.selectRequest", requestNo);
	}
	
	// 리뷰 삭제
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
	// 삭제 요청 반려
	public int updateRequest(SqlSessionTemplate sqlSession, RemoveRequest request) {
		return sqlSession.update("reviewMapper.updateRequest", request);
	}
/**
 * 
 */

}
