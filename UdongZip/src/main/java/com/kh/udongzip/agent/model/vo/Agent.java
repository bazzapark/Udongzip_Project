package com.kh.udongzip.agent.model.vo;

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
public class Agent {
	
	private int agentNo;         // 업체회원 번호
	private String agentId;      // 업체회원 아이디
	private String agentPwd;     // 업체회원 비밀번호
	private String agentName;    // 업체명
	private String agentEmail;   // 업체 이메일
	private String agentPhone;   // 업체 연락처
	private String agentAddress; // 업체 주소
	private String introduce;    // 업체 소개글
	private String status;       // 활성화 여부
	private String permission;   // 가입 승인 여부
	private String companyNo;    // 사업자등록번호
	private String ceoName;      // 대표자명
	private String document1;    // 사업자등록증 이미지 파일 경로
	private String document2;    // 중개사등록증 이미지 파일 경로
	
	// AGENT 테이블에 없는 필드
	private String identifier;   // 식별자 (개인회원 : member, 업체회원 : agent)

}
