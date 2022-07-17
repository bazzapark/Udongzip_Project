package com.kh.udongzip.reservation.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.member.model.vo.Member;
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
		
		ArrayList<Reservation> reservationList = reservationService.selectAgentReservationList(map);
		
		return new Gson().toJson(reservationList);
		
	}
	
	/**
	* 업체회원 예약 상태 변경 메소드 (ajax)
	* 결제 취소 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param reservationNo
	* 		 예약 번호
	* @param result
	*        예약 상태
	* @return 변경 성공 여부
	 * @throws Exception 
	*
	*/
	@ResponseBody
	@PostMapping(value="changeResult.res", produces="text/html; charset=UTF-8")
	public String updateResult(int reservationNo,
							   String resultStatus) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("reservationNo", reservationNo);
		map.put("resultStatus", resultStatus);
		
		if (resultStatus.equals("방문 완료")) {
			
			Reservation reservation = reservationService.selectReservation(reservationNo);
			
			// 결제 취소 API
			String url = "https://kapi.kakao.com/v1/payment/cancel";
			
			URL requestUrl = new URL(url);
			HttpURLConnection urlConn = (HttpURLConnection) requestUrl.openConnection();
			urlConn.setRequestMethod("POST");
			urlConn.setRequestProperty("Authorization", "KakaoAK 13acc9f723b2683c3fc9614c6a32cbfd");
			urlConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			urlConn.setDoInput(true);
			urlConn.setDoOutput(true);
			Map<String, String> params = new HashMap<String, String>(); // 파라미터 설정
			params.put("cid", "TC0ONETIME");
			params.put("tid", reservation.getTid());
			params.put("cancel_amount", Integer.toString(reservation.getCancelAmount()));
			params.put("cancel_tax_free_amount", Integer.toString(reservation.getCancelTaxFreeAmount()));
			String strParams = new String();
			for (Map.Entry<String, String> param : params.entrySet()) {
				strParams += (param.getKey() + "=" + param.getValue() + "&");
			}
			OutputStream out = urlConn.getOutputStream(); 
			out.write(strParams.getBytes()); 
			out.flush(); 
			out.close(); 
			
			String line;
			String responseText = "";
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			
			while ((line = br.readLine()) != null) {
				responseText += line;
			}
			
			br.close();
			urlConn.disconnect();
			
			JsonObject resultObj =  JsonParser.parseString(responseText).getAsJsonObject();
			
			if (map.containsKey("msg")) {
				return "NNNNN";
			}
			
		} 
		
		int result = reservationService.updateResult(map);
		
		if(result > 0) {
			
			return "NNNNY";
		
		} else {
			
			return "NNNNN";
		}
		
	}
	
	/**
	 * 예약 추가 메소드 : 개인 회원
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param reservation Reservation 객체
	 * @param partner_order_id 가맹점 코드 (업체 회원 번호)
	 * @param partner_user_id 가맹점 이름 (업체 회원 업체명)
	 * 
	 * @return 결제 승인 페이지
	 */
	@PostMapping("insert.rs")
	public String insertReservation(String partner_order_id, String partner_user_id, 
									Reservation reservation, HttpSession session, Model model) throws Exception {
		
		int resResult = reservationService.insertReservation(reservation);
		
		if (resResult > 0) {
			
			String url = "https://kapi.kakao.com/v1/payment/ready";
			
			URL requestUrl = new URL(url);
			HttpURLConnection urlConn = (HttpURLConnection) requestUrl.openConnection();
			urlConn.setRequestMethod("GET");
			urlConn.setRequestProperty("Authorization", "KakaoAK 13acc9f723b2683c3fc9614c6a32cbfd");
			urlConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			urlConn.setDoInput(true);
			urlConn.setDoOutput(true);
			
			Map<String, String> params = new HashMap<String, String>(); // 파라미터 설정
			params.put("cid", "TC0ONETIME");
			params.put("partner_order_id", partner_order_id);
			params.put("partner_user_id", partner_user_id);
			params.put("item_name", "매물상담예약보증금");
			params.put("quantity", "1");
			params.put("total_amount", "20000");
			params.put("tax_free_amount", "1800");
			params.put("approval_url", "http://localhost:8006/udongzip/kakaopay.rs");
			params.put("cancel_url", "http://localhost:8006/udongzip/payCancel.do");
			params.put("fail_url", "http://localhost:8006/udongzip/payError.do");
			
			String strParams = new String();
			for (Map.Entry<String, String> param : params.entrySet()) {
				strParams += (param.getKey() + "=" + param.getValue() + "&");
			}
			
			OutputStream out = urlConn.getOutputStream(); 
			out.write(strParams.getBytes()); 
			out.flush(); 
			out.close(); 
			
			String line;
			String responseText = "";
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			
			while ((line = br.readLine()) != null) {
				responseText += line;
			}
			
			br.close();
			urlConn.disconnect();
			
			JsonObject result =  JsonParser.parseString(responseText).getAsJsonObject();
			
			String tid = result.get("tid").getAsString(); // 결제 승인시 필요한 TID
			String successUrl = result.get("next_redirect_pc_url").getAsString();
			
			session.setAttribute("tid", tid);
			session.setAttribute("partner_order_id", partner_order_id);
			session.setAttribute("partner_user_id", partner_user_id);
			
			return "redirect:" + successUrl;
			
		} else {
			
			model.addAttribute("errorMsg", "예약에 실패했습니다. 다시 시도해주세요.");
			return "common/error";
			
		}
		
	}
	
	/**
	 * 카카오 페이 결제 취소 메소드 : 개인 회원
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param session Session 객체
	 * @param model Model 객체
	 * 
	 * @return 매물 상세 페이지
	 */
	@RequestMapping("payCancel.do")
	public String payCancel(HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		int reservationNo = reservationService.selectNewReservation(memberNo);
		
		if (reservationNo != 0) {
			
			int result = reservationService.deleteReservation(reservationNo);
			if (result > 0) {
				session.setAttribute("alertMsg", "결제가 취소되었습니다.");
				return "redirect:list.ma";
			} else {
				model.addAttribute("errorMsg", "결제 취소에 실패하였습니다. 1:1 문의 남겨주시기 바랍니다.");
				return "common/error";
			}
		} else {
			model.addAttribute("errorMsg", "결제 취소에 실패하였습니다. 1:1 문의 남겨주시기 바랍니다.");
			return "common/error";
		}
	}
	
	/**
	 * 카카오 페이 결제 에러 메소드 : 개인 회원
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param model Model 객체
	 * @param session Session 객체
	 * 
	 * @return 매물 상세 페이지
	 * 
	 */
	@RequestMapping("payError.do")
	public String payError(Model model, HttpSession session) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		int reservationNo = reservationService.selectNewReservation(memberNo);
		
		if (reservationNo != 0) {
			
			int result = reservationService.deleteReservation(reservationNo);
			if (result > 0) {
				session.setAttribute("alertMsg", "결제 요청을 실패했습니다. 다시 시도해주세요.");
				return "redirect:/";
			} else {
				model.addAttribute("errorMsg", "결제 요청을 실패했습니다. 다시 시도해주세요. ");
				return "common/error";
			}
		} else {
			model.addAttribute("errorMsg", "결제 요청을 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
	}
	
	/**
	 * 카카오 페이 결제 승인 메소드 : 개인 회원
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param pg_token 결제 요청 성공시 전달받는 값
	 * @session Session 객체
	 * 
	 * @return 예약 정보 변경 메소드
	 */
	@RequestMapping("kakaopay.rs")
	public String kakaoPay(@RequestParam (value="pg_token") String pg_token, HttpSession session) throws Exception {
		
		// 결제 승인 API
		String url = "https://kapi.kakao.com/v1/payment/approve";
			
		URL requestUrl = new URL(url);
		HttpURLConnection urlConn = (HttpURLConnection) requestUrl.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setRequestProperty("Authorization", "KakaoAK 13acc9f723b2683c3fc9614c6a32cbfd");
		urlConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		urlConn.setDoInput(true);
		urlConn.setDoOutput(true);
		
		Map<String, String> params = new HashMap<String, String>(); 
		params.put("cid", "TC0ONETIME");
		params.put("tid", (String)session.getAttribute("tid"));
		params.put("partner_order_id", (String)session.getAttribute("partner_order_id"));
		params.put("partner_user_id", (String)session.getAttribute("partner_user_id"));
		params.put("pg_token", pg_token);
		
		String strParams = new String();
		for (Map.Entry<String, String> param : params.entrySet()) {
			strParams += (param.getKey() + "=" + param.getValue() + "&");
		}
		
		OutputStream out = urlConn.getOutputStream(); 
		out.write(strParams.getBytes()); 
		out.flush(); 
		out.close(); 
		
		String line;
		String responseText = "";
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
		
		while ((line = br.readLine()) != null) {
			responseText += line;
		}
		
		br.close();
		urlConn.disconnect();
		
		return "redirect:update.rs";
			
	}
	
	/**
	 * 예약 정보 변경 메소드 : 개인 회원
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param session Session 객체
	 * @param model Model 객체
	 * 
	 * @return 매물 상세 페이지
	 */
	@RequestMapping("update.rs")
	public String updateReservation(HttpSession session, Model model) {

		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		int reservationNo = reservationService.selectNewReservation(memberNo);
		
		if (reservationNo != 0) {
			
			Reservation reservation = new Reservation();
			reservation.setTid((String)session.getAttribute("tid"));
			reservation.setReservationNo(reservationNo);
			int result = reservationService.updateReservation(reservation);
			if (result > 0) {
				session.setAttribute("alertMsg", "예약이 완료되었습니다.");
				return "redirect:reservationlist.bo?cpage=1";
			} else {
				model.addAttribute("errorMsg", "예약이 실패했습니다. 1:1 문의 남겨주시기 바랍니다.");
				return "common/error";
			}
		} else {
			model.addAttribute("errorMsg", "예약이 실패했습니다. 1:1 문의 남겨주시기 바랍니다.");
			return "common/error";
		}
		
	}
	
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
	
	/**
	 * 결제 취소 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 */
	

}
