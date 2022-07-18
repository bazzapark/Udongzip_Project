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
  
  <!-- js -->
  <script type="text/javascript" src="resources/js/user/memberEnrollForm.js"></script>

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
      width: 60%;
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
    
    /***** 유효성 검사 관련 스타일 *****/
    
    .validate-area {
    	margin-top: 10px;
    	font-size: 12px;
    	color: gray;
    }
    
    .possible {
    	color: green;
    }
    
    .impossible {
    	color: red;
    }
    
    .button {
        width: 100px !important;
        height: 30px !important;
        font-size: 16px !important;
        border: none !important;
        border-radius: 4px !important;
        cursor: pointer !important;
    }
    
   	#id-area {
   		position: relative !important;
   	}
    
    #idCheck {
    	margin-left: 10px !important;
    	color: #595959 !important;
    	font-size: 13px !important;
    	position: absolute !important;
    	right: 10px !important;
    	top: 15px !important;
    }
    
    #email-area {
   		position: relative !important;
   	}
    
    #emailCheck {
    	margin-left: 10px !important;
    	color: #595959 !important;
    	font-size: 13px !important;
    	position: absolute !important;
    	right: 10px !important;
    	top: 15px !important;
    }
    
    .modal-table {
        width: 350px;
        margin: 20px auto;
        border-collapse: collapse;
        table-layout: fixed;
        text-align: center;
    }

    .modal-table th {
        font-weight: 600;
        font-size: 16px;
    }
    
    .modal-table tr {
        height: 30px;
        margin-top: 20px;
    }

    .modal {
        position: absolute;
        top: 0;
        left: 0;

        width: 100%;
        height: 100%;

        display: none;

        background-color: rgba(0, 0, 0, 0.4);
    }

    .modal.show {
        display: block;
    }

    .modal-body {
        position: absolute;
        top: 50%;
        left: 50%;

        width: 400px;
        height: 300px;

        padding: 40px;

        text-align: center;

        background-color: rgb(255, 255, 255);
        border-radius: 10px;
        box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);

        transform: translateX(-50%) translateY(-50%);
    }
    
    .confirm-btn {
    	background-color: #0057A4;
    	color: #fff;
    }
    
    .close-btn {
    	color: #595959;
    }
    
    #timer-area {
    	height: 20px;
    	width: 200px;
    	font-size: 12px;
    	text-align: left;
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
        <div class="form-floating mb-2" id="id-area">
          <input type="text" class="form-control" id="memberId" placeholder="아이디" name="memberId">
          <label for="">아이디</label>
          <button type="button" class="button" id="idCheck">중복 확인</button>
          <div class="validate-area" id="id-validate"></div>
        </div>
      
        <div class="form-floating mb-1">
          <input type="password" class="form-control" id="memberPwd" placeholder="비밀번호" name="memberPwd">
          <label for="">비밀번호</label>
          <div class="validate-area" id="pwd-validate"></div>
        </div>
        
        <div class="form-floating mb-3">
          <input type="password" class="form-control" id="checkPwd" placeholder="비밀번호 재확인">
          <label for="">비밀번호 재확인</label>
          <div class="validate-area" id="check-validate"></div>
        </div>
        
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberName" placeholder="이름" name="memberName">
          <label for="memberName">이름</label>
        </div>
        
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberPhone" placeholder="연락처" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" name="memberPhone">
          <label for="">휴대전화</label>
        </div>
        <div class="form-floating mb-5" id="email-area">
          <input type="email" class="form-control" id="memberEmail" placeholder="이메일" name="memberEmail">
          <label for="">이메일</label>
          <button type="button" class="button" id="emailCheck">이메일 인증</button>
        </div>

        <button type="submit" class="btn btn-primary" onclick="return checkValidate();">가입하기</button>
      <!-- btn btn-primary disabled -->
      </form>
      <!------- 개인회원가입폼 끝 ------->

    </div>
    <!-- 아이디 중복검사 -->
    <script>
    
    $(function() {
		$("#loginandEnroll-btn").attr("disabled", true);
	});
    	
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
  
                  <div class="modal" id="email-modal">
                    <div class="modal-body">
        
                        <h3>이메일 인증</h3>
                        <hr>
                        <form>
                        	<br>
                        	<div id="timer-area">인증 제한시간 : <span id="timer"></span></div>
                        	<div class="form-floating">
			                	<input type="text" id="code" class="form-control" pattern="[0-9]" maxlength="5">
			                    <label for="code">인증번호</label>
			               	</div>
			               	<br>
                            <button type="button" class="button confirm-btn">인증</button>
                            <button type="button" class="button close-btn">취소</button>
                        </form>
                    </div>
                </div>
                
                <div id="loading" style="margin-left: 0px;">
					<img src="https://www.railtrip.co.kr/image/loading2.gif">
    			</div>
 
</body>
<script>

	var authCode;

	$(function() {
		
		$("#emailCheck").on("click", function() {
			
			if($("#memberEmail").val().length == 0) {
				
				alert("이메일을 입력하세요.");
				
			} else {
				
				$("#loading").show();
				
				$.ajax({
					url : "emailCheck.me",
					data : { email : $("#memberEmail").val() },
					type : "post",
					success : function(data) {
						
						$("#loading").hide();
						
						if(data == 'NNNNN') {
							
							alert("이미 가입된 이메일입니다.");
							
						} else {
							
							alert("인증번호가 발송되었습니다.");
							
							authCode = data;
							
							timer();
							
							openModal();
							
						}
						
					},
					error : function() {
						alert("인증번호 발송에 실패했습니다.");
					}
				});
				
			};
			
		});
		
	});
</script>
</html>