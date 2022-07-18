package com.kh.udongzip.cs.notice.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
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
	@Auth(role=Role.ADMIN)
	@RequestMapping("adminlist.no")
	public String selectNoticeList(Model model) {
		
		ArrayList<Notice> list = noticeService.selectNoticeList();
		
		model.addAttribute("list", list);
		
		return "admin/cs/noticeListView";
	}
	
	/**
	* 관리자 공지사항 작성 화면
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 작성 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("enrollForm.no")
	public String enrollFormNotice() {
		
		return "admin/cs/noticeEnrollForm";
	}
	
	/**
	* 관리자 공지사항 작성 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 작성 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("insert.no")
	public String insertNotice(Notice notice, HttpSession session, Model model) {
		
		int result = noticeService.insertNotice(notice);
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 작성되었습니다.");
			
			return "redirect:adminlist.no";
		}
		else {
			
			model.addAttribute("errorMsg", "게시글 작성 실패");
			
			return "common/error";
		}
		
	}
	
	/**
	* 관리자 공지사항 상세 화면
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 상세 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("updateForm.no")
	public String updateForm(int nno, Model model) {
		
		// 해당 게시글의 상세조회 요청
		Notice n = noticeService.selectNotice(nno);
		
		// Model 에 데이터 담기
		model.addAttribute("n", n);
		
		// 수정하기 페이지 포워딩
		return "admin/cs/noticeUpdateForm";
	}
	
	
	/**
	* 관리자 공지사항 수정 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 수정 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("update.no")
	public String updateNotice(Notice notice, HttpSession session, Model model) {
		
		int result = noticeService.updateNotice(notice);
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			return "redirect:adminlist.no";
		}
		else {
			
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/error";
		}
		
	}
	
	
	/**
	* 관리자 고객센터 공지사항 삭제
	*
	* @version 1.0
	* @author 홍민희
	* @return 관리자 공지사항 리스트 전체페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("delete.no")
	public String deleteNotice(@RequestParam("delList") List<Integer> list,
			 					HttpSession session, Model model) {
		
		System.out.println(list);
		
		int count = 0;
		
		for(Integer nno : list) noticeService.deleteNotice(nno);

		for(int i = 0; i < list.size(); i++) {
			
			int result = noticeService.deleteNotice(list.get(i));
			
			count = result+count;
		}
		
		if(list.size() == count) {
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:adminlist.no";
			
		}
		else {

			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/error";
		}
		
		
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
