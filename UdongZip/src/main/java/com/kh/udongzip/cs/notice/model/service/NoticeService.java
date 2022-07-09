package com.kh.udongzip.cs.notice.model.service;

import java.util.ArrayList;

import com.kh.udongzip.cs.notice.model.vo.Notice;

public interface NoticeService {
	
	// 목록 전체 조회 : 개인/업체회원/어드민
	ArrayList<Notice> selectNoticeList();
	
	
	// 상세 조회 : 개인/업체회원/어드민
	Notice selectNotice(int noticeNo);
	
	// 등록 : 어드민
	int insertNotice(Notice notice);
	
	// 수정 : 어드민
	int updateNotice(Notice notice);
	
	// 삭제 : 어드민
	int deleteNotice(int noticeNo);
	
	

}
