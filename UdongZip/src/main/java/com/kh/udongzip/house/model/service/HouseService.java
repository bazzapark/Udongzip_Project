package com.kh.udongzip.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.kh.udongzip.house.model.vo.House;

public interface HouseService {
	
	// 전체 매물 조회 (지도, 리스트) : 개인회원
	// status, saleStatus 둘 다 검사 (쿼리문에서)
	ArrayList<House> houseMapList();
	
	// 필터 : 개인회원
	ArrayList<House> houseFilter(Map<String, String> filter);
	
	// 검색(주소) : 개인회원
	ArrayList<House> houseSearch(String keyword);
	
	// 매물 상세 조회 페이지 : 개인회원, 업체회원
	House selectHouse(int houseNo);
	
	// 매물 찜 : 개인회원
	int insertZzim(int houseNo, int memberNo);
	
	// 매물 찜 취소 : 개인회원
	int deleteZzim(int houseNo, int memberNo);
	
	// 매물 신고 : 개인회원
	int updateReportCount(int houseNo);
	
	// 허위 매물 목록 전체 조회 : 어드민
	ArrayList<House> selectReportHouse();
	
	// 매물 삭제 : 어드민, 업체회원
	int deleteHouse(int houseNo);
	
	// 매물 등록 : 업체회원
	int insertHouse(House house);
	
	// 보유 매물 조회 및 검색 : 업체 회원
	ArrayList<House> selectHouseList(HashMap<String, Object> map);
	
	// 매물 정보 수정
	int updateHouse(House house);
	
	// 매물 계약상태 변경
	int updateSalesStatus(HashMap<String, Object> map);
	
}
