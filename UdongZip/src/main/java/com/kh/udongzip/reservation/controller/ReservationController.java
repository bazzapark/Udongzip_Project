package com.kh.udongzip.reservation.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
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
	
	@PostMapping("insert.rs")
	public String insertReservation(String partner_order_id, String partner_user_id, 
			String pg_token, Reservation reservation, HttpSession session, Model model) throws Exception {
		
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
			params.put("approval_url", "http://localhost:8006/udongzip/payApproval.do");
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
	
	@RequestMapping("payApproval.do")
	public String payApproval(String pg_token, HttpSession session) {
		session.setAttribute("pg_token", pg_token);
		return "common/payApproval";
	}
	
	@RequestMapping("payCancel.do")
	public String payCancel(HttpSession session) {
		
		session.setAttribute("alertMsg", "결제를 취소하셨습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("payError.do")
	public String payError(Model model) {
		model.addAttribute("errorMsg", "결제에 실패했습니다. ");
		return "common/error";
	}
	
	/**
	 * 카카오 페이 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * @return 
	 */
	@PostMapping("kakaoPay.rs")
	public String kakaoPay(HttpSession session) throws Exception {
		
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
			params.put("pg_token", (String)session.getAttribute("pg_token"));
			
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
			
			session.setAttribute("alertMsg", "예약이 완료되었습니다.");
			
			return "redirect:/";
			
		}
		

}
