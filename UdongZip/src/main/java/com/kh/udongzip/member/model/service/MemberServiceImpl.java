package com.kh.udongzip.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.common.model.vo.PageInfo;
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

	// 회원 탈퇴
	@Override
	public int deleteMember(int memberNo) {

		return memberDao.deleteMember(sqlSession, memberNo);
	}

	// Member ID 중복 체크 확인
	@Override
	public int memberIdCheck(String memberId) {
		return memberDao.memberIdCheck(sqlSession, memberId);
	}
	
	// id로 회원 조회 (비밀번호 재설정용)
	@Override
	public Member findPwd(String memberId) {
		return memberDao.findPwd(sqlSession, memberId);
	}
	
	// 비밀번호 변경
	@Override
	public int updatePwd(Member member) {
		return memberDao.updatePwd(sqlSession, member);
	}

	@Override
	public int memberEmailCheck(String email) {
		return memberDao.memberEmailCheck(sqlSession, email);
	}
	
	/**
	 * @version 1.0
	 * @author 양아란
	 */
		// 개인 회원 전체 조회 수 메소드
		@Override
		public int selectListCount(String keyword) {
			return memberDao.selectListCount(sqlSession, keyword);
		}
		
		// 개인 회원 전체 조회 메소드
		@Override
		public ArrayList<Member> selectMemberList(PageInfo pi, String keyword) {
			return memberDao.selectMemberList(sqlSession, pi, keyword);
		}

		// 개인 회원 상세 조회 메소드
		@Override
		public Member selectMember(int memberNo) {
			return memberDao.selectMember(sqlSession, memberNo);
		}
		
}
