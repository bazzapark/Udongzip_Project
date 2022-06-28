package com.kh.udongzip.reservation.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Reservation {
	
	private int reservationNo;        // 예약 번호
	private int memberNo;             // 예약자
	private int agentNo;              // 문의 업체
	private int houseNo;              // 문의 매물
	private String reservationDate;   // 예약일 (방문 예정일)
	private String reservationTime;   // 예약시간 (방문 예정시간)
	private String content;           // 사전 문의사항
	private String result;            // 방문 결과 (방문 대기 / 예약 취소 / 방문 완료 / 미방문(노쇼))
	private String deposit;           // 예약금 결제 상태 (결제 완료 / 환불 완료 / 환불 불가)
	private String createDate;        // 예약 생성일

}
