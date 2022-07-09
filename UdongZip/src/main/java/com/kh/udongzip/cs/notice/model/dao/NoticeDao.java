package com.kh.udongzip.cs.notice.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.cs.notice.model.vo.Notice;

@Repository
public class NoticeDao {
	
	// 공지사항 전체 조회
	public ArrayList<Notice> selectNoticeList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("csMapper.selectNoticeList");
	}
	
	// 공지사항 상세 조회
	public Notice selectNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("csMapper.selectNotice", noticeNo);
	}

}
