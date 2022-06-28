package com.kh.udongzip.cs.faq.model.service;

import java.util.ArrayList;

import com.kh.udongzip.cs.faq.model.vo.Faq;

public interface FaqService {
	
	// 전체 조회 : 개인/업체 회원
	ArrayList<Faq> selectFaqList();

}
