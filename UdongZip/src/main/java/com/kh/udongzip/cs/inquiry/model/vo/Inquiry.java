package com.kh.udongzip.cs.inquiry.model.vo;

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
public class Inquiry {
	
	private int inquiryNo;         // 문의 번호
	private int memberNo;          // 작성자 (개인회원) 1    null
	private int agentNo;           // 작성자 (업체회원) null   1
	private String category;      // 카테고리
	private String title;          // 제목
	private String content;        // 내용
	private String createDate;     // 작성일
	private String answerContent;  // 답변
	private String answerDate;     // 답변일
	private String status;         // 활성화 여부
	
	// 테이블에 없는 필드
	private String memberName;
	private String agentName;
	private String memberId;
	private String agentId;

}
