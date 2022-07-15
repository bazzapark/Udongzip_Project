package com.kh.udongzip.common.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.udongzip.agent.model.vo.Agent;
import com.kh.udongzip.member.model.vo.Member;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception {
		
		// 1. handler 종류 확인
		// Controller에 있는 method에만 적용되도록
		if(handler instanceof HandlerMethod == false) {
			
			// Controller에 있는 method가 아닌 경우 true 리턴
			// 해당 method 그대로 실행
			return true;
			
		}
		
		// 2. 형 변환
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		
		// 3. @Auth 받아오기
		Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
		
		// 4. method에 @Auth가 없는 경우인지 확인 (권한 인증이 필요업는 경우)
		if(auth == null) {
			
			// 해당 method 그대로 실행
			return true;
			
		}
		
		// 5. @Auth가 있는 경우 처리 (권한 인증이 필요한 경우)
		HttpSession session = request.getSession();
		
		if(session == null) { // 세션이 없으면
			
			// 메인 페이지로 보냄
			response.sendRedirect(request.getContextPath());
			// 해당 method 실행하지 않음
			return false;
			
		}
		
		// 6. 세션이 존재하는 경우, 권한이 유효한지 확인
		
		String identifier = "";
		
		if(session.getAttribute("loginUser") instanceof Member) { // 로그인 정보가 개인인 경우
			
			Member loginUser = (Member)session.getAttribute("loginUser");
			
			identifier = loginUser.getIdentifier();
			
		} else if(session.getAttribute("loginUser") instanceof Agent) { // 로그인 정보가 업체인 경우
			
			Agent loginUser = (Agent)session.getAttribute("loginUser");
			
			identifier = loginUser.getIdentifier();
			
		} else if(session.getAttribute("loginUser") == null) { // 로그인 정보가 없으면
			
			session.setAttribute("alertMsg", "로그인이 필요한 서비스입니다.");
			// 메인 페이지로 보냄
			response.sendRedirect(request.getContextPath());
			// 해당 method 실행하지 않음
			return false;
			
		}
		
		// 7. 요구 권한에 따른 처리
		String role = auth.role().toString();
		
		System.out.println(role);
		
		if(role.equals("ADMIN")) { // 권한이 어드민인 경우
			
			if(!identifier.equals("root")) { // 식별자가 root가 아니면
				
				System.out.println(identifier);
				
				session.setAttribute("alertMsg", "접근 권한이 없습니다.");
				// 메인 페이지로 보냄
				response.sendRedirect(request.getContextPath());
				// 해당 method 실행하지 않음
				return false;
				
			}
			
		} else if(role.equals("AGENT")) { // 권한이 업체인 경우
			
			if("member".equals(identifier)) { // 식별자가 root나 agent가 아닌 경우
				
				System.out.println(identifier);
				
				session.setAttribute("alertMsg", "잘못된 접근입니다.");
				// 메인 페이지로 보냄
				response.sendRedirect(request.getContextPath());
				// 해당 method 실행하지 않음
				return false;
				
			}
			
		} else if(role.equals("MEMBER")) { // 권한이 개인인 경우
			
			if(identifier.equals("agent")) { // 식별자가 root나 member가 아닌 경우
				
				System.out.println(identifier);
				
				session.setAttribute("alertMsg", "잘못된 접근입니다.");
				// 메인 페이지로 보냄
				response.sendRedirect(request.getContextPath());
				// 해당 method 실행하지 않음
				return false;
				
			}
			
		} else if(role.equals("LOGINUSER")) { // 권한이 로그인한 유저인 경우
			
			if(session.getAttribute("loginUser") == null) {
				
				session.setAttribute("alertMsg", "로그인이 필요한 서비스입니다.");
				// 메인 페이지로 보냄
				response.sendRedirect(request.getContextPath());
				// 해당 method 실행하지 않음
				return false;
				
			}
			
		}
		
		// 8. 접근 허가 (method 실행)
		return true;
	
	}
	
	
}
