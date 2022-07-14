<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- 파비콘 -->
<link rel="shortcut icon" type="image/x-icon" href="resources/images/favicon.ico" >

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&display=swap" rel="stylesheet">

<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/common/common.css">

</head>

	<!-- 1회성 알림문구 기능 -->
	<c:if test="${ !empty alertMsg }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>

<body>
	<!-- 로그인 모달창 -->
	<div class="modal fade" id="loginForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-sm">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="">로그인</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form action="login.me" method="post" id="login-modal-form">
		        <div class="form-check form-check-inline mb-3 membership">
		            <input class="form-check-input" type="radio" name="membership" id="personal2" value="member" checked>
		            <label class="form-check-label" for="personal2">
		              	개인회원
		            </label>
		        </div>
		        <div class="form-check form-check-inline membership">
		            <input class="form-check-input" type="radio" name="membership" id="agent2" value="agent">
		            <label class="form-check-label" for="agent2">
		             	업체회원
		            </label>
		        </div>
	          <div class="form-floating">
	            <input type="text" class="form-control" placeholder="아이디" name="memberId" value="${ cookie.saveId.value }">
	            <label for="">아이디</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input type="password" class="form-control" placeholder="비밀번호" autoComplete="off" name="memberPwd">
	            <label for="">비밀번호</label>
	          </div>
	          <div class="mb-3">
	            <div class="form-check" id="loginFormCheckbox">
	            	<c:choose>
		               	<c:when test="${ !empty cookie.saveId }">
		                	<input type="checkbox" class="form-check-input" id="loginCheck" name="loginCheck" value="y" checked>
		                </c:when>
		                <c:otherwise>
		                	<input type="checkbox" class="form-check-input" id="loginCheck" name="loginCheck" value="y">
		              	</c:otherwise>
		             </c:choose>
	              <label class="form-check-label" for="loginCheck">
	                	아이디 저장
	              </label>
	              <a class="" href="#" id="changePwd">비밀번호 재설정</a>
	            </div>
	          </div>
	          <button type="submit" class="btn btn-primary">로그인</button>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <a class="" href="enrollForm.me">개인회원 가입</a>
	        <a class="" href="enrollForm.ag">업체회원 가입</a>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!------- 헤더(메뉴바) 시작 ------->
	<nav class="navbar fixed-top navbar-expand-lg bg-white">
	  <div class="container-fluid">
	
	    <!-- 로고 -->
	    <a class="navbar-udong" href="/udongzip">
	      <img src="resources/images/logo.png" alt="" width="70" height="50" class="d-inline-block align-text-center">
	      <span id="logoText">
	        <div id="logoText1">우동집</div>
	        <div id="logoText2">우리 동네 집 모아보기</div>
	      </span>
	    </a>
	
	    <div class="navbar-nav">
		
		<c:choose>
		
			<c:when test="${ empty loginUser || loginUser.identifier eq 'member' }">
		      <!-- 메뉴 - 일반회원 -->
		      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
		        <li class="nav-item">
		          <a class="nav-link" href="list.ma">매물 조회</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="#">채팅 문의</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="faq.no" id="" aria-expanded="false">
		           	 고객 센터
		          </a>
		        </li>
		      </ul>
	      </c:when>
			
		  <c:when test="${ !empty loginUser && loginUser.identifier eq 'agent' }">
		      <!-- 메뉴 - 업체회원 -->
		      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
		        <li class="nav-item">
		          <a class="nav-link" href="#">채팅 관리</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="faq.no" id="" aria-expanded="false">
		           	 고객 센터
		          </a>
		        </li>
		      </ul> 
	      </c:when>
		  
		  <c:when test="${ !empty loginUser && loginUser.identifier eq 'admin' }">
		      <!-- 메뉴 - 관리자 -->
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
		        <li class="nav-item">
		          <a class="nav-link" href="#">일반 회원 관리</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="#">업체 회원 관리</a>
		        </li>
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            신고·요청 관리
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="">
		            <li>
		              <a class="dropdown-item" href="#">허위 매물 신고</a>
		            </li>
		            <li>
		              <a class="dropdown-item" href="#">리뷰 삭제 요청</a>
		            </li>
		          </ul>
		        </li>
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            	고객 센터 관리
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="">
		            <li>
		              <a class="dropdown-item" href="adminlist.no">공지사항</a>
		            </li>
		            <li>
		              <a class="dropdown-item" href="adminlist.in">1:1문의</a>
		            </li>
		          </ul>
		        </li>
		      </ul>
	      </c:when>
	    </c:choose>
	
		<c:choose>
		
			<c:when test="${ empty loginUser }">
		      <!-- 버튼 - 로그아웃시 -->
		      <div class="btnGroup d-flex align-items-center">
		        <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#loginForm">
		          	로그인 | 회원가입
		        </button>
		      </div>
	      	</c:when>
	      
			<c:when test="${ !empty loginUser && loginUser.identifier eq 'member' }">
		      <!-- 버튼 - 로그인시 - 일반 회원 -->
		      <div class="btnGroup d-flex align-items-center">
		        <div class="dropdown">
		          <button class="btn btn-link nav-link px-3 me-2 dropdown-toggle" type="button" id="" data-bs-toggle="dropdown">
		            마이페이지
		          </button>
		          <ul class="dropdown-menu" aria-labelledby="">
		            <li><a class="dropdown-item" href="myPage.me">정보 수정</a></li>
		            <li><a class="dropdown-item" href="#">예약 내역</a></li>
		            <li><a class="dropdown-item" href="#">찜한 매물</a></li>
		            <li><a class="dropdown-item" href="#">리뷰 관리</a></li>
		            <li><a class="dropdown-item" href="#">1:1 문의 내역</a></li>
		          </ul>
		        </div>
		        <button class="btn btn-primary" type="button" onclick="location.href='logout.me';">로그아웃</button>
		      </div>
	      	</c:when>

			<c:when test="${ !empty loginUser && loginUser.identifier eq 'agent' }">
		      <!-- 버튼 - 로그인시 - 업체 회원 -->
		      <div class="btnGroup d-flex align-items-center">
		        <div class="dropdown">
		          <button class="btn btn-link nav-link px-3 me-2 dropdown-toggle" type="button" id="" data-bs-toggle="dropdown">
		            마이페이지
		          </button>
		          <ul class="dropdown-menu" aria-labelledby="">
		            <li><a class="dropdown-item" href="updateForm.ag">정보 수정</a></li>
		            <li><a class="dropdown-item" href="reservation.ag">상담 예약 관리</a></li>
		            <li><a class="dropdown-item" href="house.ag">매물 관리</a></li>
		            <li><a class="dropdown-item" href="review.ag">리뷰 삭제 요청</a></li>
		            <li><a class="dropdown-item" href="inquiry.ag">1:1 문의 내역</a></li>
		          </ul>
		        </div>
		        <button class="btn btn-primary" type="button" onclick="location.href='logout.ag'">로그아웃</button>
		      </div>
	      	</c:when>
	
			<c:when test="${ !empty loginUser && loginUser.identifier eq 'admin' }">
		      <!-- 버튼 - 로그인시 - 관리자 -->
		      <div class="btnGroup d-flex align-items-center">
		        <button class="btn btn-primary" type="button">로그아웃</button>
		      </div>
	      	</c:when>
	      
	    </c:choose>
	
	    </div>
	  </div>
	</nav>
	
		        <div class="pwdmodal" id="pwd-modal">
                    <div class="pwdmodal-body">
        
                        <h3>비밀번호 재설정</h3>
                        <hr>
                        <form>
                            <table class="pwdmodal-table">
                            	<tr>
                            		<td colspan="4">
                            			비밀번호를 재설정할 아이디를 입력하세요.
                            		</td>
                            	</tr>
                                <tr style="height: 100px;">
                                    <td colspan="4">
                                    	<div class="form-floating">
								            <input type="text" class="form-control" placeholder="아이디" name="userId" id="userId">
								        	<label for="">아이디</label>
								        </div>
                                    </td>
                                </tr>
                            </table>
                            <button type="button" class="pwd-button pwd-confirm-btn">확인</button>
                            <button type="button" class="pwd-button pwd-close-btn">취소</button>
                        </form>
                    </div>
                </div>
	<!------- 헤더(메뉴바) 끝 ------->
	
	<script>
		$(function() {
			
			var findPwdAction;
				
			$("input[type=radio]").on("change", function() {
				
				if($(this).val() == "member") {
					$("#login-modal-form").attr("action", "login.me");
					findPwdAction = "findPwd.me";
				} else {
					$("#login-modal-form").attr("action", "login.ag");
					findPwdAction = "findPwd.ag";
				}
				
			});
			
			$("#changePwd").on("click", function() {
				
				$("#loginForm").modal("hide");
				$("#pwd-modal").show();
				
			});
			
			$(".pwd-confirm-btn").on("click", function() {
				
				$.ajax({
					url : findPwdAction,
					data : { userId : $("#userId").val() },
					type : "POST",
					success : function(data) {
						
						console.log(data);
						
						if(data == "NNNNY") {
							
							alert("가입된 이메일로 임시비밀번호가 전송되었습니다");
							$("#pwd-modal").hide();
							
						} else {
							
							alert("가입되지 않은 아이디입니다.\n회원 분류(개인/업체)를 확인해보세요.");
							
						}
						
					},
					error : function() {
						alert("임시비밀번호 발급에 실패했습니다.");
						$("#pwd-modal").hide();
					}
				})
				
			});
			
			$(".pwd-close-btn").on("click", function() {
				
				$("#findId").val("");
				$("#pwd-modal").hide();
				
			});
			
		})
	</script>
</body>
</html>