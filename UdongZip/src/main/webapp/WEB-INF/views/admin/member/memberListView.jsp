<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/admin/memberListView.css">

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
 
	<div id="wrap">
	  <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->
	
	  <!-- 회원 상세조회 모달창 -->
	  <div class="modal" tabindex="-1" id="memberDetailModal">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title">일반 회원</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <div class="modal-body">
	          <table class="table align-middle">
	            <tr>
	              <th class="col-5">회원 번호</th>
	              <td>1</td>
	            </tr>
	            <tr>
	              <th>아이디</th>
	              <td>user01</td>
	            </tr>
	            <tr>
	              <th>이름</th>
	              <td>일유저</td>
	            </tr>
	            <tr>
	              <th>연락처</th>
	              <td>010-0010-0002</td>
	            </tr>
	            <tr>
	              <th>이메일</th>
	              <td>user01@udong.com</td>
	            </tr>
	            <tr>
	              <th>상태</th>
	              <td>이용중</td>
	            </tr>
	          </table>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	          <button type="button" class="btn btn-danger">탈퇴</button>
	
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div id="content-area">
	
	    <!-- 일반 회원 전체 목록 -->
	    <div id="memberListTitlebar">
	      <div class="ps-2 mb-3 mt-5" id="memberListTitle">일반 회원</div>
	      <div class="input-group mb-3" id="memberFilterbar">
	        <input type="text" class="form-control" placeholder="아이디 / 이름 검색">
	        <button class="btn btn-outline-primary" type="button" id="button-addon2">
	          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
	          </svg>
	        </button>
	      </div>
	    </div>
	    <table class="table table mb-5 text-center table-hover" id="memberListTable">
	      <thead class="border-top">
	        <tr>
	          <th class="col-1">번호</th>
	          <th class="col-2">아이디</th>
	          <th class="col-2">이름</th>
	          <th class="col-2">연락처</th>
	          <th class="col-4">이메일</th>
	          <th class="col-2">상태</th>
	        </tr>
	      </thead>
	      <tbody>
	        <tr data-bs-toggle="modal" data-bs-target="#memberDetailModal">
	          <td>1</td>
	          <td>user01</td>
	          <td>일유저</td>
	          <td>010-0001-0001</td>
	          <td>user01@udong.com</td>
	          <td>이용중</td>
	        </tr>
	        <tr data-bs-toggle="modal" data-bs-target="#memberDetailModal">
	          <td>1</td>
	          <td>user01</td>
	          <td>일유저</td>
	          <td>010-0001-0001</td>
	          <td>user01@udong.com</td>
	          <td>이용중</td>
	        </tr>
	        <tr data-bs-toggle="modal" data-bs-target="#memberDetailModal" class="table-secondary">
	          <td>1</td>
	          <td>user01</td>
	          <td>일유저</td>
	          <td>010-0001-0001</td>
	          <td>user01@udong.com</td>
	          <td>탈퇴</td>
	        </tr>
	        <tr data-bs-toggle="modal" data-bs-target="#memberDetailModal">
	          <td>1</td>
	          <td>user01</td>
	          <td>일유저</td>
	          <td>010-0001-0001</td>
	          <td>user01@udong.com</td>
	          <td>이용중</td>
	        </tr>
	        <tr data-bs-toggle="modal" data-bs-target="#memberDetailModal">
	          <td>1</td>
	          <td>user01</td>
	          <td>일유저</td>
	          <td>010-0001-0001</td>
	          <td>user01@udong.com</td>
	          <td>이용중</td>
	        </tr>
	      </tbody>
	    </table>
	    <ul class="pagination mb-5 justify-content-center">
	      <li class="page-item">
	        <a class="page-link" href="#" aria-label="Previous">
	          <span aria-hidden="true">&laquo;</span>
	        </a>
	      </li>
	      <li class="page-item"><a class="page-link" href="#">1</a></li>
	      <li class="page-item"><a class="page-link" href="#">2</a></li>
	      <li class="page-item"><a class="page-link" href="#">3</a></li>
	      <li class="page-item">
	        <a class="page-link" href="#" aria-label="Next">
	          <span aria-hidden="true">&raquo;</span>
	        </a>
	      </li>
	    </ul>
	
	  </div>
	
	  <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
	</div>
  
</body>
</html>