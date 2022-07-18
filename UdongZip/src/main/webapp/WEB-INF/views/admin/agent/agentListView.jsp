<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/admin/agentListView.css">

</head>
<body>
 
	<div id="wrap">
		<jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->
			
			<!-- 회원 상세조회 모달창 -->
			<div class="modal" tabindex="-1" id="agentDetailModal">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">업체 회원</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <table class="table align-middle">
			          <tr>
			            <th class="col-5">회원 번호</th>
			            <td id="agentNo"></td>
			          </tr>
			          <tr>
			            <th>아이디</th>
			            <td id="agentId"></td>
			          </tr>
			          <tr>
			            <th>업체명</th>
			            <td id="agentName"></td>
			          </tr>
			          <tr>
			            <th>사업자 번호</th>
			            <td id="companyNo"></td>
			          </tr>
			          <tr>
			            <th>대표자명</th>
			            <td id="ceoName"></td>
			          </tr>
			          <tr>
			            <th>연락처</th>
			            <td id="agentPhone"></td>
			          </tr>
			          <tr>
			            <th>이메일</th>
			            <td id="agentEmail"></td>
			          </tr>
			          <tr>
			            <th>주소</th>
			            <td id="agentAddress"></td>
			          </tr>
			          <tr>
			            <th>가입 승인</th>
			            <td id="permission"></td>
			          </tr>
			          <tr>
			            <th>상태</th>
			            <td id="status"></td>
			          </tr>
			          <tr>
			            <th>사업자등록증</th>
			            <td><a id="document1" class="btn btn-outline-primary btn-sm">파일 확인하기</a></td>
			          </tr>
			          <tr>
			            <th>중개사등록증</th>
			            <td><a id="document2" class="btn btn-outline-primary btn-sm">파일 확인하기</a></td>
			          </tr>
			        </table>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-danger modalBtn" data-bs-dismiss="modal" id="withdrawBtn">탈퇴</button>
			        <button type="button" class="btn btn-primary modalBtn" data-bs-dismiss="modal" id="signUpBtn">가입승인</button>
			      </div>
			    </div>
			  </div>
			</div>
		
	   <div id="content-area">
		
		  <!-- 업체 회원 전체 목록 -->
		  <div id="memberListTitlebar">
		    <div class="ps-2 mb-3 mt-5" id="agentListTitle">업체 회원</div>
		    <button class="btn btn-link" id="signUpFilter" onclick="location.href='list.ag?classification=permission'">가입미승인</button>
		    <form class="input-group mb-3" id="agentFilterbar" action="list.ag" method="GET">
		      <input type="text" class="form-control" name="keyword" placeholder="아이디 / 업체명 검색">
		      <input type="hidden" name="classification" value="keyword">
		      <button class="btn btn-outline-primary" type="submit">
		        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
		          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		        </svg>
		      </button>
		    </form>
		  </div>
		  <table class="table table mb-5 text-center table-hover" id="agentListTable">
		    <thead class="border-top">
		      <tr>
		        <th class="col-1">번호</th>
		        <th class="col-2">아이디</th>
		        <th class="col-3">업체명</th>
		        <th class="col-1">대표자명</th>
		        <th class="col-2">연락처</th>
		        <th class="col-1">가입승인</th>
		        <th class="col-1">상태</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:choose>
		    		<c:when test="${ not empty list }">
		    			<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
		    				<c:choose>
		    					<c:when test="${ list[i].permission != 'Y' }">
		    						<tr data-bs-toggle="modal" data-bs-target="#agentDetailModal" class="table-warning">
		    					</c:when>
		    					<c:when test="${ list[i].status == 'N' }">
		    						<tr data-bs-toggle="modal" data-bs-target="#agentDetailModal" class="table-secondary">
		    					</c:when>
		    					<c:otherwise>
		    						<tr data-bs-toggle="modal" data-bs-target="#agentDetailModal">
		    					</c:otherwise>
		    				</c:choose>
					        <td>${ list[i].agentNo }</td>
					        <td>${ list[i].agentId }</td>
					        <td>${ list[i].agentName }</td>
					        <td>${ list[i].ceoName }</td>
					        <td>${ list[i].agentPhone }</td>
					        <td>
					        	<c:if test="${ list[i].permission == 'Y' }">
					        		완료
					        	</c:if>
					        </td>
					        <td>
					        	<c:if test="${ list[i].status == 'N' }">
					        		탈퇴
					        	</c:if>
					        </td>
					      </tr>
		    			</c:forEach>
		    		</c:when>
		    		<c:otherwise>
		    			<tr><td colspan="7">등록된 업체 회원이 없습니다.</td></tr>
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
	      			<li class="page-item"><a class="page-link" href="list.ag?cpage=${ pi.currentPage - 1 }${ classification }${ keyword }" aria-label="Previous">&laquo;</a></li>
	      		</c:otherwise>
		  	</c:choose>
		  	
		  	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	      		<c:choose>
	      			<c:when test="${ p == pi.currentPage }">
	      				<li class="page-item disabled"><a class="page-link" href="list.ag?cpage=${ p }${ classification }${ keyword }">${ p }</a></li>
	      			</c:when>
	      			<c:otherwise>
	      				<li class="page-item"><a class="page-link" href="list.ag?cpage=${ p }${ classification }${ keyword }">${ p }</a></li>
	      			</c:otherwise>
	      		</c:choose>		  	
		  	</c:forEach>
	        <c:choose>
	        	<c:when test="${ pi.currentPage eq pi.endPage }">
	        		<li class="page-item disabled"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
	        	</c:when>
	        	<c:otherwise>
	        		<li class="page-item"><a class="page-link" href="list.ag?cpage=${ pi.currentPage + 1 }${ classification }${ keyword }" aria-label="Next">&raquo;</a></li>
	        	</c:otherwise>
	        </c:choose>
		  </ul>
		  
		</div>
	
		<jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
	</div>
	
	<script>
	
		// 업체 회원 상세 조회 모달창
		$(function() {
			
			// 업체 회원 상세 조회 모달창 출력
			$("#agentListTable>tbody").on("click", "tr", function() {
				$.ajax({
					url: "select.ag",
					type: "POST",
					data: {agentNo: $(this).children().eq(0).text()},
					success: function(agent) {
						$("#agentNo").text(agent.agentNo);
						$("#agentId").text(agent.agentId);
						$("#agentName").text(agent.agentName);
						$("#companyNo").text(agent.companyNo);
						$("#ceoName").text(agent.ceoName);
						$("#agentPhone").text(agent.agentPhone);
						$("#agentEmail").text(agent.agentEmail);
						$("#agentAddress").text(agent.agentAddress);
						
						if (agent.permission == "N") {
							$("#signUpBtn").css("display", "block");
							$("#withdrawBtn").css("display", "none");
							$("#permission").text("승인 전");
							$("#status").text("승인 전");
						} else if (agent.status == "Y") {
							$("#signUpBtn").css("display", "none");
							$("#withdrawBtn").css("display", "block");
							$("#permission").text("가입 완료");
							$("#status").text("이용 중");
						} else {
							$("#signUpBtn").css("display", "none");
							$("#withdrawBtn").css("display", "none");
							$("#permission").text("가입 완료");
							$("#status").text("탈퇴");
						}
						
						$("#document1").prop("href", agent.document1);
						$("#document2").prop("href", agent.document2);
						$("#document1").prop("target", "_blank");
						$("#document2").prop("target", "_blank");
					},
					error: function() {
						console.log("업체 회원 상세 조회 ajax 실패");
					}
				})
			})
			
			// 업체 회원 가입 승인, 탈퇴 처리 메소드
			$(".modalBtn").click(function() {
				
				var agentNo = Number($("#agentNo").text());
				var form = document.createElement("form");
				var input1 = document.createElement("input");
				var input2 = document.createElement("input");
				
				form.action = "adminUpdate.ag";
				form.method = "POST";
				input1.name = "agentNo";
				input1.value = agentNo;
				input2.name = "identifier";
				
				if ($(this).attr('id') == 'signUpBtn') {
					input2.value = "signUp";
				} else {
					input2.value = "withdraw";
				}
				
				form.appendChild(input1);
				form.appendChild(input2);
				form.style.display = "none";
				document.body.appendChild(form);
				form.submit();
				
			})
		})
		
	</script>
	 
</body>
</html>