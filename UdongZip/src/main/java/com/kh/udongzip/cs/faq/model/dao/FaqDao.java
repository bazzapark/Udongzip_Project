package com.kh.udongzip.cs.faq.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.cs.faq.model.vo.Faq;

@Repository
public class FaqDao {

	public ArrayList<Faq> selectFaqList(SqlSessionTemplate sqlSession){
		
		return (ArrayList)sqlSession.selectList("csMapper.selectFaqList");
	}
	
}
