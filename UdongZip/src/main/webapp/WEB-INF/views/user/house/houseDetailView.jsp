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

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- jQuery Datepicker -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<!-- jQuery Timepicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/user/houseDetailView.css">

<!-- JS파일 -->
<script defer src="resources/js/user/houseDetailView.js"></script>

</head>
<body>

  <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

    <!-- 상담 예약 모달창 -->
    <div class="modal" tabindex="-1" id="consultBookingModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">상담 예약</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <table class="table align-middle">
              <tr>
                <th class="col-4">매물 번호</th>
                <td>${ house.houseNo }</td>
              </tr>
              <tr>
                <th>업체명</th>
                <td></td>
              </tr>
              <tr>
                <th>대표자명</th>
                <td></td>
              </tr>
              <tr>
                <th>연락처</th>
                <td></td>
              </tr>
              <tr>
                <th>주소</th>
                <td></td>
              </tr>
              <tr>
                <th>예약금</th>
                <td>30,000원</td>
              </tr>
              <tr>
                <th>상담 일시</th>
                <td>
                  <div class="dateTimePicker">
                    <input type="text" id="bookingDate" name="bookingDate" class="text-center" placeholder="날짜 선택" readonly/>
                    <span id="mouseEnterTime">
                      <input type="text" id="bookingTime" name="bookingTime" class="text-center" placeholder="시간 선택" readonly disabled="true"/>
                    </span>
                  </div>
                </td>
              </tr>
              <tr>
                <th>상담 내용</th>
                <td>
                  <textarea name="consultContent" id="consultContent" maxlength="30"></textarea>
                </td>
              </tr>
            </table>
            <div class="ps-2">
		              예약금은 상담 완료 시 환불 조치 됩니다. <br>
		              상담에 불참하실 경우 예약금은 돌려받으실 수 없습니다. <br>
		              위의 내용으로 예약하시겠습니까?
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <span id="mouseEnterBooking">
              <button type="button" class="btn btn-primary" disabled="true">예약하기</button>
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- 허위 매물 신고 모달창 -->
    <div class="modal" tabindex="-1" id="notifyModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">허위 매물 신고</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="ps-2">
             	 부당한 신고 행위는 공인중개사법 제 33조2항('시세에 부당한 영향을 줄 목적으로 중개사업무를 방해해서는 안된다')을 위배해 고소 고발의 대상이 될 수도 있으므로 주의 부탁드립니다.
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <button type="button" class="btn btn-danger">신고하기</button>
          </div>
        </div>
      </div>
    </div>

    <div id="content-area">

      <!-- 매물 사진 -->
      <div id="landDetailImg" class="carousel carousel-dark slide mt-5" data-bs-ride="true">
        <div class="carousel-indicators">
        	<c:choose>
        		<c:when test="${ not empty images }">
        			<c:forEach var="i" begin="0" end="${ images.size() - 1 }">
        				<c:choose>
	        				<c:when test="${ i eq 0 }">
	        					<button type="button" data-bs-target="#landDetailImg" data-bs-slide-to="${ i }" class="active" aria-current="true" aria-label="Slide ${ i }"></button>
	        				</c:when>
	        				<c:otherwise>
	        					<button type="button" data-bs-target="#landDetailImg" data-bs-slide-to="${ i }" aria-label="Slide ${ i }"></button>
	        				</c:otherwise>
        				</c:choose>
        			</c:forEach>
        		</c:when>
        		<c:otherwise>
        			<button type="button" data-bs-target="#landDetailImg" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        		</c:otherwise>
        	</c:choose>
        </div>
        
        <div class="carousel-inner">
        	<c:choose>
        		<c:when test="${ not empty images }">
        			<c:forEach var="i" begin="0" end="${ images.size() - 1 }">
		        		<c:choose>
		        			<c:when test="${ i eq 0 }">
		        				<div class="carousel-item active">
		        					<img src="${ images[i] }" class="d-block w-100" alt="...">
		       					</div>
		        			</c:when>
		        			<c:otherwise>
		        				<div class="carousel-item">
		        					<img src="${ images[i] }" class="d-block w-100" alt="...">
		       					</div>
		        			</c:otherwise>
		        		</c:choose>
		        	</c:forEach>
        		</c:when>
        		<c:otherwise>
        			<div class="carousel-item active">
     					<img src="resources/images/houseDetailImages/emptyImage.png" class="d-block w-100" alt="...">
   					</div>
        		</c:otherwise>
        	</c:choose> 
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#landDetailImg" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#landDetailImg" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>

      <!-- 매물 상세 박스 -->
      <div class="container rounded-4 p-4 mt-5" id="landDetailBox">
        <div class="row mb-3">
          <div class="col-3">
          	<button class="btn btn-link btn-sm" id="zzimBtn">
            	<div id="zzimImg"></div>
          	</button>
          </div>
          <div class="col pt-2 text-end"><a href="" id="notify" data-bs-toggle="modal" data-bs-target="#notifyModal">허위매물 신고하기</a></div>
        </div>
        <div class="row text-center mb-2"><div class="col" id="landId">매물번호 ${ house.houseNo }</div></div>
        <div class="row text-center mb-3"><div class="col"><a href="" id="agentId">${ house.agentName }</a></div></div>
        <div class="row text-center">
          <div class="col"><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#consultBookingModal">상담 예약</button></div>
        </div>
      </div>


      <!-- 매물 상세 정보 -->
      <table class="table table table-borderless mb-5 mt-5 landDetailTable">
        <thead>
          <tr>
            <th scope="col" colspan="2">상세 정보</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">${ house.salesType }</th>
            <td>
	            <c:choose>
	            	<c:when test="${ house.salesType eq '전세' }">
	            		${ house.deposit }
	            	</c:when>
	            	<c:otherwise>
	            		${ house.deposit } / ${ house.monthlyCost }
	            	</c:otherwise>
	            </c:choose>
            </td>
          </tr>
          <c:if test="${ not empty house.manageCost }">
          	<tr>
          		<th scope="row">관리비</th>
          		<td>${ house.manageCost }만원 (${ String.join(', ', manages) } 포함)
          		 </td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.buildingType }">
          	<tr>
          		<th scope="row">건물 종류</th>
          		<td>${ house.buildingType }</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.roomType }">
          	<tr>
          		<th scope="row">방 종류</th>
          		<td>
          			<c:choose>
          				<c:when test="${ house.roomType == 1 }">
          					오픈형
          				</c:when>
          				<c:when test="${ house.roomType == 2 }">
          					분리형
          				</c:when>
          				<c:otherwise>
          					복층형
          				</c:otherwise>
          			</c:choose>
          		</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty options }">
          	<tr>
          		<th scope="row">옵션</th>
          		<td>${ String.join(', ', options) }</td>
          	</tr>
          </c:if>
          <c:if test="${ house.roomCount ne 0 }">
          	<tr>
          		<th scope="row">방 수</th>
          		<td>${ house.roomCount }</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.buildingFloor }">
          	<tr>
          		<th scope="row">해당층/건물층</th>
          		<td>
          			<c:choose>
          				<c:when test="${ house.floor eq '반지하' }">
	          				반지하
	          			</c:when>
          				<c:otherwise>
          					${ house.floor }층
          				</c:otherwise>
          			</c:choose>
          		 	/ ${ house.buildingFloor }
          		 </td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.size_m2 }">
          	<tr>
          		<th scope="row">공급면적</th>
          		<td><span>${ house.size_m2 } m²</span>
          			<button class="btn btn-outline-primary btn-sm"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-repeat" viewBox="0 0 16 16">
  							<path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
  							<path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3zM3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9H3.1z"/>
					</svg> <span>평</span></button>
				</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.direction }">
          	<tr>
          		<th scope="row">방향</th>
          		<td>
          			<c:if test="${ house.direction == 'S' }">
          				남향
          			</c:if>
          			<c:if test="${ house.direction == 'SW' }">
          				남서향
          			</c:if>
          			<c:if test="${ house.direction == 'W' }">
          				서향
          			</c:if>
          			<c:if test="${ house.direction == 'NW' }">
          				북서향
          			</c:if>
          			<c:if test="${ house.direction == 'E' }">
          				동향
          			</c:if>
          			<c:if test="${ house.direction == 'SE' }">
          				남동향
          			</c:if>
          			<c:if test="${ house.direction == 'N' }">
          				북향
          			</c:if>
          			<c:if test="${ house.direction == 'NE' }">
          				북동향
          			</c:if>
          		</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.parking }">
          	<tr>
          		<th scope="row">주차</th>
          		<td>${ house.parking }</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.pet }">
          	<tr>
          		<th scope="row">애완동물</th>
          		<td>${ house.pet }</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.loan }">
          	<tr>
          		<th scope="row">대출</th>
          		<td>${ house.loan }</td>
          	</tr>
          </c:if>
        </tbody>
      </table>

      <!-- 위치 및 편의시설 -->
      <table class="table table table-borderless mb-5 landDetailTable">
        <thead>
          <tr>
            <th scope="col">위치 및 편의 시설</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>${ house.address1 } ${ house.address2 }</td>
          </tr>
          <tr>
            <td><div class="container-fluid rounded-4 bg-light" id="landDetailMap">지도자리</div></td>
          </tr>
          <tr>
            <td>
              <input type="radio" class="btn-check" name="btnradio" id="pinBank" autocomplete="off">
              <label class="btn btn-outline-light rounded-circle" for="pinBank"><img src="resources/images/houseDetailImages/pin-bank.png" alt=""></label>
            
              <input type="radio" class="btn-check" name="btnradio" id="pinHospital" autocomplete="off">
              <label class="btn btn-outline-light rounded-circle" for="pinHospital"><img src="resources/images/houseDetailImages/pin-hospital.png" alt=""></label>
            
              <input type="radio" class="btn-check" name="btnradio" id="pinStore" autocomplete="off">
              <label class="btn btn-outline-light rounded-circle" for="pinStore"><img src="resources/images/houseDetailImages/pin-store.png" alt=""></label>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 상세 설명 -->
      <table class="table table table-borderless mb-5 landDetailTable">
        <thead>
          <tr>
            <th scope="col">상세 설명</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <div class="p-3 bg-light rounded-4" id="">
              	${ house.description }
              </div>
            </td>
          </tr>
        </tbody>
      </table>

    </div>
    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
  </div>
  
  
  <script>
  // 찜 기능 관련
  $(function() {
	  
	  // 매물 찜 조회
	  if (${ loginUser != null }) { // 로그인한 상태
		  $.ajax({
			  url: "select.zz",
			  data: {
				  memberNo: ${ loginUser.memberNo },
				  houseNo: ${ house.houseNo }
			  },
			  type: "POST",
			  success: function(result) {
				  if (result == ${ house.houseNo }) { // 찜한 경우
					  console.log("찜했더래요.");
				  	  $("#zzimImg").attr("class", "isZzim");
				  } else { // 찜하지 않은 경우
					  console.log("찜 안했더래요.");
					  $("#zzimImg").attr("class", "notZzim");
				  }
			  },
			  error: function() {
				  console.log("찜 조회 ajax 통신 실패");
			  }
		  })
	  } else { // 로그인하지 않은 상태
		  console.log("로그인 안했더래요.");
		  $("#zzimImg").attr("class", "notZzim");
	  }
	  
	  
	  
	  $("#zzimBtn").click(function() {
		  console.log("클릭 했더래요.");
		// 찜이 되어있는 경우 - 찜 삭제
		  if ($("#zzimImg").attr("class") == "isZzim") {
			  console.log("찜이더래요.");
			  $.ajax({
				  url: "delete.zz",
				  data: {
					  memberNo: ${ loginUser.memberNo },
					  houseNo: ${ house.houseNo }
				  },
				  type: "POST",
				  success: function(result) {
					  console.log("삭제성공이더래요.");
					  console.log(result);
					  /* if (result <= 0) {
						  alert("찜 삭제에 실패했습니다. 다시 시도해주세요.");
						  return false;
					  } else {
						  $("#zzimImg").attr("class", "notZzim");
					  } */
				  },
				  error: function() {
					  console.log("찜 삭제 ajax 통신 실패");
				  }
			  })
		  
		  // 찜이 되어있지 않은 경우 - 찜 추가
		  } else {
			  console.log("찜아니더래요.");
			  $.ajax({
				  url: "insert.zz",
				  data: {
					  memberNo: ${ loginUser.memberNo },
					  houseNo: ${ house.houseNo }
				  },
				  type: "POST",
				  success: function(result) {
					  console.log("추가성공이더래요.");
					  console.log(result);
					  /* if (result <= 0) {
						  alert("찜 하기에 실패했습니다. 다시 시도해주세요.");
						  return false;
					  } else {
						  $("#zzimImg").attr("class", "isZzim");
					  } */
				  },
				  error: function() {
					  console.log("찜 추가 ajax 통신 실패");
				  }
			  })
		  }
	  })
	  
  })
  
  
  
  </script>
  
</body>
</html>