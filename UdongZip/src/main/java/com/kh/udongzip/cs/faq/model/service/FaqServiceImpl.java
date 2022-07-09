package com.kh.udongzip.cs.faq.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.cs.faq.model.dao.FaqDao;
import com.kh.udongzip.cs.faq.model.vo.Faq;

@Service
public class FaqServiceImpl implements FaqService {
	
	@Autowired
	private FaqDao faqDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Faq> selectFaqList() {
		
		return faqDao.selectFaqList(sqlSession);
	}
	
}
