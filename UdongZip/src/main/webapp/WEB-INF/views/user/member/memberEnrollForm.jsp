<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집</title>
  
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
          <label for="">아이디</label>
          <div id="" class="form-text">5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</div>
        </div>
        <div class="form-floating mb-1">
          <input type="password" class="form-control" id="memberPwd" placeholder="비밀번호" name="memberPwd">
          <label for="">비밀번호</label>
          <div id="" class="form-text"></div>
        </div>
        <div class="form-floating mb-3">
          <input type="password" class="form-control" id="checkPwd" placeholder="비밀번호 재확인">
          <label for="">비밀번호 재확인</label>
          <div id="" class="form-text">비밀번호 재확인 유효성 검사 결과 입력칸</div>
        </div>
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberName" placeholder="이름" name="memberName">
          <label for="">이름</label>
        </div>
        <div class="form-floating mb-2">
          <input type="text" class="form-control" id="memberPhone" placeholder="연락처" name="memberPhone">
          <label for="">휴대전화</label>
        </div>
        <div class="form-floating mb-5">
          <input type="email" class="form-control" id="memberEmail" placeholder="이메일" name="memberEmail">
          <label for="">이메일</label>
        </div>

        <button type="submit" class="btn btn-primary">가입하기</button>
      <!-- btn btn-primary disabled -->
      </form>
      <!------- 개인회원가입폼 끝 ------->

    </div>
  </section>
 
  <jsp:include page="../../common/footer.jsp" />
 
</body>
</html>