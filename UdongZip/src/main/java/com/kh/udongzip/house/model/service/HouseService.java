package com.kh.udongzip.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.house.model.vo.Manage;
import com.kh.udongzip.house.model.vo.Option;
import com.kh.udongzip.house.model.vo.Subway;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.reservation.model.vo.Reservation;

public interface HouseService {
	
	/**
	* @version 1.0
	* @author 연경흠
	*/
	
	// 전체 매물 조회 (지도, 리스트) : 개인회원
	// status, saleStatus 둘 다 검사 (쿼리문에서)
	ArrayList<House> houseMapList();
	
	ArrayList<House> houseList();
	
	// 필터 : 개인회원
	ArrayList<House> houseFilter(Map<String, Object> map);

	// 매물 신고 : 개인회원
	int updateReportCount(int houseNo);
	
	// 매물 삭제 : 어드민, 업체회원
	int deleteHouse(int houseNo);
	
/**
* @version 1.0
* @author 박민규
*/
	
	// 매물 등록 : 업체회원
	int insertHouse(HashMap<String, Object> map);
	
	// 보유 매물 조회 및 검색 : 업체 회원
	ArrayList<House> selectHouseList(HashMap<String, Object> map);
	
	// 매물 계약상태 변경
	int updateSalesStatus(HashMap<String, Object> map);
	
	// 지하철역 정보 불러오기
	ArrayList<Subway> selectStationList(String line);
	
	// 관리비 전체 항목 불러오기
	ArrayList<Manage> selectAllManage();
	
	// 옵션 전체 항목 불러오기
	ArrayList<Option> selectAllOption();
	
	// 매물 정보 불러오기 (updateForm)
	House selectUpdateHouse(int houseNo);
	
	// 매물 정보 수정
	int updateHouse(House house);
	
	// 매물 이미지 수정
	int updateHouseImg(HashMap<String, Object> map);
	
/**
* 
*/
	
/**
 * @version 1.0
 * @author 양아란
 */
	// 매물 상세 조회 페이지 : 개인회원
	House selectHouse(int houseNo);
	
	// 상세 조회 조회수 증가 : 개인회원
	int updateCount(int houseNo);
	
	// 매물 옵션 조회 : 개인회원
	String selectOptionInfo(int houseNo);
	
	// 옵션명 조회 : 개인회원
	ArrayList<String> selectOptions(List<Integer> optionInfo);
	
	// 매물 관리비 조회 : 개인회원
	String selectManageInfo(int houseNo);
	
	// 관리비 항목명 조회 : 개인회원
	ArrayList<String> selectManages(List<Integer> manageInfo);
	
	// 매물 이미지 조회 : 개인회원
	ArrayList<String> selectHouseImages(int houseNo);
	
	// 매물 찜 조회 : 개인회원
	int selectZzim(HashMap<String, Integer> map);
	
	// 매물 찜 추가 : 개인회원
	int insertZzim(HashMap<String, Integer> map);
		
	// 매물 찜 삭제 : 개인회원
	int deleteZzim(HashMap<String, Integer> map);
	
	// 허위 매물 목록 전체 조회 : 어드민
	ArrayList<House> selectReportHouse(PageInfo pi, HashMap<String, String> map);
	
	// 허위 매물 목록 전체 조회 수 : 어드민
	int selectReportHouseCount(HashMap<String, String> map);
	
	// 허위 매물 목록 전체 조회 : 어드민
	ArrayList<House> selectReportHouse();
	
	// 매물 찜 조회 : 개인회원
	int selectZzim(Map<String, Integer> map);


/**
 * @version 1.0
 * @author 박경화
 */	

	// 내 예약 조회 - 박경화
	ArrayList<House> selectZzimList(int memberNo);
	
	
	
}
