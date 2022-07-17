package com.kh.udongzip.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.member.model.dao.MemberDao;
import com.kh.udongzip.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 회원가입
	@Override
	public int insertMember(Member member) {
		
		int result = memberDao.insertMember(sqlSession, member);
		
		return result;
	}
     
	// 로그인
	@Override 
	public Member selectMember(Member member) {
		
		// 어렵구낭...
		Member loginUser = memberDao.loginMember(sqlSession, member);
		
		return loginUser;
	}

	// 회원정보 수정
	@Override
	public int updateMember(Member member) {

		return memberDao.updateMember(sqlSession, member);
	}

	// 비밀번호 변경
	@Override
	public int updatePwd(Member member ) {

		return 0;
	}

	// 회원 탈퇴
	@Override
	public int deleteMember(int memberNo) {

		return memberDao.deleteMember(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member selectMember(int memberNo) {
		// TODO Auto-generated method stub
		return null;
	}

	// 아이디 중복 체크
	@Override
	public int memberIdCheck(String checkId) {

		return memberDao.idCheck(sqlSession, checkId);
	}
	
	// 비밀번호 체크 
	
}
