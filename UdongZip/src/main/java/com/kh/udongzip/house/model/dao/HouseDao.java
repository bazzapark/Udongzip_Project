package com.kh.udongzip.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	// 지도 / 매물 전체조회
	public ArrayList<House> houseMapList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("houseMapper.houseMapList");
	}
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 매물 상세 조회
	public House selectHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("houseMapper.selectHouse", houseNo);
	}
	
	// 매물 상세 조회 조회수 증가
	public int updateCount(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.update("houseMapper.updateCount", houseNo);
	}
	
	// 매물 옵션 조회
	public String selectOptionInfo(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("houseMapper.selectOptionInfo", houseNo);
	}
	
	// 옵션명 조회
	public ArrayList<String> selectOptions(SqlSessionTemplate sqlSession, List<Integer> optionInfo) {
		return (ArrayList) sqlSession.selectList("houseMapper.selectOptions", optionInfo);
	}
	
	// 매물 관리비 조회
	public String selectManageInfo(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("houseMapper.selectManageInfo", houseNo);
	}
	
	// 관리비 항목명 조회
	public ArrayList<String> selectManages(SqlSessionTemplate sqlSession, List<Integer> manageInfo) {
		return (ArrayList) sqlSession.selectList("houseMapper.selectManages", manageInfo);
	}
	
	// 매물 이미지 조회
	public ArrayList<String> selectHouseImages(SqlSessionTemplate sqlSession, int houseNo) {
		return (ArrayList) sqlSession.selectList("houseMapper.selectHouseImages", houseNo);
	}
	
	// 매물 찜 조회
	public int selectZzim(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.selectOne("houseMapper.selectZzim", map);
	}
	
	// 매물 찜 추가
	public int insertZzim(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.insert("houseMapper.insertZzim", map);
	}
	
	// 매물 찜 삭제
	public int deleteZzim(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.delete("houseMapper.deleteZzim", map);
	}
/**
 * 
 */


}
