package com.kh.udongzip.cs.notice.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.cs.notice.model.service.NoticeService;
import com.kh.udongzip.cs.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	/**
	* 관리자 공지사항 전체조회
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 리스트 페이지
	*
	*/
	@RequestMapping("adminlist.no")
	public String selectNoticeList(Model model) {
		
		ArrayList<Notice> list = noticeService.selectNoticeList();
		
		model.addAttribute("list", list);
		
		return "admin/cs/noticeListView";
	}
	
	/**
	* 회원 고객센터 공지사항 전체조회
	*
	* @version 1.0
	* @author 홍민희
	* @return 고객센터 공지사항 리스트 페이지
	*
	*/
	
	@ResponseBody
	@RequestMapping(value="list.no", produces="application/json; charset=UTF-8")
	public String selectuserList() {
		
		ArrayList<Notice> list = noticeService.selectNoticeList();
		
		return new Gson().toJson(list);
		
	}
	
	/**
	* 회원 고객센터 공지사항 상세조회
	*
	* @version 1.0
	* @author 홍민희
	* @return 고객센터 공지사항 리스트 상세페이지
	*
	*/
	@ResponseBody
	@RequestMapping("detail.no")
	public Notice selectNotice(int noticeNo) {
		Notice n = noticeService.selectNotice(noticeNo);
		return n;
	}
	
	
	
	
	
	
	
	
	
	
}
