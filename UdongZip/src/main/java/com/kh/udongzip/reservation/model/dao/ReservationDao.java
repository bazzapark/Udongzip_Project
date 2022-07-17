package com.kh.udongzip.reservation.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {

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
}
