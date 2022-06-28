package com.kh.udongzip.member.model.service;

import java.util.ArrayList;

import com.kh.udongzip.member.model.vo.Member;

public interface MemberService {
	
	// 회원가입 : 개인회원
	int insertMember(Member member);
	
	// 로그인 : 개인회원
	Member selectMember(Member member);
	
	// 정보 수정 : 개인회원
	Member updateMember(Member member);
	
	// 비밀번호 수정 : 개인회원
	Member updatePwd(String newPwd);
	
	// 회원 탈퇴 (비밀번호 X) : 개인회원, 어드민
	int deleteMember(int memberNo);
	
	// 비밀번호 찾기 (이메일)
	
	// 개인회원 전체 조회 : 어드민
	ArrayList<Member> selectMemberList();
	
	// 개인회원 상세 조회 : 어드민
	Member selectMember(int memberNo);
	
}
