<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="resources/css/user/agentUpdateForm.css">
<!-- js -->
<script type="text/javascript" src="resources/js/user/agentUpdateForm.js"></script>
</head>
<body>

    <div id="wrap">
    
    	<jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">내 업체 정보 관리</h1>
            <br>

            <form id="agent-update-form" action="update.ag" method="post">
            	 <div class="info-text info-area">
                 	<p>
                    	* 업체명, 사업자번호, 대표자명, 관련 서류를 변경하려면 고객센터로 문의하시길 바랍니다. <br>
                        * 변경되는 정보에 따라 증빙 서류를 다시 요청할 수 있습니다. <br>
                        * 이메일은 인증 후 변경 가능합니다.
                	</p>
                </div>
				
				<input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
                <table class="info-table">
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="text" class="form-control short-input no-edit" id="agentId" name="agentId" value="${ loginUser.agentId }" readonly>
								<label for="agentId">아이디</label>
							</div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="text" class="form-control short-input no-edit" id="agentName" name="agentName" name="agentId" value="${ loginUser.agentName }" readonly>
								<label for="agentName">업체명</label>
							</div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="email" class="form-control short-input" id="agentEmail" name="agentEmail" value="${ loginUser.agentEmail }">
								<label for="agentEmail">이메일</label>
							</div>
                        </td>
                        <td>
                        	&nbsp;<button type="button" class="button" id="emailCheck">email 인증</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="text" class="form-control short-input" id="agentPhone" name="agentPhone" pattern="[0-9]+" maxlength="11" value="${ loginUser.agentPhone }" required>
								<label for="agentphone">연락처</label>
							</div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-floating">
								<input type="text" class="form-control" id="agentAddress" name="agentAddress" value="${ loginUser.agentAddress }" required>
								<label for="agentAddress">주소</label>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        	<div class="form-floating">
                                <textarea name="introduce" id="introduce"  class="form-control" required>${ loginUser.introduce }</textarea>
                                <label for="introduce">소개</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        	<div class="form-floating">
                                <input type="text" id="companyNo" name="companyNo" class="form-control short-input no-edit" value="${ loginUser.companyNo }" readonly style="width:200px;">
                                <label for="companyNo">사업자 번호</label>
                            </div>
                        </td>
                        <td>
                        	<div class="form-floating">
                                <input type="text" id="ceoName" name="ceoName" class="form-control short-input no-edit" value="${ loginUser.ceoName }" readonly style="width:200px;">
                                <label for="ceoName">대표자명</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                    	<td colspan="2">제출 서류 (사업자등록증, 중개사등록증)</td>
                    </tr>
                    <tr>
                        <td>
                            <img id="img1" class="previewer" src="${ loginUser.document1 }"/>
                        </td>
                        <td>
                            <img id="img2" class="previewer" src="${ loginUser.document2 }"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br><br>
                            <button type="submit" class="button update-btn" onclick="return checkValidate();">수정하기</button>
                        </td>
                    </tr>
                </table>

                <div class="delete-btn text">탈퇴하기</div>

                <br>
            </form>

            <br>
            
            <form id="pwd-update-form" action="updatePwd.ag" method="post">
				
				<input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
                <table class="info-table">
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="password" class="form-control short-input" id="agentPwd" name="agentPwd">
								<label for="agentPwd">현재 비밀번호</label>
							</div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="password" class="form-control short-input" id="newPwd" name="newPwd">
								<label for="newPwd">변경할 비밀번호</label>
							</div>
							<div class="validate-area" id="pwd-validate"></div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="password" class="form-control short-input" id="checkPwd">
								<label for="checkPwd">변경할 비밀번호 확인</label>
							</div>
							<div class="validate-area" id="check-validate"></div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br><br>
                            <button type="button" class="button update-btn">변경하기</button>
                        </td>
                    </tr>
                </table>
                <br>
            </form>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />
        
             <div class="modal" id="delete-modal">
                    <div class="modal-body">
        
                        <h3>회원 탈퇴</h3>
                        <hr>
        				<form action="delete.ag" method="post" id="delete-form">
        					<input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
	                        <table class="modal-table" align="center">
	                            <tr>
	                                <td>
	                                	<div class="info-text">
	                                		탈퇴 후에는 복구할 수 없습니다.<br>
	                                		아래 입력란에 비밀번호 입력 후 '탈퇴'를 누르세요.
	                                		<br><br>
	                                	</div>
	                                <td>
	                            </tr>
	                            <tr>
	                            	<td>
			                            <div class="form-floating">
			                                <input type="password" id="agentPwd2" name="agentPwd" class="form-control" required>
			                                <label for="agentPwd">비밀번호</label>
		                            	</div>
		                            </td>
	                            </tr>
	                        </table>
	                        <br>
	        				<button type="submit" class="button delete-confirm">탈퇴</button>
	                        <button type="button" class="button close-btn">닫기</button>
                        </form>
                    </div>
                </div>
                
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

    </div>

</body>

<script>

	var authCode;
	var currentEmail = "${ loginUser.agentEmail }";
	var emailValidate = true;
	
	$(function() {
			
		$("#emailCheck").on("click", function() {
			
			if($("#agentEmail").val().length == 0) {
				
				alert("이메일을 입력하세요.");
				
			} else {
				
				$.ajax({
					url : "emailCheck.ag",
					data : { email : $("#agentEmail").val() },
					type : "post",
					success : function(data) {
						
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
		
		$(".delete-btn").click(function() {
			$("#delete-modal").css("display", "block");
		});

        $("#delete-modal .close-btn").click(function() {
        	$("#delete-modal").css("display", "none");
        });
		
	})
	
</script>
</html>