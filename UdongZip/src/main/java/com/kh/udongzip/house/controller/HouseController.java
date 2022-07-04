package com.kh.udongzip.house.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.udongzip.house.model.service.HouseService;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.member.model.vo.Member;

@Controller
public class HouseController {
	
	@Autowired
	private HouseService houseService;
	
	@RequestMapping("houseListView.ho")
	public String agentHouseListView() {
		return "user/house/agentHouseListView";
	}
	
	@ResponseBody
	@PostMapping(value="listView.ho", produces="application/json; charset=UTF8")
	public String selecthouseList(int agentNo,
								 String category,
								 String keyword) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("agentNo", agentNo);
		map.put("category", category);
		map.put("keyword", keyword);
		
		ArrayList<House> houseList = houseService.selectHouseList(map);
		
		return new Gson().toJson(houseList);
		
	}
	
	@ResponseBody
	@PostMapping(value="changeStatus.ho", produces="text/html; charset=UTF8")
	public String updateSalesStatus(int houseNo,
									String salesStatus) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("houseNo", houseNo);
		map.put("salesStatus", salesStatus);
		
		int result = houseService.updateSalesStatus(map);
		
		return (result > 0) ? "NNNNY" : "NNNNN";
		
	}
	
	@RequestMapping(value="list.ma")
	public String selectList(Model model) {
		
		ArrayList<House> list = houseService.houseMapList();
		
		model.addAttribute("list", list);
		
		return "user/house/houseMap";
	}
	
	@ResponseBody
	@RequestMapping(value="list.lo", produces="application/json; charset=UTF-8")
	public String selectMap() {
		
		ArrayList<House> list = houseService.houseMapList();
		
		return new Gson().toJson(list);
	}
	
	
	/**
	 * 매물 상세 조회 메소드
	 * 조회수 증가,
	 * 옵션 조회,
	 * 관리비 조회,
	 * 이미지 경로 조회
	 * 
	 * @version 1.0
	 * @author 양아란
	 * @param houseNo
	 * 		   매물 번호
	 * @return 매물 상세 조회 페이지
	 */
	// 1. 전체 조회에서 houseNo 가져와야 함
	// 2. 새로운 탭으로 출력해야 함
	@RequestMapping("detail.ho")
	public ModelAndView selectHouse(ModelAndView mv) {
		
		// 수정해야 하는 부분
		int houseNo = 32264729;
		Member loginUser = new Member();
		loginUser.setMemberNo(1);
		loginUser.setMemberId("udong");
		loginUser.setMemberPwd("1234");
		loginUser.setMemberName("김우동");
		loginUser.setMemberPhone("01022221111");
		loginUser.setMemberEmail("udong@udong.com");
		loginUser.setStatus("Y");
		mv.addObject("loginUser", loginUser);
		
		// 매물 상세 조회 조회수 증가 메소드
		int result = houseService.updateCount(houseNo);
		
		if (result > 0) { // 조회수 증가 성공
			
			// 매물 상세 조회
			House house = houseService.selectHouse(houseNo);
			
			// 매물 옵션 조회
			List<String> optionStr = Arrays.asList(houseService.selectOptionInfo(houseNo).split(";"));
			List<Integer> optionInt = new ArrayList<Integer>();
			
			// 옵션명을 담을 변수
			ArrayList<String> options = null;
			
			// 매물 관리비 조회
			List<String> manageStr = Arrays.asList(houseService.selectManageInfo(houseNo).split(";"));
			List<Integer> manageInt = new ArrayList<Integer>();
			
			// 관리비 항목명을 담을 변수
			ArrayList<String> manages = null;
			
			// 매물 이미지 조회
			ArrayList<String> images = houseService.selectHouseImages(houseNo);
			
			if (house != null) { // 매물 상세 조회 성공
				
				if (optionStr != null) { // 옵션이 있는 경우
					
					// String -> Integer 타입 변경
					for (String option : optionStr) {
						optionInt.add(Integer.valueOf(option));
					}
					
					// 매물 옵션명 조회
					options = houseService.selectOptions(optionInt);
				}
				
				if (manageStr != null) { // 관리비가 있는 경우
					
					// String -> Integer 타입 변경
					for (String manage : manageStr) {
						manageInt.add(Integer.valueOf(manage));
					}
					
					// 관리비 항목명 조회
					manages = houseService.selectManages(manageInt);
				}
				
				mv.addObject("house", house);
				mv.addObject("options", options);
				mv.addObject("manages", manages);
				mv.addObject("images", images);
				mv.setViewName("user/house/houseDetailView");
				
			} else { // 매물 상세 조회 실패
				mv.addObject("errorMsg", "매물 상세 조회에 실패하였습니다. 다시 시도해주세요.").setViewName("common/error");
			}
			
		} else { // 조회수 증가 실패
			mv.addObject("errorMsg", "매물 상세 조회에 실패하였습니다. 다시 시도해주세요.").setViewName("common/error");
		}
		
		return mv;
	}
	
	/**
	 * 매물 찜 조회 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * @param houseNo
	 * 		   매물 번호
	 * @param memberNo
	 * 		   회원 번호
	 * @return 매물 상세 조회 페이지
	 */
	@ResponseBody
	@PostMapping("select.zz")
	public int selectZzim(int houseNo, int memberNo) {

		HashMap<String, Integer> map = new HashMap<>();
		map.put("houseNo", houseNo);
		map.put("memberNo", memberNo);
		
		int result = houseService.selectZzim(map);
		return result;
	}
	
	/**
	 * 매물 찜 추가 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * @param houseNo
	 * 		   매물 번호
	 * @param memberNo
	 * 		   회원 번호
	 * @return 매물 상세 조회 페이지
	 */
	@ResponseBody
	@PostMapping("insert.zz")
	public int insertZzim(int houseNo, int memberNo) {
		
		HashMap<String, Integer> map = new HashMap<>();
		map.put("houseNo", houseNo);
		map.put("memberNo", memberNo);
		
		int result = houseService.insertZzim(map);
		return result;
	}
	
	/**
	 * 매물 찜 삭제 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * @param houseNo
	 * 		   매물 번호
	 * @param memberNo
	 * 		   회원 번호
	 * @return 매물 상세 조회 페이지
	 */
	@ResponseBody
	@PostMapping("delete.zz")
	public int deleteZzim(int houseNo, int memberNo) {
		
		HashMap<String, Integer> map = new HashMap<>();
		map.put("houseNo", houseNo);
		map.put("memberNo", memberNo);
		
		int result = houseService.deleteZzim(map);
		return result;
	}
	
	

}
