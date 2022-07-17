package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.reservation.model.dao.ReservationDao;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	private ReservationDao reservationDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Reservation> selectReservationList(HashMap<String, Object> map) {
		return reservationDao.selectReservationList(sqlSession, map);
	}

	@Override
	public Reservation selectReservation(int reservationNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertReservation(Reservation reservation) {
		return reservationDao.insertReservation(sqlSession, reservation);
	}

	@Override
	public int updateResult(HashMap<String, Object> map) {
		return reservationDao.updateResult(sqlSession, map);
	}

}
