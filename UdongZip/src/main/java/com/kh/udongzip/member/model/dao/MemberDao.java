package com.kh.udongzip.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.member.model.vo.Member;

@Repository
public class MemberDao {

	// 로그인
	public Member loginMember(SqlSessionTemplate sqlSession, Member member) {
		
		return sqlSession.selectOne("memberMapper.loginMember", member);
	}
	
	// 회원가입
	public int insertMember(SqlSessionTemplate sqlSession, Member member) {
			
			return sqlSession.insert("memberMapper.insertMember", member);
		}
	
	// 회원정부 수정
	public int updateMember(SqlSessionTemplate sqlSession, Member member) {
		
		return sqlSession.update("memberMapper.updateMember", member);
	}
	
	// 회원 탈퇴
	public int deleteMember(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.update("memberMapper.deletemember", memberNo);
	}
	
	// Member ID 중복 체크 확인
	public int memberIdCheck(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.memberIdCheck", memberId);
	}

	// Member pwd 재설정
	public Member findPwd(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.findPwd", memberId);
	}
	
	public int updatePwd(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("memberMapper.updatePwd", member);
	}
	
	
}
