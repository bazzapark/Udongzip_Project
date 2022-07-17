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
public class RemoveRequest {
	
	private int requestNo;       // 요청 번호
	private int agentNo;         // 요청 업체
	private int reviewNo;        // 삭제 요청 리뷰
	private String reason;       // 요청 사유
	private String requestDate;  // 요청일
	private String result;       // 처리결과 (삭제/반려/대기)
	
	// 없는 필드
	private String agentName;	 // 요청 업체명
	private String memberId; 	 // 작성자 회원 아이디
	private String satisfied;	 // 만족도
	private String createDate;	 // 리뷰 작성일

}
