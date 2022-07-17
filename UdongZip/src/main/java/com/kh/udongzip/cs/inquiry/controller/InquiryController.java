package com.kh.udongzip.cs.inquiry.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.cs.inquiry.model.service.InquiryService;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;
import com.kh.udongzip.member.model.vo.Member;

@Controller 
public class InquiryController {
	
	
	// 전체조회
	@Autowired
	private InquiryService inquiryService;
	
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
}
