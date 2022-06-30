<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<link rel="stylesheet" href="resources/css/user/agentEnrollForm.css">
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
                                <label for="agentId" class="input-label">아이디</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="password" id="agentPwd" name="agentPwd" class="input short-input" required>
                                <label for="agentPwd" class="input-label">비밀번호</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="input-group">
                                <input type="password" id="checkPwd" class="input short-input" required>
                                <label for="checkPwd" class="input-label">비밀번호 확인</label>
                            </div>
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
                                <input type="text" id="companyNo" name="companyNo" class="input short-input" required>
                                <label for="companyNo" class="input-label">사업자 번호</label>
                            </div>
                        </td>
                        <td>
                            <div class="input-group">
                                <input type="text" id="ceoName" name="ceoName" class="input short-input" required>
                                <label for="ceoName" class="input-label">대표자명</label>
                            </div>
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
                </table>
				<button type="submit" class="enroll-btn button">가입하기</button>
            </form>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />

    </div>

    <script>

        // 유효성 검사 : 사용자가 입력한 값들이 유효한 값의 형태인지 검사
        function validate() {

            // 아이디, 비밀번호, 비밀번호 일치, 이름
            // input 요소 값들 뽑아오기
            var $agentId = $("#agentId").val();
            var $agentPwd = $("#agentPwd").val();
            var $checkPwd = $("#checkPwd").val();

            // 1) 아이디 검사
            // 영문자(소문자), 숫자로만 4~18글자로
            // 단, 반드시 첫글자는 반드시 영문자
            var regExp = /^[a-z][a-z\d]{3,17}$/;

            if(!regExp.test($agentId)) {

                alert("유효하지 않은 형식의 아이디입니다.");
                $("#agentId").select();
                return false;
            }

            // 2) 비밀번호 검사
            // 영문자(대소문자), 숫자, 특수문자(!@#$%^)로만 8~20글자로
            regExp = /^[a-z0-9!@#$%^]{8,20}$/i;

            if(!regExp.test($agentPwd)) {

                alert("유효하지 않은 형식의 비밀번호입니다.");
                $("#agentPwd").val("");
                $("#agentPwd").focus();
                return false;
            }
            
            // 3) 비밀번호 일치
            if($agentPwd != $checkPwd) {

                alert("비밀번호가 일치하지 않습니다.");
                $("#checkPwd").val("");
                $("#checkPwd").focus();
                return false;
            }

            return true;
        }

        $(function() {

            $("img").on("click", function() {

                if($(this).attr("src") == undefined | $(this).attr("src") == "") {

                    onClickUpload(this);

                } else {

                    $(this).attr("src", "");

                }

            });

            $(".file-input").on("change", function() { // file-input의 값이 바뀌면

                var imgEl = $(this).siblings("img"); // 해당 input의 형제 중 img 태그를 가져와서

                setPreview(this, imgEl); // 프리뷰 등록 함수에 같이 전달

            });

        });

        function onClickUpload(btn) { // 서류등록 버튼 누르면

            $(btn).siblings("input").click(); // file-inpur 버튼이 눌리도록

        };


        // 프리뷰 등록 함수
        function setPreview(input, el) { // 파일이 등록된 input 요소와 미리보기가 보여질 요소 전달 받음

            if (input.files && input.files[0]) { // 파일이 있으면

                var reader = new FileReader(); // 파일 리더 객체 생성

                reader.onload = function (e) { // 로딩이 완료되면

                $(el).attr("src", e.target.result);
                // 아래 reader로 읽어들인 DataURL을
                // 등록된 이미지 파일 미리보기 요소의 src 속성값으로 설정

                };

                reader.readAsDataURL(input.files[0]); // 등록된 이미지 파일을 DataURL 형식으로 읽음

            }

        };

    </script>

</body>
</html>