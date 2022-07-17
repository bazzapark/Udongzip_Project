package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.reservation.model.vo.Reservation;

public interface ReservationService {
	
	// 페이징 - 박경화
	int selectListCount(int memberNo);
		
	// 내 예약 조회 - 박경화
	ArrayList<Reservation> selectReservationList(PageInfo pi, int memberNo);
	
	// 상세 조회 - 박경화
	Reservation selectReservation(int reservationNo);
	
	// 상담 예약
	int insertReservation(Reservation reservation);
	
	// 상태 변경
	int updateresult(Reservation reservation);
	

}
