package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.reservation.model.dao.ReservationDao;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDao reservationDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 페이징
	@Override
	public int selectListCount(int memberNo) {
		
		return reservationDao.selectListCount(sqlSession, memberNo);
	}
	
	// 예약 리스트 
	@Override
	public ArrayList<Reservation> selectReservationList(PageInfo pi, int memberNo) {
		
		return reservationDao.selectList(sqlSession, pi, memberNo);
	}

	// 예약 상세조회(모달)
	@Override
	public Reservation selectReservation(int reservationNo) {
		
		return reservationDao.selectReservation(sqlSession, reservationNo);
		
	}

	@Override
	public int insertReservation(Reservation reservation) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateresult(Reservation reservation) {
		// TODO Auto-generated method stub
		return 0;
	}

}
