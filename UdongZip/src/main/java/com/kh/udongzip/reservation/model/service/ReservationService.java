package com.kh.udongzip.reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	int updateResult(HashMap<String, Object> mapn);
	
	ArrayList<Reservation> selectAgentReservationList(HashMap<String, Object> map);
	
	// 방금 예약한 번호 불러오기
	int selectNewReservation(int memberNo);
	
	// 예약 삭제
	int deleteReservation(int reservationNo);
	
	// 예약 수정
	int updateReservation(Reservation reservation);
	

}
