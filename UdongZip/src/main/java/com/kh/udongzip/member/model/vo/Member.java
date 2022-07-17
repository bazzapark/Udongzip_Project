package com.kh.udongzip.member.model.vo;

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
public class Member {
	
	private int memberNo;        // 개인회원 번호
	private String memberId;     // 개인회원 아이디
	private String memberPwd;    // 개인회원 비밀번호
	private String memberName;   // 개인회원 이름
	private String memberPhone;  // 개인회원 연락처
	private String memberEmail;  // 개인회원 이메일
	private String status;       // 활성화 여부
	
	// MEMBER 테이블에 없는 필드
	private String identifier;   // 식별자 (개인회원 : member, 업체회원 : agent)
	
}
