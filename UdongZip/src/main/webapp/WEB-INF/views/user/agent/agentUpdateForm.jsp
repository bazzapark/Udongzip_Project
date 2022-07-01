<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<link rel="stylesheet" href="resources/css/user/agentUpdateForm.css">
</head>
<body>

    <div id="wrap">
    
    	<jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">내 업체 정보 관리</h1>
            <br>

            <form id="agent-update-form" action="update.ag" method="post">
				
				<input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
                <table class="info-table">
                    <tr>
                        <td colspan="2">
                        	<div class="input-group">
                                <input type="text" id="agentId" name="agentId" class="input short-input no-edit" value="${ loginUser.agentId }" readonly>
                                <label for="agentId" class="input-label">아이디</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        	<div class="input-group">
                                <input type="text" id="agentName" name="agentName" class="input short-input no-edit" value="${ loginUser.agentName }" readonly>
                                <label for="agentName" class="input-label">업체명</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="email" id="agentEmail" name="agentEmail" class="input short-input" value="${ loginUser.agentEmail }" required>
                                <label for="agentEmail" class="input-label">이메일</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="text" id="agentPhone" name="agentPhone" class="input short-input" pattern="[0-9]+" minlength="11" maxlength="11" value="${ loginUser.agentPhone }" required>
                                <label for="agentphone" class="input-label">연락처</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        	<div class="input-group">
                                <input type="text" id="agentAddress" name="agentAddress" class="input long-input" value="${ loginUser.agentAddress }" required>
                                <label for="agentAddress" class="input-label">주소</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        	<div class="input-group">
                                <textarea name="introduce" id="introduce"  class="input" required>${ loginUser.introduce }</textarea>
                                <label for="introduce" class="input-label">소개</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        	<div class="input-group">
                                <input type="text" id="companyNo" name="companyNo" class="input short-input no-edit" value="${ loginUser.companyNo }" readonly>
                                <label for="companyNo" class="input-label">사업자 번호</label>
                            </div>
                        </td>
                        <td>
                        	<div class="input-group">
                                <input type="text" id="ceoName" name="ceoName" class="input short-input no-edit" value="${ loginUser.ceoName }" readonly>
                                <label for="ceoName" class="input-label">대표자명</label>
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
                        <td colspan="2">
                            <span class="info-text">
                            	* 업체명, 사업자번호, 대표자명을 변경하려면 고객센터로 문의하시길 바랍니다. <br>
                            	* 변경되는 정보에 따라 증빙 서류를 다시 요청할 수 있습니다. <br>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br><br>
                            <button type="submit" class="button update-btn">수정하기</button>
                        </td>
                    </tr>
                </table>

                <div class="delete-btn text">탈퇴하기</div>

                <br>
            </form>

            <br>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />
        
             <div class="modal">
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
			                            <div class="input-group">
			                                <input type="password" id="agentPwd" name="agentPwd" class="input short-input" required>
			                                <label for="agentPwd" class="input-label">비밀번호</label>
		                            	</div>
		                            </td>
	                            </tr>
	                        </table>
	        				<button type="submit" class="button delete-confirm">탈퇴</button>
	                        <button type="button" class="button close-btn">닫기</button>
                        </form>
                    </div>
                </div>

    </div>

</body>

<script>
	
	$(function() {
		
		$(".delete-btn").click(function() {
			$(".modal").css("display", "block");
		});

        $(".close-btn").click(function() {
        	$(".modal").css("display", "none");
        });
		
	})
	
</script>
</html>