package com.kh.udongzip.reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {
	
	public ArrayList<Reservation> selectReservationList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservationList", map);
	}
	
	public int updateResult(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("reservationMapper.updateResult", map);
	}
	
	public int insertReservation(SqlSessionTemplate sqlSession, Reservation reservation) {
		return sqlSession.insert("reservationMapper.insertReservation", reservation);
	}

	// 페이징
	public int selectListCount(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.selectOne("reservationMapper.selectListCount", memberNo);
	}
	
	// 전체조회
	public ArrayList<Reservation> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectList", memberNo, rowBounds);
	}
	
	// 상세조회(모달)
	public Reservation selectReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		
		return sqlSession.selectOne("reservationMapper.selectReservation", reservationNo);
	}
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 방금 예약한 번호 불러오기 : 개인 회원
	public int selectNewReservation(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reservationMapper.selectNewReservation", memberNo);
	}
	
	// 예약 삭제 : 개인 회원
	public int deleteReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.delete("reservationMapper.deleteReservation", reservationNo);
	}
	
	// 예약 변경 : 개인 회원
	public int updateReservation(SqlSessionTemplate sqlSession, Reservation reservation) {
		return sqlSession.update("reservationMapper.updateReservation", reservation);
	}
/**
 * 
 */
}
