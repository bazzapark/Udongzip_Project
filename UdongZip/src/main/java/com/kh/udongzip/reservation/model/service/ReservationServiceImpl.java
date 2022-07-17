package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	public ArrayList<Reservation> selectAgentReservationList(HashMap<String, Object> map) {
		return reservationDao.selectReservationList(sqlSession, map);

	}

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
		return reservationDao.insertReservation(sqlSession, reservation);
	}

	@Override
	public int updateResult(HashMap<String, Object> map) {
		return reservationDao.updateResult(sqlSession, map);
	}
	

	// 방금 예약한 번호 불러오기
	@Override
	public int selectNewReservation(int memberNo) {
		return reservationDao.selectNewReservation(sqlSession, memberNo);
	}
	
	// 예약 삭제
	@Override
	public int deleteReservation(int reservationNo) {
		return reservationDao.deleteReservation(sqlSession, reservationNo);
	}
	
	// 예약 변경
	@Override
	public int updateReservation(Reservation reservation) {
		return reservationDao.updateReservation(sqlSession, reservation);
	}

}
