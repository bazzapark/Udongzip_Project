<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/user/agentDetailView.css">

<!-- 카카오 지도 API -->
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=084a0d93b202ede69ef974d4cc624440&libraries=services"></script>

</head>
<body>

  <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

    <div id="content-area">

      <!-- 업체 정보 -->
      <table class="table table table-borderless mb-5 agentDetailTable">
        <thead>
          <tr>
            <th scope="col">업체 정보</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">업체명</th>
            <td>${ agent.agentName }</td>
            <td rowspan="10" class="col-6"><div class="container-fluid rounded-4 bg-light" id="landDetailMap"></div></td>
          </tr>
          <tr>
            <th scope="row">대표자명</th>
            <td>${ agent.ceoName }</td>
          </tr>
          <tr>
            <th scope="row">연락처</th>
            <td>${ agent.agentPhone }</td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>${ agent.agentEmail }</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>${ agent.agentAddress }</td>
          </tr>
          <tr>
            <td scope="row"></td>
            <td><button type="button" class="btn btn-primary" id="chatQA">채팅 문의</button>
            <input type="hidden" name="agentIdch" id="agentIdch" value="${ agent.agentNo }" />
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 업체 설명 -->
      <table class="table table table-borderless mb-5 mt-5 agentDetailTable">
        <thead>
          <tr>
            <th scope="col">상세 설명</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <div class="p-3 bg-light rounded-4" name="" id="">${ agent.introduce }</div>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 상담 후기 -->
      <div class="listTitle ps-2 mb-3">상담 후기</div>
      <table class="table table mb-3 text-center" id="reviewTable">
        <thead class="border-top">
          <tr>
            <th class="col-1">번호</th>
            <th class="col-2">아이디</th>
            <th class="col-5">내용</th>
            <th class="col-2">만족도</th>
            <th class="col-2">작성일</th>
          </tr>
        </thead>
        <tbody>
        	<c:choose>
        		<c:when test="${ not empty reviewList }">
        			<c:forEach var="r" begin="0" end="${ reviewList.length() }">
        				<tr>
        					<td>${ r.reviewNo }</td>
        					<td>${ r.memberId }</td>
        					<td>${ r.content }</td>
        					<td>
        						<c:choose>
        							<c:when test="${ r.satisfied == 'Y' }">
        								<img src='resources/images/houseDetailImages/like.png' alt=''>
        							</c:when>
        							<c:otherwise>
        								<img src='resources/images/houseDetailImages/dislike.png' alt=''>
        							</c:otherwise>
        						</c:choose>
        					</td>
        					<td>${ r.createDate }</td>
        				</tr>
        			</c:forEach>
        		</c:when>
        		<c:otherwise>
        			<tr><td colspan="5">작성된 리뷰가 없습니다.</td></tr>
        		</c:otherwise>
        	</c:choose>
        </tbody>
      </table>
      
      <ul class="pagination pagination-sm mb-5 justify-content-center">
      
      	<c:choose>
      		<c:when test="${ pi.currentPage eq 1 }">
      			<li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous">&laquo;</a></li>
      		</c:when>
      		<c:otherwise>
      			<li class="page-item"><a class="page-link" href="agList.rv?cpage=${ pi.currentPage - 1 }" aria-label="Previous">&laquo;</a></li>
      		</c:otherwise>
      	</c:choose>
      	
      	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
      		<c:choose>
      			<c:when test="${ p == pi.currentPage }">
      				<li class="page-item disabled"><a class="page-link" href="agList.rv?cpage=${ p }">${ p }</a></li>
      			</c:when>
      			<c:otherwise>
      				<li class="page-item"><a class="page-link" href="agList.rv?cpage=${ p }">${ p }</a></li>
      			</c:otherwise>
      		</c:choose>
      		
      	</c:forEach>
        
        <c:choose>
        	<c:when test="${ pi.currentPage eq pi.endPage }">
        		<li class="page-item disabled"><a class="page-link" href="#" aria-label="Next">&raquo;</a></li>
        	</c:when>
        	<c:otherwise>
        		<li class="page-item"><a class="page-link" href="agList.rv?cpage=${ pi.currentPage + 1 }" aria-label="Next">&raquo;</a></li>
        	</c:otherwise>
        </c:choose>
        
      </ul>

      <!-- 다른 매물 -->
      <div class="listTitle ps-2 mb-3">이 업체의 다른 매물</div>
      <div id="landImgList" class="carousel carousel-dark slide mb-5" data-bs-ride="carousel">
        <div class="carousel-inner">
        	<c:choose>
        		<c:when test="${ not empty houseList }">
        			<c:forEach  var="i" begin="0" end="${ 5 }">
        				<c:choose>
        					<c:when test="${ i eq 0 }">
        						<div class="carousel-item active" data-bs-interval="2000">
						            <img src="${ houseList[i].thumbnail }" class="d-block" alt="..." role="button">
						            <span style="display: none;">${ houseList[i].houseNo }</span>
						            <div class="carousel-caption d-none d-md-block" role="button">
						              <h5>${ houseList[i].address1 }</h5>
						            </div>
					          	</div>
        					</c:when>
        					<c:otherwise>
        						<div class="carousel-item" data-bs-interval="2000" role="button">
						            <img src="${ houseList[i].thumbnail }" class="d-block" alt="..." role="button">
						            <span style="display: none;">${ houseList[i].houseNo }</span>
						            <div class="carousel-caption d-none d-md-block">
						              <h5>${ houseList[i].address1 }</h5>
						            </div>
					          	</div>
        					</c:otherwise>
        				</c:choose>
        			</c:forEach>
        		</c:when>
        		<c:otherwise>
        			<div class="carousel-item active">
			            <img src="resources/images/houseDetailImages/emptyImage.png" class="d-block" alt="...">
			            <div class="carousel-caption d-none d-md-block disabled">
			              <h5>매물 없음</h5>
			            </div>
		          	</div>
        		</c:otherwise>
        	</c:choose>
         </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#landImgList" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#landImgList" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
      
    </div>

    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
  </div>
  
  <script>
  
	// 카카오 지도 API
	$(function() {
		
		if (${ lat == "" and lng == "" }) {
			
			$("#landDetailMap").css({
				"background-image": "url('resources/images/houseDetailImages/emptyImage.png')",
				"background-size": "contain"
			});
			
		} else {
			// 지도 생성
			var mapContainer = document.getElementById('landDetailMap'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(${ lat }, ${ lng }), // 지도의 중심좌표
			        level: 5 // 지도의 확대 레벨
			    };  
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 매물 위치
			var agentPin = 'resources/images/houseDetailImages/pin-agent.png', // 마커이미지의 주소입니다    
		    pinSize = new kakao.maps.Size(50, 50), // 마커이미지의 크기입니다
		    pinOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		  	var pinImg = new kakao.maps.MarkerImage(agentPin, pinSize, pinOption),
		  	    pinPosition = new kakao.maps.LatLng(${ lat }, ${ lng }); // 마커가 표시될 위치입니다
		  	var pin = new kakao.maps.Marker({
		  	    position: pinPosition, 
		  	    image: pinImg // 마커이미지 설정 
		  	});
		  	pin.setMap(map);  
		}
	})
	
	$(function() {
		$("#landImgList>.carousel-inner").on("click", ".carousel-item>img", function() {
			location.href = "detail.ho?hno=" + Number($(this).next().text());
		})

  		 $("#chatQA").on("click", function(){
  			 location.href="newch.ch?agentNo=" + Number($("#agentIdch").val()); 			 
  		 });
  	 });
  </script>
  
</body>
</html>