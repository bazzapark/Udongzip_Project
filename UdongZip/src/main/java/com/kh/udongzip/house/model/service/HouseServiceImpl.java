package com.kh.udongzip.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.house.model.dao.HouseDao;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.house.model.vo.Manage;
import com.kh.udongzip.house.model.vo.Option;
import com.kh.udongzip.house.model.vo.Subway;
import com.kh.udongzip.member.model.vo.Member;

@Service
public class HouseServiceImpl implements HouseService {
	
	@Autowired
	private HouseDao houseDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;


/**
* @version 1.0
* @author 박민규
*/
	
	// 업체회원 보유 매물 조회 및 검색
	@Override
	public ArrayList<House> selectHouseList(HashMap<String, Object> map) {
		return houseDao.selectHouseList(sqlSession, map);
	}
	
	// 계약 상태 변경 메소드
	@Override
	public int updateSalesStatus(HashMap<String, Object> map) {
		return houseDao.updateSalesStatus(sqlSession, map);
	}

	// 관리비 전체 항목 불러오기
	@Override
	public ArrayList<Manage> selectAllManage() {
		return houseDao.selectAllManage(sqlSession);
	}

	// 옵션 전체 항목 불러오기
	@Override
	public ArrayList<Option> selectAllOption() {
		return houseDao.selectAllOption(sqlSession);
	}
	
	// 지하철역 정보 불러오기 메소드
	@Override
	public ArrayList<Subway> selectStationList(String line) {
		return houseDao.selectStationList(sqlSession, line);
	}
	
	// 신규 매물 등록
	@Transactional
	@Override
	public int insertHouse(HashMap<String, Object> map) {
		
		// map에서 house 객체 뽑아내기
		House house = (House)map.get("house");
		
		// 매물 정보 DB insert
		int result1 = houseDao.insertHouse(sqlSession, house);
		
		int result2 = 0;
		
		if(result1 > 0) {
			
			// 방금 등록한 매물의 houseNo을 얻기 위해 가장 최근 등록한 매물 정보 조회
			House newHouse = houseDao.selectNewestHouse(sqlSession, house.getAgentNo());
			
			// houseNo 뽑아서 map에 넣기
			map.put("houseNo", newHouse.getHouseNo());
			
			result2 = houseDao.insertHouseImg(sqlSession, map);
			
		}
		
		return result1 * result2;
		
	}
	
	// 매물 정보 불러오기 (updateForm)
	@Override
	public House selectUpdateHouse(int houseNo) {
		return houseDao.selectUpdateHouse(sqlSession, houseNo);
	}
	
	// 매물 수정하기
	@Override
	public int updateHouse(House house) {
		return houseDao.updateHouse(sqlSession, house);
	}
	
	// 매물 이미지 정보 변경
	@Override
	public int updateHouseImg(HashMap<String, Object> map) {
		
		int result1 = 1;
				
		if(!((ArrayList)map.get("removeList")).isEmpty()) {
			
			result1 = houseDao.deleteHouseImg(sqlSession, map);
			
		}
				
		int result2 = 1;
		
		if(!((ArrayList)map.get("imgList")).isEmpty()) {
			
			result2 = houseDao.insertHouseImg(sqlSession, map);
			
		}
		
		return result1 * result2;
		
	}
	
	@Override
	public int deleteHouse(int houseNo) {
		return houseDao.deleteHouse(sqlSession, houseNo);
	}
	
/**
 * @version 1.0
 * @author 연경흠 
*/

	@Override
	public ArrayList<House> houseMapList() {

		return houseDao.houseMapList(sqlSession);
	}
	
	@Override
	public ArrayList<House> houseList() {

		return houseDao.houseList(sqlSession);
	}
	
	@Override
	public ArrayList<House> houseFilter(Map<String, Object> map) {
		
		return houseDao.houseFilter(sqlSession, map);
	}
	

	@Override
	public ArrayList<House> selectReportHouse() {
		// TODO Auto-generated method stub
		return null;
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
	public int selectZzim(HashMap<String, Integer> map) {
		return houseDao.selectZzim(sqlSession, map);
	}
	
	// 매물 찜 추가 서비스
	@Override
	public int insertZzim(HashMap<String, Integer> map) {
		return houseDao.insertZzim(sqlSession, map);
	}
	
	// 매물 찜 삭제 서비스
	@Override
	public int deleteZzim(HashMap<String, Integer> map) {
		return houseDao.deleteZzim(sqlSession, map);
	}
	
	// 허위 매물 신고 추가 메소드
	@Override
	public int updateReportCount(int houseNo) {
		return houseDao.updateReportCount(sqlSession, houseNo);
	}
	
	// 허위 매물 전체 조회 서비스
	@Override
	public ArrayList<House> selectReportHouse(PageInfo pi, HashMap<String, String> map) {
		return houseDao.selectReportHouse(sqlSession, pi, map);
	}

	// 허위 매물 전체 조회 수 서비스
	@Override
	public int selectReportHouseCount(HashMap<String, String> map) {
		return houseDao.selectReportHouseCount(sqlSession, map);
	}
	
/**
* @version 1.0
* @author 박경화
*/
	// 마이페이지 - 찜 조회
    @Override
	public ArrayList<House> selectZzimList(int memberNo) {
		return houseDao.selectZzimList(sqlSession, memberNo);
	}

	@Override
	public int selectZzim(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}

	

