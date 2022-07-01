<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS 파일 -->
<link rel="stylesheet" type="text/css" href="resources/css/common/common.css">

</head>
<body>
	<img alt="" id="backgroundImg">
	<div id="wrap">
		<jsp:include page="header.jsp" />
		<div id="content-area">

			<div id="mainTitle">우리 동네의 집들을 모아서 보세요.</div>
	    <table class="table align-middle table-hover table-sm mb-5" id="mainTable">
	      <thead>
	        <tr>
	          <th scope="col">공지사항</th>
	          <th scope="col" id="mainTableMore"><a href="">더보기
	            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
	              <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
	            </svg></a>
	          </th>
	        </tr>
	      </thead>
	      <tbody class="table-group-divider">
	        <tr>
	          <td>[공지] 공지사항제목</td>
	          <td class="text-center">2022-06-25</td>
	        </tr>
	        <tr>
	          <td>[공지] 공지사항제목</td>
	          <td class="text-center">2022-06-25</td>
	        </tr>
	        <tr>
	          <td>[공지] 공지사항제목</td>
	          <td class="text-center">2022-06-25</td>
	        </tr>
	        <tr>
	          <td>[공지] 공지사항제목</td>
	          <td class="text-center">2022-06-25</td>
	        </tr>
	        <tr>
	          <td>[공지] 공지사항제목</td>
	          <td class="text-center">2022-06-25</td>
	        </tr>
	      </tbody>
	    </table>

		</div>
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>