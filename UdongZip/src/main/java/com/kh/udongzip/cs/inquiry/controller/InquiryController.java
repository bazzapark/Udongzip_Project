package com.kh.udongzip.cs.inquiry.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.cs.inquiry.model.service.InquiryService;
import com.kh.udongzip.cs.inquiry.model.vo.Inquiry;

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

}
