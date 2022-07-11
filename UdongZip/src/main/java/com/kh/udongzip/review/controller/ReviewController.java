package com.kh.udongzip.review.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.review.model.service.ReviewService;
import com.kh.udongzip.review.model.vo.RemoveRequest;
import com.kh.udongzip.review.model.vo.Review;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;

	/**
	* 업체회원 리뷰 목록 페이지 이동 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 리뷰 목록 페이지
	*
	*/
	@RequestMapping("review.ag")
	public String reviewListView() {
		return "user/agent/agentReviewListView";
	}
	
	/**
	* 업체회원 리뷰 목록 조회 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 조회하려는 업체 번호
	* @return 리뷰 목록
	*
	*/
	@ResponseBody
	@PostMapping(value="agentListView.rev", produces="application/json; charset=UTF-8")
	public String selectAgentReviewList(int agentNo) {
		
		ArrayList<Review> reviewList = reviewService.selectAgentReviewList(agentNo);
		
		return new Gson().toJson(reviewList);
		
		
	}
	
	/**
	* 업체회원 리뷰 삭제 요청 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param request
	* 		 삭제 요청 정보가 담긴 RemoveRequest 객체
	* @return 업체회원 리뷰 목록 페이지
	*
	*/
	@PostMapping("insert.req")
	public String insertRequest(RemoveRequest request,
								Model model,
			   					HttpSession session) {
		
		int result = reviewService.insertRequest(request);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "삭제 요청이 완료 되었습니다.");
			
			return "redirect:review.ag";
			
		} else {
			
			model.addAttribute("errorMsg", "삭제 요청에 실패했습니다.");
			
			return "common/error";
			
		}
		
	}
	
}
