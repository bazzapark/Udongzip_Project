package com.kh.udongzip.review.model.vo;

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
public class Review {

	private int reviewNo;          // 리뷰 번호
	private int memberNo;          // 작성자
	private int agentNo;           // 대상 업체
	private int reservationNo;     // 예약 내역
	private String content;        // 리뷰 내용
	private String satisfied;      // 만족도 (만족/불만족)
	private String createDate;     // 작성일
	private String status;         // 활성화 여부
	
	// REVIEW 테이블에 없는 필드
	

}
