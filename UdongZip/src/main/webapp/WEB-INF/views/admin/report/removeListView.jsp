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

    <!-- 리뷰 삭제 요청 상세조회 모달창 -->
    <div class="modal" tabindex="-1" id="removeDetailModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">리뷰 삭제 요청 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <table class="table align-middle">
              <tr>
                <th class="col-5">요청 번호</th>
                <td id="requestNo">1</td>
              </tr>
              <tr>
                <th>업체명</th>
                <td id="agentName"></td>
              </tr>
              <tr>
                <th>리뷰 번호</th>
                <td id="reviewNo"></td>
              </tr>
              <tr>
                <th>작성자</th>
                <td id="memberId"></td>
              </tr>
              <tr>
                <th>만족도</th>
                <td id="satisfied"></td>
              </tr>
              <tr>
                <th>리뷰 작성일</th>
                <td id="createDate"></td>
              </tr>
              <tr>
                <th>삭제 요청일</th>
                <td id="requestDate"></td>
              </tr>
              <tr>
                <th>요청 사유</th>
                <td><textarea name="removeContent" id="reason" maxlength="30" readonly></textarea></td>
              </tr>
              <tr>
                <th>상태</th>
                <td id="result">삭제 / 반려 / 대기</td>
              </tr>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-warning modalBtn" id="rejectBtn">반려</button>
            <button type="button" class="btn btn-danger modalBtn" id="deleteBtn">삭제</button>

          </div>
        </div>
      </div>
    </div>

    <div id="content-area">

      <!-- 리뷰 삭제 요청 전체 목록 -->
      <div id="removeListTitlebar">
        <div class="ps-2 mb-3 mt-5" id="removeListTitle">리뷰 삭제 요청</div>
        <button class="btn btn-link" id="removeFilter" onclick="location.href='list.rv?classification=result'">삭제전</button>
        <form class="input-group mb-3" id="removeFilterbar" action="list.rv" method="GET">
          <input type="text" class="form-control" name="keyword" placeholder="업체명 검색">
          <input type="hidden" name="classification" value="keyword">
          <button class="btn btn-outline-primary" type="submit">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
          </button>
        </form>
      </div>
      <table class="table table mb-5 text-center table-hover" id="removeList">
        <thead class="border-top">
          <tr>
            <th class="col-1">번호</th>
            <th class="col-3">업체명</th>
            <th class="col-2">리뷰번호</th>
            <th class="col-2">작성자</th>
            <th class="col-1">만족도</th>
            <th class="col-2">삭제요청일</th>
            <th class="col-1">상태</th>
          </tr>
        </thead>
        <tbody>
        	<c:choose>
	    		<c:when test="${ not empty list }">
	    			<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
	    				<c:choose>
	    					<c:when test="${ list[i].result == 'D' }">
	    						<tr data-bs-toggle="modal" data-bs-target="#removeDetailModal" class="table-warning">
	    					</c:when>
	    					<c:otherwise>
	    						<tr data-bs-toggle="modal" data-bs-target="#removeDetailModal">
	    					</c:otherwise>
	    				</c:choose>
				        <td>${ list[i].requestNo }</td>
				        <td>${ list[i].agentName }</td>
				        <td>${ list[i].reviewNo }</td>
				        <td>${ list[i].memberId }</td>
				        <td>
				        	<c:choose>
				        		<c:when test="${ list[i].satisfied == 'Y' }">
				        			<img src="resources/images/houseDetailImages/like.png" alt="">
				        		</c:when>
				        		<c:otherwise>
				        			<img src="resources/images/houseDetailImages/dislike.png" alt="">
				        		</c:otherwise>
				        	</c:choose>
				        </td>
				        <td>${ list[i].requestDate.substring(0, 10) }</td>
				        <td>
				        	<c:choose>
				        		<c:when test="${ list[i].result == 'Y' }">
				        			삭제
				        		</c:when>
				        		<c:when test="${ list[i].result == 'N' }">
				        			반려	
				        		</c:when>
				        		<c:when test="${ list[i].result == 'D' }">
				        			대기
				        		</c:when>
				        	</c:choose>
				        </td>
				      </tr>
	    			</c:forEach>
	    		</c:when>
	    		<c:otherwise>
	    			<tr><td colspan="7">등록된 리뷰 삭제 요청이 없습니다.</td></tr>
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
	
		// 삭제 요청 상세 조회 모달창
		$(function() {
			
			// 삭제 요청 상세 조회 모달창 출력
			$("#removeList>tbody").on("click", "tr", function() {
				$.ajax({
					url: "select.rv",
					type: "POST",
					data: {requestNo: $(this).children().eq(0).text()},
					success: function(request) {
						$("#requestNo").text(request.requestNo);
						$("#agentName").text(request.agentName);
						$("#reviewNo").text(request.reviewNo);
						$("#memberId").text(request.memberId);
						if (request.satisfied == "Y") {
							$("#satisfied").text("만족");
						} else {
							$("#satisfied").text("불만족");
						}
						$("#createDate").text(request.createDate.substring(0, 10));
						$("#requestDate").text(request.requestDate.substring(0, 10));
						$("#reason").val(request.reason);
						if (request.result == "Y") {
							$("#rejectBtn").css("display", "none");
							$("#deleteBtn").css("display", "none");
							$("#result").text("삭제 완료");
						} else if (request.result == "N") {
							$("#rejectBtn").css("display", "none");
							$("#deleteBtn").css("display", "none");
							$("#result").text("반려");
						} else {
							$("#rejectBtn").css("display", "block");
							$("#deleteBtn").css("display", "block");
							$("#result").text("대기");
						}
					},
					error: function() {
						console.log("삭제 요청 상세 조회 ajax 실패");
					}
				})
			})
			
			// 삭제 요청 삭제, 반려 처리 메소드
			$(".modalBtn").click(function() {
				
				var requestNo = Number($("#requestNo").text());
				var reviewNo = Number($("#reviewNo").text());
				var form = document.createElement("form");
				var input1 = document.createElement("input");
				var input2 = document.createElement("input");
				var input3 = document.createElement("input");
				
				form.action = "adminUpdate.rv";
				form.method = "POST";
				input1.name = "requestNo";
				input1.value = requestNo;
				input2.name = "reviewNo";
				input2.value = reviewNo;
				input3.name = "result";
				
				if ($(this).attr('id') == 'deleteBtn') {
					input3.value = "delete";
				} else {
					input3.value = "reject";
				}
				
				form.appendChild(input1);
				form.appendChild(input2);
				form.appendChild(input3);
				form.style.display = "none";
				document.body.appendChild(form);
				form.submit();
			})
		})
		
	</script>
  
</body>
</html>