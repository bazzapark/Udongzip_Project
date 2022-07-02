package com.kh.udongzip.house.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.house.model.service.HouseService;
import com.kh.udongzip.house.model.vo.House;

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

}
