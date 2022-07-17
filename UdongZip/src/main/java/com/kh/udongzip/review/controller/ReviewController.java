package com.kh.udongzip.review.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.service.ReviewService;
import com.kh.udongzip.review.model.vo.Review;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	// 리뷰작성 
	@RequestMapping("insertReview.bo")
	public String insertReview(Review review, Model model, HttpSession session) {
		
		int result = reviewService.insertReview(review);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "리뷰작성이 성공적으로 등록되었습니다.");
			
			return "redirect: reservationlist.bo";
		}
		else {
			
			model.addAttribute("errorMsg", "리뷰작성 실패");
			return "common/error";
		}
	}
	
	
	// 전체조회
	@RequestMapping("reviewlist.bo")
	public String selectList(
			@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			Model model, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginUser");
		
        int listCount = reviewService.selectListCount(member);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		
		ArrayList<Review> list = reviewService.selectReviewList(pi,member);
		System.out.println(list);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "user/review/reviewListView";
	}
	
	// 리뷰 상세조회(보기)
	@RequestMapping("detail.bo")
	public ModelAndView selectReview(@RequestParam (value="bno", defaultValue="1") int reviewNo, ModelAndView mv) {
		
		Review r = reviewService.selectReview(reviewNo);
		
		if(r != null ) {
		
		mv.addObject("r", r).setViewName("user/review/reviewDetailView");
		
	}
		else {
			
			mv.addObject("errorMsg", "리뷰 상세조회 실패").setViewName("common/error");
		}
		
		return mv;
   }
	
	// 리뷰삭제
	@RequestMapping("delete.bo")
	public String deleteReview(int bno, Model model, HttpSession session) {
		
		int result= reviewService.deleteReview(bno);
		
		if(result >0) { // 성공
			
			session.setAttribute("alertMsg", "서옹적으로 리뷰가 삭제되었습니다.");
			
			return "redirect:reviewlist.bo";
		}
		else { // 실패
			
			model.addAttribute("errorMsg", "리뷰 삭제 실패");
			
			return "common/reeor";
		}
	}
}
