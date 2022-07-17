package com.kh.udongzip.house.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.house.model.vo.Manage;
import com.kh.udongzip.house.model.vo.Option;
import com.kh.udongzip.house.model.vo.Subway;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.vo.Review;

@Repository
public class HouseDao {
	
/**
* @version 1.0
* @author 박민규
*/
	
	// agent 내 매물 리스트 조회 및 검색
	public ArrayList<House> selectHouseList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectHouseList", map);
	}
	
	// 매물 계약상태 변경
	public int updateSalesStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("houseMapper.updateSalesStatus", map);
	}
	
	// 관리비 전체 항목 불러오기
	public ArrayList<Manage> selectAllManage(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectAllManage");
	}
	
	// 옵션 전체 항목 불러오기
	public ArrayList<Option> selectAllOption(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectAllOption");
	}
	
	// 지하철역 정보 불러오기
	public ArrayList<Subway> selectStationList(SqlSessionTemplate sqlSession, String line) {
		return (ArrayList)sqlSession.selectList("houseMapper.selectStationList", line);
	}
	
	// 신규 매물 등록
	public int insertHouse(SqlSessionTemplate sqlSession, House house) {
		return sqlSession.insert("houseMapper.insertHouse", house);
	}
	
	// 가장 최근 등록된 매물 정보 불러오기 (매물 등록 과정)
	public House selectNewestHouse(SqlSessionTemplate sqlSession, int agentNo) {
		return sqlSession.selectOne("houseMapper.selectNewestHouse", agentNo);
	}
	
	// 매물의 이미지 정보 삽입 (매물 등록 과정)
	public int insertHouseImg(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("houseMapper.insertHouseImg", map);
	}
	
	// 매물 정보 불러오기 (updateForm)
	public House selectUpdateHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("houseMapper.selectUpdateHouse", houseNo);
	}
	
	// 매물 수정하기
	public int updateHouse(SqlSessionTemplate sqlSession, House house) {
		return sqlSession.update("houseMapper.updateHouse", house);
	}
	
	// 매물 이미지 삭제
	public int deleteHouseImg(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.delete("houseMapper.deleteHouseImg", map);
	}
	
	// 매물 정보 삭제
	public int deleteHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.update("houseMapper.deleteHouse", houseNo);
	}
	
/**
 * @version 1.0
 * @author 연경흠
*/
	
	// 지도 / 매물 전체조회
	public ArrayList<House> houseMapList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("houseMapper.houseMapList");
	}
	
	// 지도 / 매물 전체조회
	public ArrayList<House> houseList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("houseMapper.houseList");
	}
	
	// 검색 필터 조회
	public ArrayList<House> houseFilter(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return (ArrayList)sqlSession.selectList("houseMapper.houseFilter", map);
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
	public Integer selectZzim(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.selectOne("houseMapper.selectZzim", map);
	}
	
	// 매물 찜 추가
	public int insertZzim(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.insert("houseMapper.insertZzim", map);
	}
	
	// 매물 찜 삭제
	public int deleteZzim(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.delete("houseMapper.deleteZzim", map);
	}
	
	// 허위 매물 신고 추가 메소드
	public int updateReportCount(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.update("houseMapper.updateReportCount", houseNo);
	}
	
	// 허위 매물 전체 조회 수 메소드
	public int selectReportHouseCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("houseMapper.selectReportHouseCount", map);
	}
	
	// 허위 매물 전체 조회 메소드
	public ArrayList<House> selectReportHouse(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("houseMapper.selectReportHouse", map, rowBounds);
	}
	
/**
 * @version 1.0
 * @author 박경화
 */
	// 찜 리스트 조회
	public ArrayList<House> selectZzimList(SqlSessionTemplate sqlSession,int memberNo) {
		
		
		return (ArrayList)sqlSession.selectList("houseMapper.selectZzimList", memberNo);
	}

}
