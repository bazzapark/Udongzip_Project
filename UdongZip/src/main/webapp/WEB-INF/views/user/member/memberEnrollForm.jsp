<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
  
  <!-- jQuery 라이브러리 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <!-- 부트스트랩 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&display=swap" rel="stylesheet">

  <style>
    /***** 공통 스타일 시작 *****/
    body {
      height: 100vh;
      font-size: 16px;
      font-family: 'Nanum Gothic', sans-serif; /* 깔끔 폰트 */
    }
    /**** 공통 - a 태그 ****/
    a {
      text-decoration: none;
      color: black;
    }
    a:hover {
      text-decoration: none;
    }
    section.outer {
      width: 60%;
      padding-top: 50px;
      margin: auto;
    }
    .inner {
      margin: 50px;
    }
    /***** 공통 스타일 끝 *****/

    /***** 회원가입 폼 스타일 시작 *****/
    .inner #enrollForm {
      width: 50%;
      margin: auto;
      padding: 50px;
      border: 1px solid rgb(231, 231, 231);
      border-radius: 20px;
    }
    .inner #enrollForm .title1 {
      font-size: 30px;
      font-weight: 900;
    }
    .inner #enrollForm .title2 {
      font-size: 14px;
      font-weight: 900;
    }
    .inner #enrollForm .form-text {
      font-size: 12px;
      padding-left: 10px;
    }
    .inner #enrollForm button {
      display: block;
      margin: auto;
      width: 100%;
      font-weight: 900;
    }
    /***** 회원가입 폼 스타일 끝 *****/
  </style>
</head>
<body>


  <jsp:include page="../../common/header.jsp" />

  <section class=outer>
    <div class="inner">

      <!------- 개인회원가입폼 시작 ------->
      <form id="enrollForm" action="insert.me" method="post">
        <div class="mb-5 title1">개인 회원 정보 입력</div>
        <div class="mb-5 title2">우동집 서비스 이용을 위해 아래 정보를 입력해주세요.</div>
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberId" placeholder="아이디" name="memberId">
          <label for="memberId">아이디</label>
          <br>
          <!-- 아이디 중복 추가  -->
          <div id="checkResult" style="font-size:0.8em; display:none;"></div>
          
          <div id="" class="form-text">5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</div>
        </div>
      
        <div class="form-floating mb-1">
          <input type="password" class="form-control" id="memberPwd" placeholder="비밀번호" name="memberPwd">
          <label for="memberPwd">비밀번호</label>
          <div id="" class="form-text"></div>
        </div>
        
        <div class="form-floating mb-3">
          <input type="password" class="form-control" id="checkPwd" placeholder="비밀번호 재확인">
          <label for="checkPwd">비밀번호 재확인</label>
          <div id="" class="form-text">비밀번호 재확인 유효성 검사 결과 입력칸</div>
        </div>
        
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberName" placeholder="이름" name="memberName">
          <label for="memberName">이름</label>
        </div>
        
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberPhone" placeholder="연락처" name="memberPhone">
          <label for="memberPhone">휴대전화</label>
        </div>
        
        <div class="form-floating mb-5">
          <input type="email" class="form-control" id="memberEmail" placeholder="이메일" name="memberEmail">
          <label for="memberEmail">이메일</label>
        </div>

        <button type="submit" class="btn btn-primary" disabled>가입하기</button>
      <!-- btn btn-primary disabled -->
      </form>
      <!------- 개인회원가입폼 끝 ------->

    </div>
    <!-- 아이디 중복검사 -->
    <script>
    	$(function() {
    		
    		var $idInput = $("#enrollForm input[name=memberId]");
    		
    		$idInput.keyup(function() {
    			
    			// console.log($idInput.val());
    			if($idInput.val().length >= 5) { // 5글자 이상
    				
    				$.ajax({
    					url : "idCheck.me",
    					data : {checkId : $idInput.val()},
    					success : function(result) {
    						
    						if(result == "NNNNN") { // 사용 불가능
    							
    							$("#checkResult").show();
    							$("#checkResult").css("color", "red").text("중복된 아이디가 존재합니다. 다시입력해 주세요.");
    							
    							$("#enrollForm :submit").attr("disabled". true);
    							
    						}
    						else { // 사용 가능
    							
    							$("#checkResult").show();
    						    $("#checkResult").css("color", "blue").text("사용가능한 아이디 입니다.");
    						    
    						    $("#enrollForm :submit").attr("disabled", false);
    						}
    						
    					},
    					error : function() {
    						
    						console.log("아이디 중복 체크용 ajax 통신 실패!");
    					}
    				});
    			}
    			else { // 5글자 미만일 경우
    				
    				$("#checkResult").hide();
    				$("#enrollForm :submit").attr("disabled", true);
    			}
    		});
    	});
    </script>
    
  <jsp:include page="../../common/footer.jsp" />
 
</body>
</html>