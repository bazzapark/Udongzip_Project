package com.kh.udongzip.reservation.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.reservation.model.service.ReservationService;
import com.kh.udongzip.reservation.model.vo.Reservation;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	
	// 전체조회
	@RequestMapping("reservationlist.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			Model model, HttpSession session) {
		
		int memberNo =  ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		int listCount = reservationService.selectListCount(memberNo);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Reservation> list = reservationService.selectReservationList(pi, memberNo);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "user/reservation/reservationListView";
	}
	
	// 예약 상세조회
	@ResponseBody
	@RequestMapping(value="reservationdetail.bo", produces="applicatoin/json; charset=UTF-8")
	public String selectReservationdate(int reservationNo) {
	
		Reservation re = reservationService.selectReservation(reservationNo);
		
		return new Gson().toJson(re);
	}
	
	@RequestMapping("reservationFome.bo")
	public String reservationFome(int reservationNo, int agentNo, Model model) {
		
		model.addAttribute("reservationNo", reservationNo);
		model.addAttribute("agentNo", agentNo);
		
		// 폼 띄어주기
		return "user/reservation/reservationFome";
	}
	

}
