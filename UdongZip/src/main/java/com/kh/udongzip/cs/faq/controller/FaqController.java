package com.kh.udongzip.cs.faq.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.udongzip.cs.faq.model.service.FaqService;
import com.kh.udongzip.cs.faq.model.vo.Faq;

@Controller
public class FaqController {
	
	@Autowired
	private FaqService faqService;
	
	/**
	* 회원 고객센터 FAQ 전체조회
	*
	* @version 1.0
	* @author 홍민희
	* @return 회원 FAQ 페이지
	*
	*/
	
	@RequestMapping(value="faq.no")
	public String selectFaqList(Model model) {
		
		ArrayList<Faq> list = faqService.selectFaqList();
		
		model.addAttribute("list", list);
		
		
		return "user/cs/serviceListView";
		
	}

}
