package com.kh.udongzip.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.house.model.dao.HouseDao;
import com.kh.udongzip.house.model.vo.House;

@Service
public class HouseServiceImpl implements HouseService {
	
	@Autowired
	private HouseDao houseDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<House> houseMapList() {

		return houseDao.houseMapList(sqlSession);
	}

	@Override
	public ArrayList<House> houseFilter(Map<String, String> filter) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<House> houseSearch(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public House selectHouse(int houseNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertZzim(int houseNo, int memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteZzim(int houseNo, int memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateReportCount(int houseNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<House> selectReportHouse() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteHouse(int houseNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertHouse(House house) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 업체회원 보유 매물 조회 및 검색
	@Override
	public ArrayList<House> selectHouseList(HashMap<String, Object> map) {
		return houseDao.selectHouseList(sqlSession, map);
	}

	@Override
	public int updateHouse(House house) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateSalesStatus(HashMap<String, Object> map) {
		return houseDao.updateSalesStatus(sqlSession, map);
	}

}
