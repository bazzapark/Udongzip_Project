<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/user/agentEnrollForm.css">
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- js -->
<script type="text/javascript" src="resources/js/user/agentEnrollForm.js"></script>
</head>
<body>

<div id="wrap">
		
		<jsp:include page="../../common/header.jsp" />
		
        <div id="content-area">

            <h1 align="center">중개사무소 회원가입</h1>
            <br>

            <form id="agent-enroll-form" action="insert.ag" method="post" enctype="multipart/form-data">

                <table class="info-table">
                    <tr>
                        <td>
                            <div class="form-floating">
								<input type="text" class="form-control short-input" id="agentId" name="agentId" required>
								<label for="agentId">아이디</label>
							</div>
                        </td>
                        <td>
                        	<button type="button" class="button" id="idCheck">중복 확인</button>
                        </td>
                    </tr>
                    <tr>
                    	<td colspan="2">
                    		<div class="validate-area" id="id-validate"></div>
                    	</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="password" id="agentPwd" name="agentPwd" class="form-control short-input" required>
                                <label for="agentPwd">비밀번호</label>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td>
                    		<div class="validate-area" id="pwd-validate"></div>
                    	</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="password" id="checkPwd" class="form-control short-input" required>
                                <label for="checkPwd">비밀번호 확인</label>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td>
                    		<div class="validate-area" id="check-validate"></div>
                    	</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="text" id="agentName" name="agentName" class="form-control short-input" required>
                                <label for="agentName">업체명</label>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="email" id="agentEmail" name="agentEmail" class="form-control short-input" required>
                                <label for="agentEmail">email</label>
                            </div>
                        </td>
                        <td>
                        	<button type="button" class="button" id="emailCheck">email 인증</button>
                        </td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="text" id="agentPhone" name="agentPhone" class="form-control short-input" required>
                                <label for="agentphone">연락처</label>
                            </div>
                            <div class="validate-area">숫자만 입력하세요.</div>
                        </td>
                        <td></td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-floating">
                                <input type="text" id="agentAddress" name="agentAddress" class="form-control long-input" required>
                                <label for="agentAddress">주소</label>
                            </div>
                        </td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-floating">
                                <textarea name="introduce" id="introduce"  class="form-control" required></textarea>
                                <label for="introduce">소개</label>
                            </div>
                        </td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <td>
                            <div class="form-floating">
                                <input type="text" id="companyNo" name="companyNo" class="form-control short-input" pattern="[0-9]+" maxlength="10" required style="width:200px;">
                                <label for="companyNo" class="input-label">사업자 번호</label>
                            </div>
                            <div class="validate-area">숫자만 입력하세요.</div>
                        </td>
                        <td>
                            <div class="form-floating">
                                <input type="text" id="ceoName" name="ceoName" class="form-control short-input" required style="width:200px;">
                                <label for="ceoName" class="input-label">대표자명</label>
                            </div>
                            <div class="validate-area">사업자등록증과 일치해야 합니다.</div>
                        </td>
                    </tr>
                    <tr></tr>
                    <tr>
                    	<td colspan="2"> 관련 서류 (사업자등록증, 중개사등록증)</td>
                    </tr>
                    <tr>
                        <td>
                            <img id="img1" class="previewer"/>
                            <input type="file" name="document" class="file-input" required>
                        </td>
                        <td>
                            <img id="img2" class="previewer"/>
                            <input type="file" name="document" class="file-input" required>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <span class="info-text">* 영역 클릭 시 이미지 등록 가능, 다시 클릭 시 삭제</span>
                        </td>
                    </tr>
                    <tr>
                    	<td colspan="2" align="center">
                    		<br><br>
                    		<button type="submit" onclick="return checkValidate();" class="enroll-btn button">가입하기</button>
                    	</td>
                    </tr>
                </table>
				
            </form>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />

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

</body>

<script>

	var authCode;

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