package com.kh.udongzip.agent.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.udongzip.agent.model.service.AgentService;
import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.SaveFileRename;
import com.kh.udongzip.common.template.TemporaryPassword;
import com.kh.udongzip.house.model.service.HouseService;
import com.kh.udongzip.house.model.vo.House;
import com.kh.udongzip.member.model.service.MemberService;
import com.kh.udongzip.member.model.vo.Member;
import com.kh.udongzip.review.model.service.ReviewService;
import com.kh.udongzip.review.model.vo.Review;

@Controller
public class AgentController {
	
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private SaveFileRename saveFileRename;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private TemporaryPassword temporaryPassword;
	
	/**
	* 업체회원 회원가입 페이지 이동용 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 회원가입 페이지
	*
	*/
	@RequestMapping("enrollForm.ag")
	public String agentEnrollForm() {
		return "user/agent/agentEnrollForm";
	}
	
	/**
	* 업체회원 회원가입 ID 중복 체크 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @return 중복확인 결과
	*
	*/
	@ResponseBody
	@RequestMapping(value="idCheck.ag", produces="text/html; charset=UTF-8")
	public String IdChek(String agentId) {
		
		int agentIdCount = agentService.agentIdCheck(agentId);
		
		int memberIdCount = memberService.memberIdCheck(agentId);
			
		return ((agentIdCount + memberIdCount) > 0) ? "NNNNN" : "NNNNY";
	}
	
	/**
	* 업체회원 회원가입 email 인증 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param email
	*        가입하려는 이메일
	* @return 인증번호 발송 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="emailCheck.ag", produces="text/html; charset=UTF-8")
	public String emailChek(String email) {
		
		int result = agentService.agentEmailCheck(email);
		
		if(result > 0) {
			
			return "NNNNN";
			
		} else {
		
			int code = (int)(Math.random() * 90000 + 10000);
			
			String setFrom = "udongzip12@gmail.com";
	        String toMail = email;
	        String title = "우리동네 좋은 집, 우동집 이메일 인증 번호입니다.";
	        String content = 
	                "우동집을 방문해주셔서 감사합니다." +
	                "<br><br>" + 
	                "인증 번호는 [" + code + "]입니다." + 
	                "<br>" + 
	                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
	        
	        try {
	            
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setFrom);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content,true);
	            mailSender.send(message);
	            
	        }catch(Exception e) {
	            e.printStackTrace();
	        }
	        
	        return Integer.toString(code);
			
		}
 
	}
	
	/**
	* 업체회원 회원가입 메소드
	* 전달 받은 파일 rename 후 서버 컴퓨터에 저장 및 파일경로로 필드값 set
	*
	* @version 1.0
	* @author 박민규
	* @param gent
	* 		 회원가입 정보가 담긴 agent 객체
	* @param document
	* 		 증빙서류 이미지 파일(2개)
	* @return 메인 페이지로 redirect
	*
	*/
	@PostMapping("insert.ag")
	public String insertAgent(Agent agent,
							  List<MultipartFile> document,
							  Model model,
							  HttpSession session) {
		
		String encPwd = bCryptPasswordEncoder.encode(agent.getAgentPwd());
		
		agent.setAgentPwd(encPwd);
		
		ArrayList<String> changeNames = new ArrayList<>();
		
		for(int i = 0; i < document.size(); i++) {
			
			changeNames.add(saveFileRename.saveDocument(agent.getAgentNo(), document.get(i), session));
			
		};
		
		agent.setDocument1(changeNames.get(0));
		agent.setDocument2(changeNames.get(1));
		
		int result = agentService.insertAgent(agent);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "성공적으로 회원가입이 완료 되었습니다.");
			
