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
                        <td colspan="2">
                            <div class="input-group">
                                <input type="text" id="agentId" name="agentId" class="input short-input" required>
                                <label for="agentId" class="input-label">아이디</label> &nbsp;
                                <button type="button" class="button" id="idCheck">아이디 중복 확인</button>
                            </div>
                            <div class="validate-area" id="id-validate"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="password" id="agentPwd" name="agentPwd" class="input short-input" required>
                                <label for="agentPwd" class="input-label">비밀번호</label>
                            </div>
                            <div class="validate-area" id="pwd-validate"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="password" id="checkPwd" class="input short-input" required>
                                <label for="checkPwd" class="input-label">비밀번호 확인</label>
                            </div>
                            <div class="validate-area" id="check-validate"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="text" id="agentName" name="agentName" class="input short-input" required>
                                <label for="agentName" class="input-label">업체명</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="email" id="agentEmail" name="agentEmail" class="input short-input" required>
                                <label for="agentEmail" class="input-label">이메일</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="text" id="agentPhone" name="agentPhone" class="input short-input" required>
                                <label for="agentphone" class="input-label">연락처</label>
                            </div>
                            <div class="validate-area">숫자만 입력하세요.</div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="text" id="agentAddress" name="agentAddress" class="input long-input" required>
                                <label for="agentAddress" class="input-label">주소</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <textarea name="introduce" id="introduce"  class="input" required></textarea>
                                <label for="introduce" class="input-label">소개</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input-group">
                                <input type="text" id="companyNo" name="companyNo" class="input short-input" pattern="[0-9]+" required>
                                <label for="companyNo" class="input-label">사업자 번호</label>
                            </div>
                            <div class="validate-area">숫자만 입력하세요.</div>
                        </td>
                        <td>
                            <div class="input-group">
                                <input type="text" id="ceoName" name="ceoName" class="input short-input" required>
                                <label for="ceoName" class="input-label">대표자명</label>
                            </div>
                            <div class="validate-area">사업자등록증과 일치해야 합니다.</div>
                        </td>
                    </tr>
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
                    		<button type="submit" class="enroll-btn button">가입하기</button>
                    	</td>
                    </tr>
                </table>
				
            </form>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />

    </div>

</body>
</html>