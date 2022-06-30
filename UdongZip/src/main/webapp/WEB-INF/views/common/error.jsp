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
      
      <!------- 에러 페이지 시작 ------->
      <div class="error">
        <img id="errorImg" src="resources/images/error.png" alt="">
        <div id="errorTitle">서비스 요청 실패</div>
        <div id="errorMsg">${ errorMsg }</div>
        <button type="button" class="btn btn-outline-primary">메인으로 돌아가기</button>
      </div>
      <!------- 에러 페이지 끝 ------->

    </div>
		<jsp:include page="footer.jsp" />
  </div>
</body>
</html>