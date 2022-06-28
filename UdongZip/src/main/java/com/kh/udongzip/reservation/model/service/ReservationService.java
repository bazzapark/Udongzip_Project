package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;

import com.kh.udongzip.reservation.model.vo.Reservation;

public interface ReservationService {
	
	// 내 예약 조회
	ArrayList<Reservation> selectReservationList(int memberNo);
	
	// 상세 조회
	Reservation selectReservation(int reservationNo);
	
	// 상담 예약
	int insertReservation(Reservation reservation);
	
	// 상태 변경
	int updateresult(Reservation reservation);

}
