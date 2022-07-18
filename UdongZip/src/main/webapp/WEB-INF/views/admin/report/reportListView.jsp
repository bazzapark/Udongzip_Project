<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/admin/reportListView.css">

</head>
<body>
	
	<div id="wrap">
	  <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->
	
	  <!-- 허위 매물 신고 상세조회 모달창 -->
	  <div class="modal" tabindex="-1" id="reportDetailModal">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title">허위 매물 신고 정보</h5>
	          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <div class="modal-body">
	          <table class="table align-middle">
	            <tr>
	              <th class="col-5">매물번호</th>
	              <td id="houseNo"></td>
	            </tr>
	            <tr>
	              <th>업체명</th>
	              <td id="agentName"></td>
	            </tr>
	            <tr>
	              <th>주소</th>
	              <td id="address"></td>
	            </tr>
	            <tr>
	              <th>계약 유형</th>
	              <td id="salesType">전세</td>
	            </tr>
	            <tr>
	              <th>방 유형</th>
	              <td id="roomType"></td>
	            </tr>
	            <tr>
	              <th>신고 횟수</th>
	              <td id="reportCount"></td>
	            </tr>
	            <tr>
	              <th>상태</th>
	              <td id="status"></td>
	            </tr>
	            <tr>
	              <th>자세히 보기</th>
	              <td><button type="button" class="btn btn-outline-primary btn-sm" id="detailBtn">상세페이지로 이동</button></td>
	            </tr>
	          </table>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	          <button type="button" class="btn btn-danger modalBtn" id="deleteBtn">삭제</button>
	        </div>
	      </div>
	    </div>
	  </div>
	
	  <div id="content-area">
	
	    <!-- 허위 매물 신고 전체 목록 -->
	    <div id="reportListTitlebar">
	      <div class="ps-2 mb-3 mt-5" id="reportListTitle">허위 매물 신고</div>
	      <button class="btn btn-link" onclick="location.href='list.rp?classification=count'">5회 이상</button>
	      <form class="input-group mb-3" id="reportFilterbar" action="list.rp" method="GET">
	          <input type="text" class="form-control" name="keyword" placeholder="업체명 검색">
	          <input type="hidden" name="classification" value="keyword">
	          <button class="btn btn-outline-primary" type="submit">
	            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
	            </svg>
	          </button>
	        </form>
	    </div>
	    <table class="table table mb-5 text-center table-hover" id="reportList">
	      <thead class="border-top">
	        <tr>
	          <th class="col-1">매물번호</th>
	          <th class="col-2">업체명</th>
	          <th class="col-3">주소1</th>
	          <th class="col-1">계약유형</th>
	          <th class="col-1">방유형</th>
	          <th class="col-1">신고횟수</th>
	          <th class="col-1">상태</th>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:choose>
	    		<c:when test="${ not empty list }">
	    			<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
	    				<c:choose>
	    					<c:when test="${ list[i].status == 'N' }">
	    						<tr data-bs-toggle="modal" data-bs-target="#reportDetailModal" class="table-secondary">
	    					</c:when>
	    					<c:otherwise>
	    						<tr data-bs-toggle="modal" data-bs-target="#reportDetailModal">
	    					</c:otherwise>
	    				</c:choose>
				        <td>${ list[i].houseNo }</td>
				        <td>${ list[i].agentName }</td>
				        <td>${ list[i].address1 }</td>
				        <td>${ list[i].salesType }</td>
				        <td>${ list[i].roomType }</td>
				        <td>${ list[i].reportCount }</td>
				        <td>
				        	<c:if test="${ list[i].status == 'N' }">
				        		삭제
				        	</c:if>
				        </td>
				      </tr>
	    			</c:forEach>
	    		</c:when>
	    		<c:otherwise>
	    			<tr><td colspan="7">등록된 허위 매물 신고가 없습니다.</td></tr>
	    		</c:otherwise>
	    	</c:choose>
	      </tbody>
	    </table>
	    
   		  <ul class="pagination mb-5 justify-content-center">
		  	<c:choose>
	      		<c:when test="${ pi.currentPage eq 1 }">
	      			<li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous">&laquo;</a></li>
	      		</c:when>
	      		<c:otherwise>
	      			<li class="page-item"><a class="page-link" href="list.rv?cpage=${ pi.currentPage - 1 }${ classification }${ keyword }" aria-label="Previous">&laquo;</a></li>
	      		</c:otherwise>
		  	</c:choose>
		  	
		  	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	      		<c:choose>
	      			<c:when test="${ p == pi.currentPage }">
	      				<li class="page-item disabled"><a class="page-link" href="list.rv?cpage=${ p }${ classification }${ keyword }">${ p }</a></li>
	      			</c:when>
	      			<c:otherwise>
	      				<li class="page-item"><a class="page-link" href="list.rv?cpage=${ p }${ classification }${ keyword }">${ p }</a></li>
	      			</c:otherwise>
	      		</c:choose>		  	
		  	</c:forEach>
	        <c:choose>
	        	<c:when test="${ pi.currentPage eq pi.endPage }">
	        		<li class="page-item disabled"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
	        	</c:when>
	        	<c:otherwise>
	        		<li class="page-item"><a class="page-link" href="list.rv?cpage=${ pi.currentPage + 1 }${ classification }${ keyword }" aria-label="Next">&raquo;</a></li>
	        	</c:otherwise>
	        </c:choose>
		  </ul>

	  </div>
	
	  <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
	</div>
	
	  	<script>
	
		// 매물 신고 상세 조회 모달창
		$(function() {
			
			// 매물 신고 상세 조회 모달창 출력
			$("#reportList>tbody").on("click", "tr", function() {
				$.ajax({
					url: "select.rp",
					type: "POST",
					data: {houseNo: $(this).children().eq(0).text()},
					success: function(report) {
						$("#houseNo").text(report.houseNo);
						$("#agentName").text(report.agentName);
						$("#address").text(report.address1 + " " + report.address2);
						$("#roomType").text(report.roomType);
						$("#salesType").text(report.salesType);
						$("#reportCount").text(report.reportCount);
						if (report.status == "N") {
							$("#status").text("삭제 완료");
							$("#deleteBtn").css("display", "none");
						} else {
							$("#status").text("게시 중");
							$("#deleteBtn").css("display", "block");
						}
					},
					error: function() {
						console.log("매물 신고 상세 조회 ajax 실패");
					}
				})
			})
			
			// 허위 매물 삭제 메소드
			$("#deleteBtn").click(function() {
				
				var houseNo = Number($("#houseNo").text());
				var form = document.createElement("form");
				var input = document.createElement("input");
				
				form.action = "adminUpdate.rp";
				form.method = "POST";
				input.name = "houseNo";
				input.value = houseNo;
				
				form.appendChild(input);
				form.style.display = "none";
				document.body.appendChild(form);
				form.submit();
			})
			
			// 상세 페이지로 이동
			$("#detailBtn").click(function() {
				location.href = "detail.ho?hno=" + $("#houseNo").text();
			})
		})
		
	</script>

</body>
</html>