			return "redirect:/";
			
		} else {
			
			model.addAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
		
	}
	
	/**
	* 업체회원 비밀번호 재설정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param userId
	* 		 재설정하고자 하는 아이디
	* @return 임시비밀번호 발급 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="findPwd.ag", produces="text/html; charset=UTF-8")
	public String findPwd(@RequestParam("userId") String agentId) {
		
		Agent agent = agentService.findPwd(agentId);
		
		if(agent != null) {
			
			String email = agent.getAgentEmail();
			String tmpPassword = temporaryPassword.getRandomPassword(10);
			
			String setFrom = "udongzip12@gmail.com";
	        String toMail = email;
	        String title = "우리동네 좋은 집, 우동집 임시비밀번호입니다.";
	        String content = 
	                "임시비밀번호는 [" + tmpPassword + "]입니다." + 
	                "<br>" + 
	                "로그인 후 꼭 비밀번호를 변경해주세요.";
	        
	        try {
	            
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	            helper.setFrom(setFrom);
	            helper.setTo(toMail);
	            helper.setSubject(title);
	            helper.setText(content,true);
	            mailSender.send(message);
	            
	        }catch(Exception e) {
	            e.printStackTrace();
	        }
	        
	        agent.setAgentPwd(bCryptPasswordEncoder.encode(tmpPassword));
	        
	        int result = agentService.updatePwd(agent);
	        
	        if(result > 0) {
	        	
	        	return "NNNNY";
	        	
	        } else {
	        	
	        	return "NNNNN";
	        	
	        }
			
		} else {
			
			return "NNNNN";
			
		}
		
	}
	
	/**
	* 업체회원 로그인 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agentId
	* 		 업체회원 아이디
	* @param agentPwd
	* 	     업체회원 비밀번호
	* @return 업체회원 회원가입 페이지
	*
	*/
	@PostMapping("login.ag")
	public String agentLogin(@RequestParam(value="memberId")String agentId,
							 @RequestParam(value="memberPwd")String agentPwd,
							 String loginCheck,
							 HttpServletResponse response,
							 HttpSession session) {
		
		Agent loginUser = agentService.loginAgent(agentId);
		
		if(loginUser != null && bCryptPasswordEncoder.matches(agentPwd, loginUser.getAgentPwd())) {
			
			// 아이디 저장 체크 시
			if(loginCheck != null && loginCheck.equals("y")) {
				
				Cookie cookie = new Cookie("saveId", loginUser.getAgentId());
				cookie.setMaxAge(1 * 24 * 60 * 60);
				response.addCookie(cookie);
						
			} else { // 체크 안한 경우
						
				Cookie cookie = new Cookie("saveId", loginUser.getAgentId());
				cookie.setMaxAge(0);
				response.addCookie(cookie);
						
			};
			
			// 식별자 setting
			loginUser.setIdentifier("agent");
			
			// session에 로그인 정보 및 성공 알림 메시지 저장
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 되었습니다.");
			
		} else {
			
			session.setAttribute("alertMsg", "아이디 또는 비밀번호를 확인하세요.");
			
		}
		
		return "redirect:/";
		
	}
	
	/**
	* 업체회원 로그아웃 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 메인페이지
	*
	*/
	@RequestMapping("logout.ag")
	public String agentLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	/**
	* 업체회원 내 정보 관리 페이지 이동용 메소드
	*
	* @version 1.0
	* @author 박민규
	* @return 업체회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@RequestMapping("updateForm.ag")
	public String agentUpdateForm() {
		return "user/agent/agentUpdateForm";
	}
	
	/**
	* 업체회원 회원정보 수정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agent
	* 		 업체회원 정보가 담긴 객체
	* @return 업체회원 회원정보 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("update.ag")
	public String agentUpdate(Agent agent,
							  Model model,
							  HttpSession session) {
		
		
		int result = agentService.updateAgent(agent);
		
		if(result > 0) {
			
			Agent loginUser = agentService.selectAgent(agent.getAgentNo());
			
			loginUser.setIdentifier("agent");
			
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
			
			return "redirect:updateForm.ag";
			
		} else {
			
			model.addAttribute("errorMsg", "회원 정보 수정에 실패했습니다. 잠시 후 다시 시도해주세요.");
			
			return "common/error";
			
		}
		
	}
	
	/**
	* 업체회원 비밀번호 변경 메소드
	* 
	*
	* @version 1.0
	* @author 박민규
	* @param agentPwd
	* 		 현재 비밀번호
	* @param newPwd
	* 		 변경할 비밀번호
	* @return 업체회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("updatePwd.ag")
	public String updatePwd(String agentPwd,
							String newPwd,
							Model model,
							HttpSession session) {
		
		Agent loginUser = (Agent)session.getAttribute("loginUser");
		
		if(bCryptPasswordEncoder.matches(agentPwd, loginUser.getAgentPwd())) {
			
			loginUser.setAgentPwd(bCryptPasswordEncoder.encode(newPwd));
			
			int result = agentService.updatePwd(loginUser);
			
			if(result > 0) {
				
				session.setAttribute("loginUser", loginUser);
				session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
				
			} else {
				
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다. 잠시후 다시 시도해주세요.");
				
				return "common/error";
			}
			
		} else {
			
			session.setAttribute("alertMsg", "현재 비밀번호가 일치하지 않습니다.");
			
		}
		
		return "redirect:updateForm.ag";

	}
	
	/**
	* 업체회원 탈퇴 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param agentNo
	* 		 업체회원 번호
	* @param agentPwd
	* 		 비밀번호
	* @return 메인페이지로 redirect
	*
	*/
	@Auth(role=Role.AGENT)
	@PostMapping("delete.ag")
	public String deleteAgent(int agentNo,
							  String agentPwd,
							  Model model,
							  HttpSession session) {
		
		Agent agent = agentService.selectAgent(agentNo);
		
		if(bCryptPasswordEncoder.matches(agentPwd, agent.getAgentPwd())) {
			
			int result = agentService.deleteAgent(agentNo);
			
			if(result > 0) {
				
				session.removeAttribute("loginUser");
				session.setAttribute("alertMsg", "성공적으로 탈퇴 되었습니다. 그동안 이용해 주셔서 감사합니다.");
				
				return "redirect:/";
				
			} else {
				
				model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다. 잠시 후 다시 시도해주세요.");
				
				return "common/error";
				
			}
			
		} else {
			
			session.setAttribute("alertMsg", "회원 탈퇴에 실패했습니다. 비밀번호를 확인하세요.");
			
			return "redirect:updateForm.ag";
			
		}
		
	}
	
	/**
	* 업체회원 상세 조회 메소드
	*
	* @version 1.0
	* @author 양아란
	* @param agentNo
	* 		 업체회원 번호
	* @return 매물 상세 조회 페이지 - 상담 예약 모달창
	*/
	@ResponseBody
	@PostMapping("select.ag")
	public Agent selectAgent(int agentNo) {
		Agent agent = agentService.selectAgent(agentNo);
		return agent;
	}
	
	/**
	* 업체회원 상세 조회 페이지 메소드
	*
	* @version 1.0
	* @author 양아란
	* @param agentNo
	* 		 업체회원 번호
	* @return 업체 회원 상세 조회 페이지
	*/
	@GetMapping("/detail.ag")
	public String detailAgent(@RequestParam(value="ano") int agentNo, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) throws Exception {
		
		// 1. 업체 회원 상세 조회
		Agent agent = agentService.selectAgent(agentNo);
		
		 if (agent != null) { 
			 
			model.addAttribute("agent", agent); 
			
			// 2. 업체 주소로 위도, 경도 값 찾기
			String url = "https://dapi.kakao.com/v2/local/search/address.json";
				   url += "?query=" + URLEncoder.encode(agent.getAgentAddress(), "UTF-8");
				   url += "&page=1&size=1";
			
			URL requestUrl = new URL(url);
			HttpURLConnection urlConn = (HttpURLConnection) requestUrl.openConnection();
			urlConn.setRequestMethod("GET");
			urlConn.setRequestProperty("Authorization", "KakaoAK cfcaaf9c4a0f2e0ba0cbc2a71f5d23a8");
			
			String line;
			String reponseText = "";
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			
			while ((line = br.readLine()) != null) {
				reponseText += line;
			}
			
			br.close();
			urlConn.disconnect();
			
			JsonObject result = JsonParser.parseString(reponseText).getAsJsonObject().get("documents").getAsJsonArray().get(0).getAsJsonObject().get("address").getAsJsonObject();
			String lat = result.get("y").getAsString();
			String lng = result.get("x").getAsString();
			
			model.addAttribute("lat", lat);
			model.addAttribute("lng", lng);
			
			// 3. 업체 매물 리스트 조회
			HashMap<String, Object> map = new HashMap<>();
			map.put("agentNo", agentNo);
			map.put("category", null);
			map.put("keyword", null);
			ArrayList<House> houseList = houseService.selectHouseList(map);
			model.addAttribute("houseList", houseList);
			
			// 4. 업체 리뷰 전체 조회
			Member m = new Member();
			m.setIdentifier("agent");
			m.setMemberNo(agentNo);
			// 페이징 처리 변수 셋팅
			int listCount = reviewService.selectListCount(m);
			int pageLimit = 5;
			int boardLimit = 5;
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			// 업체 회원 리뷰 전체 조회
			ArrayList<Review> reviewList = reviewService.agentSelectReviewList(pi, m);
			
			model.addAttribute("pi", pi);
			model.addAttribute("reviewList", reviewList);
			
			return "user/agent/agentDetailView";
		 	
		 } else { 
			model.addAttribute("errorMsg", "업체 회원 상세 조회에 실패했습니다. 다시 시도해주세요. "); 
			return "common/error"; 
		 }
	}
	
	/**
	 * 업체 회원 전체 조회 메소드
	 * 가입 미승인, 키워드 검색 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @return 업체 회원 전체 조회 페이지
	 */
	@RequestMapping("list.ag")
	public String selectAgentList(@RequestParam (value="cpage", defaultValue="1") int currentPage, Model model, String classification, String keyword) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("classification", classification);
		map.put("keyword", keyword);
		
		// 페이징 처리 변수 셋팅
		int listCount = agentService.selectListCount(map);
		int pageLimit = 5;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
					
		ArrayList<Agent> list = agentService.selectAgentList(pi, map);
		
		if (list == null) {
			model.addAttribute("errorMsg", "회원 가입 미승인 업체 회원 조회에 실패했습니다. 다시 시도해주세요. ");
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
		
		return "admin/agent/agentListView";	
	}
	
	/**
	 * 업체 회원 가입 승인, 탈퇴 처리 메소드
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @return 업체 회원 전체 조회 페이지
	 */
	@PostMapping("adminUpdate.ag")
	public String adminUpdate(Agent agent, Model model, HttpSession session) {
		int result = agentService.adminUpdate(agent);
		if (result > 0) {
			session.setAttribute("alertMsg", "업체 회원 수정이 완료되었습니다.");
			return "redirect:/list.ag";
		} else {
			model.addAttribute("errorMsg", "업체 회원 수정에 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
	}
	
	


}
