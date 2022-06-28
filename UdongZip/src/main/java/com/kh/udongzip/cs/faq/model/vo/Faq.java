package com.kh.udongzip.cs.faq.model.vo;

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
public class Faq {

	private int faqNo;       // faq 번호
	private String title;    // 제목
	private String content;  // 내용
	private String status;   // 활성화 여부
	
}
