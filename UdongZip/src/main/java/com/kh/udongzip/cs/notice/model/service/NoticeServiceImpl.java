package com.kh.udongzip.cs.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.cs.notice.model.dao.NoticeDao;
import com.kh.udongzip.cs.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 공지사항 전체 조회
	@Override
	public ArrayList<Notice> selectNoticeList() {
		return noticeDao.selectNoticeList(sqlSession);
	}

	// 공지사항 상세 조회
	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}

	// 공지사항 작성 
	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(sqlSession, notice);
	}

	// 공지사항 수정
	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(sqlSession, notice);
	}

	// 공지사항 삭제
	@Override
	public int deleteNotice(Integer noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

}
