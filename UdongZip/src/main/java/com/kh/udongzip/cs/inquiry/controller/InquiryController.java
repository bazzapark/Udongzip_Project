package com.kh.udongzip.cs.inquiry.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.cs.inquiry.model.service.InquiryService;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

@Controller
public class InquiryController {
	
	@Autowired
	private InquiryService inquiryService;
	
	/**
	* 업체회원 1:1 문의 내역 페이지 이동 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 1:1 문의 내역 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@RequestMapping("inquiry.ag")
	public String agentInquiryListView() {
		return "user/agent/agentInquiryListView";
	}
	
	/**
	* 업체회원 1:1 문의 내역 조회 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 조회하려는 업체회원 번호
	* @return 문의 목록
	*
	*/
	@Auth(role=Role.AGENT)
	@ResponseBody
	@PostMapping(value="agentListView.in", produces="applicatoin/json; charset=UTF-8")
	public String selectAgentInquiryList(int agentNo) {
		
		ArrayList<Inquiry> inquiryList = inquiryService.selectAgentInquiryList(agentNo);
		
		return new Gson().toJson(inquiryList);
		
	}
	
	/**
	* 업체회원 1:1 문의 상세 조회 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param inquiryNo
	* 		 조회하려는 문의 번호
	* @return 업체회원 문의 상세 정보 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("agentDetail.in")
	public String selectAgentInquiry(int inquiryNo,
									 Model model) {
		
		Inquiry inquiry = inquiryService.selectInquiry(inquiryNo);
		
		model.addAttribute("inquiry", inquiry);
		
		return "user/agent/agentInquiryDetailView";
		
	}
	
	/**
	* 업체회원 1:1 문의 삭제 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param inquiryNo
	* 		 삭제하려는 문의 번호
	* @return 업체회원 1:1 문의 내역 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("delete.in")
	public String deleteInquiry(int inquiryNo,
								Model model,
								HttpSession session) {
		
		int result = inquiryService.deleteInquiry(inquiryNo);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "문의가 삭제되었습니다.");
			
			return "redirect:inquiry.ag";
			
		} else {
			
			model.addAttribute("errorMsg", "문의 삭제에 실패습니다. 잠시 후 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
	}
	
	
	/**
	* 사용자 1:1 문의 작성 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 사용자 1:1 문의 작성 페이지
	*
	*/
	@Auth(role=Role.LOGINUSER)
	@RequestMapping("insert.in")
	public String insertInquiry(Inquiry inquiry, HttpSession session, Model model) {
		
		int result = inquiryService.insertInquiry(inquiry);
		
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "문의가 성공적으로 작성되었습니다.");
			
			return "redirect:faq.no";
		}
		else {
			
			model.addAttribute("errorMsg", "문의글 작성 실패");
			
			return "common/error";
		}
		
		
	}
	
	
	
	
	
	
	/**
	* 관리자 1:1 문의 내역 페이지 이동 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 업체회원 1:1 문의 전체조회 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("adminlist.in")
	public String selectinquiryList(
			@RequestParam(value="ipage", defaultValue="1") int currentPage
			,Model model) {
		
		int listCount = inquiryService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Inquiry> list = inquiryService.selectadminInquiryList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		System.out.println(list);
		
		return "admin/cs/inquiryListView";
	}
	
	/**
	* 관리자 1:1 문의 내역 페이지 상세 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 업체회원 1:1 문의 상세 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@ResponseBody
	@RequestMapping("admindetail.in")
	public Inquiry selectadminInquiry(int inquiryNo) {
		
		Inquiry i = inquiryService.selectInquiry(inquiryNo);
		
		return i;
	}
	
	/**
	* 관리자 1:1 문의 내역 페이지 답변 메소드
	*
	* @version 1.0
	* @author 홍민희
	* @return 업체회원 1:1 문의 내역 페이지
	*
	*/
	@Auth(role=Role.ADMIN)
	@RequestMapping("answerupdate.in")
	public String updateAnswer(Inquiry inquiry, HttpSession session, Model model) {
		
		System.out.println(inquiry);
		
		int result = inquiryService.updateAnswer(inquiry);
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "성공적으로 답변이 전송되었습니다.");
			
			return "redirect:adminlist.in";
		}
		else {
			
			model.addAttribute("errorMsg", "답변 전송 실패");
			
			return "common/error";
		}
		
	}
	
	// 일반회원 전체조회
	@Auth(role=Role.MEMBER)
	@RequestMapping ("inquirylist.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
	                         Model model, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginUser");
		
		int listCount = inquiryService.selectListCount(member);
		
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Inquiry> list = inquiryService.selectInquiryList(pi, member);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "user/inquiry/inquiryListView";
	}
	
	
	
	// 상세조회
	@Auth(role=Role.MEMBER)
	@RequestMapping("inquirydetail.bo") // inquiry
	public ModelAndView selectInquiry(@RequestParam (value="bno", defaultValue="1") int inquiryNo, ModelAndView mv) {
		
		Inquiry i = inquiryService.selectInquiry(inquiryNo);
		
		if(i != null) {
			
			mv.addObject("i", i).setViewName("user/inquiry/inquiryDetailView");
			
		}
		else {
			
			mv.addObject("errorMsg", "1:1문의 상세조회 실패").setViewName("common/error");
		}
		return mv;
	}
	
	@Auth(role=Role.MEMBER)
	@RequestMapping("inquiryDelete.bo")
	public String memberDeleteInquiry(int inquiryNo,
									  HttpSession session,
									  Model model) {
	
		int result = inquiryService.deleteInquiry(inquiryNo);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "문의가 삭제되었습니다.");
			
			return "redirect:inquirylist.bo";
			
		} else {
			
			model.addAttribute("errorMsg", "문의 삭제에 실패습니다. 잠시 후 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
		
	}
	

}
