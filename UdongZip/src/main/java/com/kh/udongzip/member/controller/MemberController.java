package com.kh.udongzip.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.udongzip.member.model.service.MemberService;
import com.kh.udongzip.member.model.vo.Member;


@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//로그인
	@RequestMapping(value="login.me")
	public ModelAndView loginMember(
							Member member,
							ModelAndView mv,
							HttpSession session
							) {
System.out.println("### MemberController : liginMember :: getMemberId = ["+ member.getMemberId() +"]");
System.out.println("### MemberController : liginMember :: getMemberPwd = ["+ member.getMemberPwd() +"]");
		
	// 암호화 후 로그인

	Member loginUser = memberService.selectMember(member);
	
	// 아이디만 일치 하는지 확인 체크
	
	// 비밀반호도 일치하는지 체크
	
	if(loginUser != null && bCryptPasswordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) { //로그인성공
		
		loginUser.setIdentifier("member");
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("alertMsg", "로그인에 성공했습니다."); //1회 알람문구
	
		mv.setViewName("redirect:/");
	}
	else { // 로그인 실패
		
		mv.addObject("errorMsg", "로그인 실패");
		mv.setViewName("common/error");
		
	}
	return mv;
	// 암호화 전
	/*
	Member loginUser = memberService.selectMember(member);
         
		
		// System.out.println(loginUser);
		
		if(loginUser == null) { // 실패
			
			mv.addObject("errorMsg","로그인 실패");
			
			mv.setViewName("common/error");
		}
		else { // 성공
			
			// session.setAttribute("loginUser", loginUser);
			// model.addAttribute("loginUser", loginUser);
			
			mv.setViewName("redirect:/");
		}
		return mv;
		*/
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
		
// System.out.println("### MemberController : insertMember :: getMemberId = ["+ member.getMemberId() +"]");
// System.out.println("### MemberController : insertMember :: getMemberPwd = ["+ member.getMemberPwd() +"]");
// System.out.println("### MemberController : insertMember :: getMemberEmail = ["+ member.getMemberEmail() +"]");

		 // System.out.println(member);
		 
		 // 암호화 등록 완료 
		 
		// System.out.println("평문 : " + member.getMemberPwd());
		
		String encPwd = bCryptPasswordEncoder.encode(member.getMemberPwd());
		// System.out.println("암호화 : " + encPwd);
		
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
			
		session.setAttribute("loginUser", updateMem);
		session.setAttribute("alertMag", updateMem);
		
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
	
}