package com.kh.udongzip.house.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.common.template.SaveFileRename;
import com.kh.udongzip.house.model.service.HouseService;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.house.model.vo.Manage;
import com.kh.udongzip.house.model.vo.Option;
import com.kh.udongzip.house.model.vo.Subway;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.vo.Review;

@Controller
public class HouseController {
	
	@Autowired
	private HouseService houseService;
	
	/**
	* 업체회원 내 매물 목록 페이지 이동 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 매물 목록 페이지
	*
	*/
	@RequestMapping("houseListView.ho")
	public String agentHouseListView() {
		return "user/house/agentHouseListView";
	}
	
	/**
	* 업체회원 내 매물 목록 조회 및 검색 메소드 (ajax)
	* keyword가 null인 경우 전체 조회, keyowrd가 있는 경우 검색 조회
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 업체회원 번호
	* @param categoty
	* 		 검색 영역
	* @param keyword
	* 		 검색어
	* @return 검색된 매물 리스트
	*
	*/
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
	
	/**
	* 업체회원 내 매물 계약 가능 여부 변경 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param houseNo
	* 		 상태를 변경하려는 매물 번호
	* @param salesStatus
	* 		 변경하려는 상태값
	* @return 변경 성공 여부
	*
	*/
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
	
	/**
	* 업체회원 매물 등록 페이지 이동 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 매물 등록 페이지
	*
	*/
	@RequestMapping("enrollForm.ho")
	public String houseEnrollForm(Model model) {
		
		ArrayList<Manage> manageList = houseService.selectAllManage();
		
		ArrayList<Option> optionList = houseService.selectAllOption();
		
		model.addAttribute("manageList", manageList);
		model.addAttribute("optionList", optionList);
		
		return "user/house/houseEnrollForm";
	}
	
	/**
	* 업체회원 매물 등록 페이지 지하철역 정보 불러오기 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @return 선택한 노선의 지하철역 정보
	*
	*/
	@ResponseBody
	@RequestMapping(value="stationList.ho", produces="applicatoin/json; charset=UTF-8")
	public String selectStationList(String line) {
		
		ArrayList<Subway> stations = houseService.selectStationList(line);
		
		return new Gson().toJson(stations);
		
	}
	
	/**
	* 업체회원 매물 등록 메소드
	* 썸네일 파일 저장 후 setter 메소드로 house 객체에 변경된 이름을 저장
	* 다른 이미지 파일들은 저장 후 list에 담은 후 map에 담아 다른 매개변수들과 함께 service로 전달
	*
	* @version 1.0
	* @author 박민규
	* @param house
	*        매물 정보를 담고 있는 House 객체
	* @param thumbnailFile
	*        매물의 대표사진
	* @param houseImg
	*        매물 이미지 list
	* @param manageInfo
	* 		 매물의 관리비 정보
	* @param optionInfo
	* 		 매물의 옵션 정보
	* @return 매물 목록 페이지
	*
	*/
	@Validated
	@PostMapping("insert.ho")
	public String insertHouse(House house,
							  MultipartFile thumbnailFile,
							  List<MultipartFile> houseImg,
							  @RequestParam("manageInfo") String manageInfo,
							  @RequestParam("optionInfo") String optionInfo,
							  Model model,
							  HttpSession session) {
		
		SaveFileRename saveFileRename = new SaveFileRename();
		HashMap<String, Object> map = new HashMap<>();
		ArrayList<String> imgList = new ArrayList<>();
		
		int agentNo = house.getAgentNo();
		
		house.setThumbnail(saveFileRename.saveHouseImg(agentNo, thumbnailFile, session));
		house.setManageInfo(String.join(";", manageInfo));
		house.setOptionInfo(String.join(";", optionInfo));
		
		for(MultipartFile img : houseImg) {
			
			if(!img.getOriginalFilename().equals("")) {
				imgList.add(saveFileRename.saveHouseImg(agentNo, img, session));
			}
			
		}
		
		map.put("house", house);
		map.put("imgList", imgList);
		
		int result = houseService.insertHouse(map);
		
		if(result > 0) { // 등록 성공 시
			
			session.setAttribute("alertMsg", "매물이 등록 되었습니다.");
			
			return "redirect:houseListView.ho";
			
		} else { // 등록 실패 시
			
			// 저장된 썸네일 파일 삭제
			new File(session.getServletContext().getRealPath(house.getThumbnail())).delete();
			
			// 저장된 기타 이미지 파일들 삭제
			for(String img : imgList) {
				new File(session.getServletContext().getRealPath(img)).delete();
			}
			
			model.addAttribute("errorMsg", "매물 등록에 실패했습니다. 잠시 후 다시 시도해주새요.");
			
			return "common/error";
			
		}
		
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
	
	/**
	 * @version 1.0
	 * @author 박경화
	 * @param houseNo
	 * 		   매물 번호
	 * @param memberNo
	 * 		      회원 번호
	 * @return 마이페이지 찜 매물 조회, 페이징
	 */	

	@RequestMapping("selectImages.zz")
	public String selectList(
			Model model, HttpSession session) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		ArrayList<House> list = houseService.selectZzimList(memberNo);
		
		model.addAttribute("list", list);
		
		return "user/house/zzimListView";
	}
	

}
