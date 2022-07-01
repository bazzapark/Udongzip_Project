package com.kh.udongzip.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
	
	// Member ID 중복 체크 확인
	public int memberIdCheck(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.memberIdCheck", memberId);
	}

}
