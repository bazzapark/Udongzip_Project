package com.kh.udongzip.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.house.model.vo.House;

@Repository
public class HouseDao {
	
	// agent 내 매물 리스트 조회 및 검색
	public ArrayList<House> selectHouseList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectHouseList", map);
	}
	
	// 매물 계약상태 변경
	public int updateSalesStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("houseMapper.updateSalesStatus", map);
	}

}
