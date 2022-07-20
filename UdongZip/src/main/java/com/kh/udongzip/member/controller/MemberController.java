package com.kh.udongzip.member.controller;

import java.util.ArrayList;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.udongzip.agent.model.service.AgentService;
import com.kh.udongzip.common.model.vo.PageInfo;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.common.template.Pagination;
import com.kh.udongzip.common.template.TemporaryPassword;
import com.kh.udongzip.member.model.service.MemberService;
import com.kh.udongzip.member.model.vo.Member;


@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private TemporaryPassword temporaryPassword;
	
	/**
	* 개인회원 비밀번호 재설정 메소드
	*
	* @version 1.0
	* @author 박민규
	* @param userId
	* 		 재설정하고자 하는 아이디
	* @return 임시비밀번호 발급 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="findPwd.me", produces="text/html; charset=UTF-8")
	public String findPwd(@RequestParam("userId") String memberId) {
		
		Member member = memberService.findPwd(memberId);
		
		if(member != null) {
			
			String email = member.getMemberEmail();
			String tmpPassword = temporaryPassword.getRandomPassword(10);;
			
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
	        
	        member.setMemberPwd(bCryptPasswordEncoder.encode(tmpPassword));
	        
	        int result = memberService.updatePwd(member);
	        
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
	* 개인회원 회원가입 ID 중복 체크 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @return 중복확인 결과
	*
	*/
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String IdChek(String memberId) {
		
		int agentIdCount = agentService.agentIdCheck(memberId);
		
		int memberIdCount = memberService.memberIdCheck(memberId);
			
		return ((agentIdCount + memberIdCount) > 0) ? "NNNNN" : "NNNNY";
	}
	
	/**
	* 개인회원 회원가입 email 인증 메소드 (ajax)
	*
	* @version 1.0
	* @author 박민규
	* @param email
	*        가입하려는 이메일
	* @return 인증번호 발송 결과
	*
	*/
	@ResponseBody
	@PostMapping(value="emailCheck.me", produces="text/html; charset=UTF-8")
	public String emailChek(String email) {
		
		int result = memberService.memberEmailCheck(email);
		
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
	* 개인회원 비밀번호 변경 메소드
	* 
	*
	* @version 1.0
	* @author 박민규
	* @param memberPwd
	* 		 현재 비밀번호
	* @param newPwd
	* 		 변경할 비밀번호
	* @return 개인회원 정보관리 페이지
	*
	*/
	@Auth(role=Role.MEMBER)
	@PostMapping("updatePwd.me")
	public String updatePwd(String memberPwd,
							String newPwd,
							Model model,
							HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if(bCryptPasswordEncoder.matches(memberPwd, loginUser.getMemberPwd())) {
			
			loginUser.setMemberPwd(bCryptPasswordEncoder.encode(newPwd));
			
			int result = memberService.updatePwd(loginUser);
			
			if(result > 0) {
				
				session.setAttribute("loginUser", loginUser);
				session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
				
				session.removeAttribute("loginUser");
				
				return "redirect:/";
				
			} else {
				
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다. 잠시후 다시 시도해주세요.");
				
				return "common/error";
			}
			
		} else {
			
			session.setAttribute("alertMsg", "현재 비밀번호가 일치하지 않습니다.");
			return "redirect:myPage.me";
			
		}
		

	}
	
	//로그인
	@RequestMapping(value="login.me")
	public ModelAndView loginMember(
							Member member,
							String loginCheck,
							HttpServletResponse response,
							ModelAndView mv,
							HttpSession session
							) {
// System.out.println("### MemberController : liginMember :: getMemberId = ["+ member.getMemberId() +"]");
// System.out.println("### MemberController : liginMember :: getMemberPwd = ["+ member.getMemberPwd() +"]");
		
	// 암호화 후 로그인

	Member loginUser = memberService.selectMember(member);
	// 아이디만 일치 하는지 확인 체크
	
	// 비밀번호도 일치하는지 체크
	
	if(loginUser != null && bCryptPasswordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) { //로그인성공
		
		// 아이디 저장 체크 시
		if(loginCheck != null && loginCheck.equals("y")) {
						
			Cookie cookie = new Cookie("saveId", loginUser.getMemberId());
			cookie.setMaxAge(1 * 24 * 60 * 60);
			response.addCookie(cookie);
								
		} else { // 체크 안한 경우
								
			Cookie cookie = new Cookie("saveId", loginUser.getMemberId());
			cookie.setMaxAge(0);
			response.addCookie(cookie);
								
		};
		
		loginUser.setIdentifier("member");
		
		if(loginUser.getMemberId().equals("admin")) {
			loginUser.setIdentifier("root");
		}
		
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("alertMsg", "로그인에 성공했습니다."); //1회 알람문구
	
	}
	else { // 로그인 실패
		
		session.setAttribute("alertMsg", "아이디 또는 비밀번호를 확인하세요."); //1회 알람문구
		
	}
	
	mv.setViewName("redirect:/");
	
	return mv;

	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.invalidate();
		
		// 메인페이지로 url 재요청
		return "redirect:/";
	}
	
	// 회원가입 폼을 띄어주는 용도
	@RequestMapping("enrollForm.me")
	public String enrollForm() {
		
		// 회원가입 폼 띄어주기
		// /WEB-INF/views/user/member/memberEnrollForm.jsp
		
		return "user/member/memberEnrollForm";
	}
	
	// 회원가입 기능
	@RequestMapping("insert.me")
	public String insertMember(Member member, Model model, HttpSession session) {
		

		 // System.out.println(member);
		 
		 // 암호화 등록 완료 
		 
		// System.out.println("평문 : " + member.getMemberPwd());
		
		String encPwd = bCryptPasswordEncoder.encode(member.getMemberPwd());
		 System.out.println("암호화 : " + encPwd);
		
		System.out.println(encPwd);
		
		member.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(member);
		
		if(result > 0) { // 성공
			
			// 1회성 알람메세지 
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");
			
			return "redirect:/";
		}
		else { // 실패
			
			model.addAttribute("errorMsg","회원가입 실패");
			return "common/error";
		}	
	}
	
	// 회원정보 수정 폼
	@RequestMapping("myPage.me")
	public String myPage() {
		
		// 회원정보 수정 폼 띄어주기
		return "user/member/myPage";
	}
	
	// 회원정보 수정
	@RequestMapping("update.me")
	public String updateMember(Member member, Model model, HttpSession session) {
		
		int result = memberService.updateMember(member);
		
		if(result > 0) {
			
		Member updateMem = memberService.selectMember(member);
		
		updateMem.setIdentifier("member");
		
		session.setAttribute("loginUser", updateMem);
		
		// 1회성 알람메세지 
		session.setAttribute("alertMsg", "회원정보가 수정 되었습니다.");
					
		return "redirect:myPage.me";
		}
		else {
			
			model.addAttribute("errorMsg", "회원정보 변경 실패");
			
			return "common/error";
		}
	}
	
	// 회원탈퇴 
	@RequestMapping("delete.me")
	public String deleteMemer(int memberNo, HttpSession session, Model model) {
		
		int result = memberService.deleteMember(memberNo);
		
		if(result > 0) { // 탈퇴 성공
			
			session.removeAttribute("loginUser");
			session.setAttribute("alertMsg", "성공적으로 탈퇴되었습니다.");
			
			return "redirect:/";
		}
		else { // 실패
			
			model.addAttribute("errorMsg", "회원 탈퇴 실패");
			
			return "common/error";
		}
	}
	
	/**
	 * 개인 회원 전체 조회 메소드 : 어드민
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param cpage 현재 페이지
	 * @param keyword 검색 키워드
	 * @param model 모델 객체
	 * 
	 * @return 개인 회원 전체 조회 페이지
	 */
	@Auth(role=Role.ADMIN)
	@RequestMapping("list.me")
	public String selectMemberList(@RequestParam (value="cpage", defaultValue="1") int currentPage, Model model, String keyword) {
		
		// 페이징 처리 변수 셋팅
		int listCount = memberService.selectListCount(keyword);
		int pageLimit = 5;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
					
		ArrayList<Member> list = memberService.selectMemberList(pi, keyword);
		
		if (list == null) {
			model.addAttribute("errorMsg", "개인 회원 전체 조회에 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		if (keyword != null) {
			model.addAttribute("keyword", "&keyword=" + keyword);
		}
		
		return "admin/member/memberListView";
	}
	
	/**
	 * 개인 회원 상세 조회 메소드 : 어드민
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param memberNo 개인 회원 번호
	 * 
	 * @return 개인 회원 상세 조회 모달창
	 */
	@Auth(role=Role.ADMIN)
	@ResponseBody
	@PostMapping("select.me")
	public Member selectMember(int memberNo) {
		
		Member member = memberService.selectMember(memberNo);
		
		return member;
	}
	
	/**
	 * 개인 회원 탈퇴 메소드 : 어드민
	 * 
	 * @version 1.0
	 * @author 양아란
	 * 
	 * @param memberNo 개인 회원 번호
	 * @param model 모델 객체
	 * @param session 세션 객체
	 * 
	 * @return 개인 회원 상세 조회 페이지
	 */
	@Auth(role=Role.ADMIN)
	@PostMapping("adminDelete.me")
	public String adminDeleteMember(int memberNo, Model model, HttpSession session) {
		int result = memberService.deleteMember(memberNo);
		if (result > 0) {
			session.setAttribute("alertMsg", "개인 회원 수정이 완료되었습니다.");
			return "redirect:/list.me";
		} else {
			model.addAttribute("errorMsg", "개인 회원 수정에 실패했습니다. 다시 시도해주세요. ");
			return "common/error";
		}
	}
	
	// 이용약관 띄어주는 폼
		@RequestMapping("regFormImpl.me")
		public String regFormImpl() {
			
			// 회원가입 폼 띄어주기
			// /WEB-INF/views/user/member/memberEnrollForm.jsp
			
			return "user/member/regFormImpl";
		}
	
	@RequestMapping("termsofService.ud")
	public String termsofService() {
		return "common/termsOfService";
	}
	
	@RequestMapping("privacy.ud")
	public String privacyPolicy() {
		return "common/privacyPolicy";
	}
	
	@RequestMapping("management.ud")
	public String houseManagement() {
		return "common/houseManagement";
	}
		
		
}
