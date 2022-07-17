package com.kh.udongzip.member.model.service;

import java.util.ArrayList;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.member.model.vo.Member;

public interface MemberService {
	
	// Member ID 중복 체크
	int memberIdCheck(String checkId);
	
	// 회원가입 : 개인회원
	int insertMember(Member member);
	
	// 로그인 : 개인회원
	Member selectMember(Member member);
	
	// 정보 수정 : 개인회원
	int updateMember(Member member);
	
	// 비밀번호 수정 : 개인회원
	int updatePwd(Member member);
	
	// 회원 탈퇴 (비밀번호 X) : 개인회원, 어드민
	int deleteMember(int memberNo);
	
	// 비밀번호 찾기 (이메일)
	
	// 비밀번호 재설정
	Member findPwd(String memberId);
	
	// 개인회원 이메일 중복 체크
	int memberEmailCheck(String email);
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 개인회원 전체 조회 수 : 어드민
	int selectListCount(String keyword);
	
 	// 개인회원 전체 조회 : 어드민
	ArrayList<Member> selectMemberList(PageInfo pi, String keyword);
	
	// 개인회원 상세 조회 : 어드민
	Member selectMember(int memberNo);
/**
 * 
 */
}
