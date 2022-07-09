package com.kh.udongzip.reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.reservation.model.service.ReservationService;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("reservation.ag")
	public String agentReservationListView() {
		return "user/agent/agentReservationListView";
	}
	
	/**
	* 업체회원 예약 목록 조회 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 업체회원 번호
	* @return 검색된 매물 리스트
	*
	*/
	@ResponseBody
	@PostMapping(value="agentListView.res", produces="application/json; charset=UTF-8")
	public String selectReservationList(@RequestParam(value="ano") int agentNo) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("userNo", agentNo);
		map.put("identifier", "R.AGENT_NO");
		
		ArrayList<Reservation> reservationList = reservationService.selectReservationList(map);
		
		return new Gson().toJson(reservationList);
		
	}
	
	/**
	* 업체회원 예약 상태 변경 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param reservationNo
	* 		 예약 번호
	* @param result
	*        예약 상태
	* @return 변경 성공 여부
	*
	*/
	@ResponseBody
	@PostMapping(value="changeResult.res", produces="text/html; charset=UTF-8")
	public String updateResult(int reservationNo,
							   String resultStatus) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("reservationNo", reservationNo);
		map.put("resultStatus", resultStatus);
		
		int result = reservationService.updateResult(map);
		
		if(result > 0) {
			return "NNNNY";
		} else {
			return "NNNNN";
		}
		
	}

}
