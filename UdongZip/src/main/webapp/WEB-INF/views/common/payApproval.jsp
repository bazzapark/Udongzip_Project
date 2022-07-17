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

<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/common/common.css">

</head>
<body>

  

  <div id=wrap>
		<jsp:include page="header.jsp" />
    <div id="content-area">
      
      <!------- 결제 요청 페이지 시작 ------->
      <div class="error">
        <img id="errorImg" src="resources/images/pay.png" alt="">
        <div id="errorTitle">결제 요청 중</div>
        <div id="errorMsg">결제를 요청 중입니다.</div>
      </div>
      <!------- 결제 요청 페이지 끝 ------->

    </div>
		<jsp:include page="footer.jsp" />
  </div>
  
  <script>
  $(function() {
	  console.log("pg_token : ${ pg_token }");
  })
  
  </script>

</body>
</html>