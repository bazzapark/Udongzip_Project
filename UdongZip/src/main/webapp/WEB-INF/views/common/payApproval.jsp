<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

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
	  kakaopay();
  })
  
  
  function kakaopay() {
	  
	  var form = document.createElement("form");
	  form.action = "kakaopay.rs";
	  form.method = "";
	  form.style.display = "none";
	  document.body.appendChild(form);
	  form.submit();
  }
  
  
  
  </script>
</body>
</html>