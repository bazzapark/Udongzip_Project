package com.kh.udongzip.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	
	// 업체회원 보유 매물 조회 및 검색
	@Override
	public ArrayList<House> selectHouseList(HashMap<String, Object> map) {
		return houseDao.selectHouseList(sqlSession, map);
	}
	
	@Override
	public int updateSalesStatus(HashMap<String, Object> map) {
		return houseDao.updateSalesStatus(sqlSession, map);
	}

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
	
	

	@Override
	public int updateHouse(House house) {
		// TODO Auto-generated method stub
		return 0;
	}
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 매물 상세 조회 서비스
	@Override
	public House selectHouse(int houseNo) {
		return houseDao.selectHouse(sqlSession, houseNo);
	}
	
	// 매물 상세 조회 조회수 증가 서비스
	@Override
	public int updateCount(int houseNo) {
		return houseDao.updateCount(sqlSession, houseNo);
	}
	
	// 매물 옵션 조회 서비스
	@Override
	public String selectOptionInfo(int houseNo) {
		return houseDao.selectOptionInfo(sqlSession, houseNo);
	}
	
	// 옵션명 조회 서비스
	@Override
	public ArrayList<String> selectOptions(List<Integer> optionInfo) {
		return houseDao.selectOptions(sqlSession, optionInfo);
	}
	
	// 매물 관리비 조회 서비스
	@Override
	public String selectManageInfo(int houseNo) {
		return houseDao.selectManageInfo(sqlSession, houseNo);
	}
	
	// 관리비 항목명 조회 서비스
	@Override
	public ArrayList<String> selectManages(List<Integer> manageInfo) {
		return houseDao.selectManages(sqlSession, manageInfo);
	}
	
	// 매물 이미지 조회 서비스
	@Override
	public ArrayList<String> selectHouseImages(int houseNo) {
		return houseDao.selectHouseImages(sqlSession, houseNo);
	}
	
	// 매물 찜 조회 서비스
	@Override
	public int selectZzim(Map<String, Integer> map) {
		return houseDao.selectZzim(sqlSession, map);
	}
	
	// 매물 찜 추가 서비스
	@Override
	public int insertZzim(Map<String, Integer> map) {
		return houseDao.insertZzim(sqlSession, map);
	}
	
	// 매물 찜 삭제 서비스
	@Override
	public int deleteZzim(Map<String, Integer> map) {
		return houseDao.deleteZzim(sqlSession, map);
	}
/**
 * 
 */
	

}
