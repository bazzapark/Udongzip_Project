package com.kh.udongzip.reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {
	
	public ArrayList<Reservation> selectReservationList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservationList", map);
	}
	
	public int updateResult(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("reservationMapper.updateResult", map);
	}

}
