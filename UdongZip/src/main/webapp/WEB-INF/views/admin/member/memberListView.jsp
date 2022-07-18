<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/admin/memberListView.css">

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
                <td id="memberNo"></td>
              </tr>
              <tr>
                <th>아이디</th>
                <td id="memberId"></td>
              </tr>
              <tr>
                <th>이름</th>
                <td id="memberName"></td>
              </tr>
              <tr>
                <th>연락처</th>
                <td id="memberPhone"></td>
              </tr>
              <tr>
                <th>이메일</th>
                <td id="memberEmail"></td>
              </tr>
              <tr>
                <th>상태</th>
                <td id="status"></td>
              </tr>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary modalBtn" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-danger modalBtn" id="withdrawBtn">탈퇴</button>

          </div>
        </div>
      </div>
    </div>

    <div id="content-area">

      <!-- 일반 회원 전체 목록 -->
      <div id="memberListTitlebar">
        <div class="ps-2 mb-3 mt-5" id="memberListTitle">일반 회원</div>
        <form class="input-group mb-3" id="memberFilterbar" action="list.me" method="GET">
          <input type="text" class="form-control" name="keyword" placeholder="아이디 / 이름 검색">
          <button class="btn btn-outline-primary" type="submit" id="button-addon2">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
          </button>
        </form>
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
	    	<c:choose>
	    		<c:when test="${ not empty list }">
	    			<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
	    				<c:choose>
	    					<c:when test="${ list[i].status != 'Y' }">
	    						<tr data-bs-toggle="modal" data-bs-target="#memberDetailModal" class="table-secondary">
	    					</c:when>
	    					<c:otherwise>
	    						<tr data-bs-toggle="modal" data-bs-target="#memberDetailModal">
	    					</c:otherwise>
	    				</c:choose>
				        <td>${ list[i].memberNo }</td>
				        <td>${ list[i].memberId }</td>
				        <td>${ list[i].memberName }</td>
				        <td>${ list[i].memberPhone }</td>
				        <td>${ list[i].memberEmail }</td>
				        <td>
				        	<c:if test="${ list[i].status == 'N' }">
				        		탈퇴
				        	</c:if>
				        </td>
				      </tr>
	    			</c:forEach>
	    		</c:when>
	    		<c:otherwise>
	    			<tr><td colspan="6">등록된 개인 회원이 없습니다.</td></tr>
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
	      			<li class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage - 1 }${ keyword }" aria-label="Previous">&laquo;</a></li>
	      		</c:otherwise>
		  	</c:choose>
		  	
		  	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	      		<c:choose>
	      			<c:when test="${ p == pi.currentPage }">
	      				<li class="page-item disabled"><a class="page-link" href="list.me?cpage=${ p }${ keyword }">${ p }</a></li>
	      			</c:when>
	      			<c:otherwise>
	      				<li class="page-item"><a class="page-link" href="list.me?cpage=${ p }${ keyword }">${ p }</a></li>
	      			</c:otherwise>
	      		</c:choose>		  	
		  	</c:forEach>
	        <c:choose>
	        	<c:when test="${ pi.currentPage eq pi.endPage }">
	        		<li class="page-item disabled"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
	        	</c:when>
	        	<c:otherwise>
	        		<li class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage + 1 }${ keyword }" aria-label="Next">&raquo;</a></li>
	        	</c:otherwise>
	        </c:choose>
		  </ul>

    </div>

    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
  </div>
  
  	<script>
	
		// 개인 회원 상세 조회 모달창
		$(function() {
			
			// 개인 회원 상세 조회 모달창 출력
			$("#memberListTable>tbody").on("click", "tr", function() {
				$.ajax({
					url: "select.me",
					type: "POST",
					data: {memberNo: $(this).children().eq(0).text()},
					success: function(member) {
						$("#memberNo").text(member.memberNo);
						$("#memberId").text(member.memberId);
						$("#memberName").text(member.memberName);
						$("#memberPhone").text(member.memberPhone);
						$("#memberEmail").text(member.memberEmail);
						if (member.status == "Y") {
							$("#withdrawBtn").css("display", "block");
							$("#status").text("이용 중");
						} else {
							$("#withdrawBtn").css("display", "none");
							$("#status").text("탈퇴");
						}
						
					},
					error: function() {
						console.log("개인 회원 상세 조회 ajax 실패");
					}
				})
			})
			
			// 개인 회원 탈퇴 처리 메소드
			$("#withdrawBtn").click(function() {
				
				var memberNo = Number($("#memberNo").text());
				var form = document.createElement("form");
				var input1 = document.createElement("input");
				
				form.action = "adminDelete.me";
				form.method = "POST";
				input1.name = "memberNo";
				input1.value = memberNo;
				
				form.appendChild(input1);
				form.style.display = "none";
				document.body.appendChild(form);
				form.submit();
			})
		})
		
	</script>

</body>
</html>