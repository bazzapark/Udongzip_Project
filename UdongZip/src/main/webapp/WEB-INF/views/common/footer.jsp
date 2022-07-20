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
	
	<!------- 푸터바 시작 ------->
	<footer class="text-center">
	  <div class="container pt-4">
	    <section class="mb-4 footerText">
	      <a id="companyInfo" role="button">회사소개</a> | 
	      <a id="jobInfo" role="button">채용정보</a> | 
	      <a id="termsOfService" role="button">이용약관</a> | 
	      <a id="privacyPolicy" role="button"><b>개인정보처리방침</b></a> | 
	      <a id="houseManagement" role="button">매물관리규정</a>
	    </section>
	  </div>
	
	  <!-- Copyright -->
	  <div class="copyright text-center text-dark p-3">
	    <span>Copyright © UDONGZIP. All Rights Reserved.</span>
	  </div>
	</footer>
	<!------- 푸터바 끝 ------->

</body>

<script>
	$(function() {
		
		$("#jobInfo").click(function() {
			alert("진행중인 채용 공고가 없습니다.");
		});
		
		$("#termsOfService").click(function() {
			window.open("termsofService.ud", "_blank");
		});
		
		$("#privacyPolicy").click(function() {
			window.open("privacy.ud", "_blank");
		});
		
		$("#houseManagement").click(function() {
			window.open("management.ud", "_blank");
		});
		
	})
</script>
</html>