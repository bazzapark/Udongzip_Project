<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

     <!-- jQuery 라이브러리 -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
     <!-- 폰트 -->
     <link rel="preconnect" href="https://fonts.googleapis.com">
     <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
     <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&display=swap" rel="stylesheet">
     
     <!-- js -->
	<script type="text/javascript" src="resources/js/user/myPage.js"></script>

	<!-- CSS 파일 -->
	<link rel="stylesheet" href="resources/css/common/common.css" />
	
     <style>
        .content {
            background-color: white;
            width: 80%;
            margin: auto;
        }
        
        .innerOuter form {
            border:1px solid lightgray;
            width: 600px;
            margin: auto;
            padding: 5% 10%;
            background-color: white;
        }
        
        /***** 유효성 검사 관련 스타일 *****/
	    .confirm-btn {
	    	background-color: #0057A4;
	    }
	    
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
	    
	    #timer-area {
	    	height: 20px;
	    	width: 200px;
	    	font-size: 12px;
	    	text-align: left;
	    }
    	
    	.form-group {
    		position: relative !important;
    	}
    	
    	#emailCheck {
    		color: #595959;
    		position: absolute;
    		right: -100px;
    		bottom: 5px;
    	}
    	    
	    .button {
	    	width: 90px;
	        height: 30px;
	        font-size: 15px;
	        color: #fff;
	        border: none;
	        border-radius: 4px;
	        cursor: pointer;
	    }
    </style>
</head>
<body>


    <jsp:include page="../../common/header.jsp" />
	
    <div class="content">
    <div class="modal" id="outForm" tabindex="-1" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title" id="">회원탈퇴</h5>
		  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		
		<form action="delete.me" method="post">
		<pre>회원탈퇴 하시겠습니까?
		
		회원탈퇴와 동시에 서비스 이용내역 및 모든 데이터가 삭제 됩니다. 
		이후 동일 계정으로 가입이 가능하지만 기록은 남아있지 않습니다.
		            
		그동안 우리동네집구하기를 이용해 주셔서 감사합니다.
		앞으로 보다 나은 서비스를 제공할 수 있도록 노력하겠습니다.
		</pre>
	         <input type="hidden" name="memberNo" value="${ loginUser.memberNo }">
	        <div align="center">
	    <button type="submit" class="btn btn-primary">탈퇴하기</button>
	
	    </div>
	  </form>
	  
	</div>
	</div>
	</div>
        <br><br>
        <div class="innerOuter">
            <br>

            <form action="update.me" method="post" id="member-update-form">
                <div class="form-group" style="width: 300px;">
                    <label for="memberId">* 아이디 </label > <br>
                    <input type="text" class="form-control" id="memberId" value="${ loginUser.memberId }" name="memberId" readonly> <br>

                    <label for="memberName">* 이름</label> <br>
                    <input type="text" class="form-control" id="memberName" value="${ loginUser.memberName }" name="memberName" readonly> <br>

                    <label for="memberPhone"> &nbsp; *휴대폰 </label> <br>
                    <input type="text" class="form-control" id="memberPhone" value="${ loginUser.memberPhone }" name="memberPhone" required> <br>

                    <label for="memberEmail"> &nbsp; *이메일 </label> <br>
                    <input type="text" class="form-control" id="memberEmail" value="${ loginUser.memberEmail }" name="memberEmail" required>
                    <button type="button" class="button" id="emailCheck">email 인증</button>
                </div>
                <br>
                <div class="btns" align="center">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#outForm">회원탈퇴</button>
                    <button type="submit" class="btn btn-primary" onclick="return checkValidate();">수정하기</button>
                </div>
            </form>
        </div>
        <br><br>
        <div class="innerOuter">
            <form action="updatePwd.me" method="post" id="pwd-update-form">
                <br><br>
                <h2 style ="border-bottom: 3px solid #757070;">비밀번호 변경</h2>
                <br>
                <div class="form-group" style="width: 300px;">
                    <label for="memberPwd">* 현재비밀번호 : </label>
                    <input type="password" class="form-control" id="memberPwd" placeholder="현재 비밀번호 입력하세요." name="memberPwd" required>
				</div>
				<br>
				<div class="form-group" style="width: 300px;">
                    <label for="newPwd">* 새비밀번호 : </label>
                    <input type="password" class="form-control" id="newPwd" placeholder="변경할 비밀번호를 입력하세요." name="newPwd" required>
                    <div class="validate-area" id="pwd-validate"></div>
                </div>
                <br>
				<div class="form-group" style="width: 300px;">
                    <label for="checkPwd">* 새비밀번호 확인 : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="비밀번호를 다시 한번 입력하세요." required>
                    <div class="validate-area" id="check-validate"></div>
                </div>
                <br>
                <div class="btns" align="center">
                    <button type="button" class="btn btn-primary update-btn">변경하기</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 푸터바 -->
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
	var currentEmail = "${ loginUser.memberEmail }";
	var emailValidate = true;
	
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
							
							alert("이미 인증된 이메일입니다.");
							
							emailValidate = true;
							
							
							
						} else {
							
							alert("인증번호가 발송되었습니다.");
							
							authCode = data;
							
							timer();
							
							$("#email-modal").show();
							
						}
						
					},
					error : function() {
						alert("인증번호 발송에 실패했습니다.");
					}
				});
				
			};
			
		});
		
	})
	
</script>

</html>