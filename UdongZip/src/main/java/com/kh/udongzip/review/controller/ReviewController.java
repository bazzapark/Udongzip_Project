package com.kh.udongzip.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.member.model.vo.Member;
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
	@Auth(role=Role.AGENT)
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
	@Auth(role=Role.AGENT)
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
	@Auth(role=Role.AGENT)
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
	
	/**
	 * 리뷰 삭제 요청 전체 조회 메소드 : 어드민
	 * 삭제전, 키워드 검색
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param cpage 현재 페이지
	 * @param classification 전체 / 삭제 전 / 검색
	 * @param keyword 검색 키워드
	 * @param model 모델 객체
	 * 
	 * @return 리뷰 삭제 요청 전체 조회 페이지
	 */
	@Auth(role=Role.ADMIN)
	@RequestMapping("list.rv")
	public String selectRemoveList(@RequestParam (value="cpage", defaultValue="1") int currentPage, Model model, String classification, String keyword) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("classification", classification);
		map.put("keyword", keyword);
		
		// 페이징 처리 변수 셋팅
		int listCount = reviewService.selectRequestListCount(map);
		int pageLimit = 5;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
					
		ArrayList<RemoveRequest> list = reviewService.selectRequestList(pi, map);
		
		if (list == null) {
			model.addAttribute("errorMsg", "삭제 요청 전체 조회에 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		if (classification != null) {
			model.addAttribute("classification", "&classification=" + classification);
		}
		if (keyword != null) {
			model.addAttribute("keyword", "&keyword=" + keyword);
		}
		
		return "admin/report/removeListView";
	}
	
	/**
	* 리뷰 삭제요청 상세 조회 메소드 : 어드민
	*
	* @version 1.0
	* @author 양아란
	* 
	* @param requestNo 리뷰 삭제 요청 번호
	* 
	* @return 리뷰 삭제 요청 상세 모달창
	*/
	@Auth(role=Role.ADMIN)
	@ResponseBody
	@PostMapping("select.rv")
	public RemoveRequest selectAgent(int requestNo) {
		RemoveRequest request = reviewService.selectRequest(requestNo);
		return request;
	}
	
	/**
	 * 삭제 요청 반려, 삭제 처리 메소드 : 어드민
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param request
	 * @param model
	 * @param session
	 * 
	 * @return 삭제 요청 전체 조회 페이지
	 */
	@Auth(role=Role.ADMIN)
	@PostMapping("adminUpdate.rv")
	public String adminUpdate(RemoveRequest request, Model model, HttpSession session) {
		
		int result = reviewService.updateRequest(request);
		
		if (request.getResult().equals("delete")) {
			int reviewNo = request.getReviewNo();
			int result2 = reviewService.deleteReview(reviewNo);
			result = result2 * result;
		}
		
		if (result > 0) {
			session.setAttribute("alertMsg", "리뷰 삭제 요청 처리가 완료되었습니다.");
			return "redirect:/list.rv";
		} else {
			model.addAttribute("errorMsg", "리뷰 삭제 요청 처리에 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
	}
	
	// 리뷰작성 
	@Auth(role=Role.MEMBER)
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
	@Auth(role=Role.MEMBER)
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
		// System.out.println(list);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "user/review/reviewListView";
	}
	
	// 리뷰 상세조회(보기)
	@Auth(role=Role.MEMBER)
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
	@Auth(role=Role.MEMBER)
	@RequestMapping("delete.bo")
	public String deleteReview(int bno, Model model, HttpSession session) {
		
		int result= reviewService.deleteReview(bno);
		
		if(result >0) { // 성공
			
			session.setAttribute("alertMsg", "성공적으로 리뷰가 삭제되었습니다.");
			
			return "redirect:reviewlist.bo";
		}
		else { // 실패
			
			model.addAttribute("errorMsg", "리뷰 삭제 실패");
			
			return "common/reeor";
		}
	}
}
