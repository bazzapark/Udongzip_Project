package com.kh.udongzip.cs.inquiry.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

@Repository
public class InquiryDao {
	
	// 페이징
		
		return sqlSession.selectOne("inquiryMapper.selectListCount", member);
	}

	// 1:1 문의 리스트 조회
	public ArrayList<Inquiry> selectList(SqlSessionTemplate sqlSession, PageInfo pi, Member member) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("inquiryMapper.selectList", member, rowBounds);
	}
	
	// 1:1 문의 상세조회
	
	public Inquiry selectInquiry(SqlSessionTemplate sqlSession, int inquiryNo) {
		
		return sqlSession.selectOne("inquiryMapper.selectInquiry", inquiryNo);
	}
}
