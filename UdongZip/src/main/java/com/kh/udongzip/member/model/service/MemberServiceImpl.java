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
	
	// Member ID 중복 체크 확인
	@Override
	public int memberIdCheck(String memberId) {
		return memberDao.memberIdCheck(sqlSession, memberId);
	}

	@Override
	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member selectMember(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member updateMember(Member member) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member updatePwd(String newPwd) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteMember(int memberNo) {
		// TODO Auto-generated method stub
		return 0;
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

}
