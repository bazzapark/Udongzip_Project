package com.kh.udongzip.cs.notice.model.vo;

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
public class Notice {
	
	private int noticeNo;       // 공지사항 번호
	private String title;       // 공지사항 제목
	private String content;     // 공지사항 내용
	private String createDate;  // 작성일
	private String status;      // 활성화 여부

}
