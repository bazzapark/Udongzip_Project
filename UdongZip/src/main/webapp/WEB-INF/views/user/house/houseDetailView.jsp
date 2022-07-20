<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/user/houseDetailView.css">

<!-- 카카오 지도 API -->
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a8b77d874cdf7d0680055d6b64f7eb45&libraries=services"></script>

</head>
<body>

  <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->
	<!-- jQuery Datepicker -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
	
	<!-- jQuery Timepicker -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
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
                <td id="houseNo">${ house.houseNo }</td>
              </tr>
              <tr>
                <th>업체명</th>
                <td id="agentName">${ house.agentName }</td>
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
                <th>주소</th>
                <td id="agentAddress"></td>
              </tr>
              <tr>
                <th>예약금</th>
                <td>20,000원</td>
              </tr>
              <tr>
                <th>상담 일시</th>
                <td>
                  <div class="dateTimePicker">
                    <input type="text" id="bookingDate" name="reservationDate" class="text-center" placeholder="날짜 선택" readonly/>
                    <span id="mouseEnterTime">
                      <input type="text" id="bookingTime" name="reservationTime" class="text-center" placeholder="시간 선택" readonly disabled="true"/>
                    </span>
                  </div>
                </td>
              </tr>
              <tr>
                <th>상담 내용</th>
                <td>
                  <textarea name="consultContent" id="content" maxlength="100" name="content"></textarea>
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
              <button type="button" class="btn btn-primary" disabled="true" id="reservationBtn">예약하기</button>
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
            <button type="button" class="btn btn-danger" id="notifyBtn" data-bs-dismiss="modal">신고하기</button>
          </div>
        </div>
      </div>
    </div>

    <div id="content-area">

      <!-- 매물 사진 -->
      <div id="landDetailImg" class="carousel carousel-dark slide mt-5" data-bs-ride="carousel">
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
		        				<div class="carousel-item active" data-bs-interval="3000">
		        					<img src="${ images[i] }" class="d-block w-100" alt="...">
		       					</div>
		        			</c:when>
		        			<c:otherwise>
		        				<div class="carousel-item" data-bs-interval="3000">
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
            	<div id="zzimImg" class="notZzim"></div>
          	</button>
          </div>
          <div class="col pt-2 text-end"><a href="" id="notify" data-bs-toggle="" data-bs-target="#notifyModal">허위매물 신고하기</a></div>
        </div>
        <div class="row text-center mb-2"><div class="col" id="landId">매물번호 ${ house.houseNo }</div></div>
        <div class="row text-center mb-3"><div class="col"><a href="detail.ag?ano=${ house.agentNo }" id="agentId">${ house.agentName }</a></div></div>
        <div class="row text-center">
          <div class="col"><button class="btn btn-primary" data-bs-toggle="" id="reservation" data-bs-target="#consultBookingModal">상담 예약</button></div>
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
            		<c:when test="${ Integer.toString(house.deposit).length() >= 5 }">
            			<c:choose>
            				<c:when test="${ house.salesType eq '전세' }">
            					${ Integer.toString(house.deposit).substring(0, Integer.toString(house.deposit).length() - 4) }억
            					${ Integer.toString(house.deposit).substring(Integer.toString(house.deposit).length() - 4) }
            				</c:when>
            				<c:otherwise>
            					${ house.deposit } / ${ house.monthlyCost }
            				</c:otherwise>
            			</c:choose>
            		</c:when>
            		<c:otherwise>
            			<c:choose>
            				<c:when test="${ house.salesType eq '전세' }">
            					${ house.deposit }
            				</c:when>
            				<c:otherwise>
            					${ house.deposit } / ${ house.monthlyCost }
            				</c:otherwise>
            			</c:choose>
            		</c:otherwise>
            	</c:choose>
            </td>
          </tr>
          <c:if test="${ not empty house.manageCost }">
          	<tr>
          		<th scope="row">관리비</th> 
          		<td>${ house.manageCost }만원
          			<c:if test="${ not empty manages }">
          				(${ String.join(', ', manages) } 포함)
          			</c:if>
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
          		<td>${ house.roomType }</td>
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
          		<td>${ house.roomCount }개</td>
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
          		 	/ ${ house.buildingFloor }층
          		 </td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.size_m2 }">
          	<tr>
          		<th scope="row">공급면적</th>
          		<td>
	          		<span id="size" class="m2">${ house.size_m2 } m²</span>
	          		<button id="sizeChange" class="btn btn-outline-primary btn-sm"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-repeat" viewBox="0 0 16 16">
					<path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
					<path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3zM3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9H3.1z"/>
					</svg><span id="change">평</span></button>
				</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.direction }">
          	<tr>
          		<th scope="row">방향</th>
          		<td>${ house.direction }</td>
          	</tr>
          </c:if>
          <c:if test="${ not empty house.parking }">
          	<tr>
          		<th scope="row">주차</th>
          		<td>
          			<c:choose>
          				<c:when test="${ house.parking eq 0 }">
          					불가
          				</c:when>
          				<c:otherwise>
          					${ house.parking }대 가능
          				</c:otherwise>
          			</c:choose>
          		</td>
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
            <td>
            	${ house.address1 }
            	<c:if test="${ house.address2 != 'none'}">
            		 ${ house.address2 }
            	</c:if>
           </td>
          </tr>
          <tr>
            <td><div class="rounded-4 bg-light row justify-content-start" id="landDetailMap" style="width: 70%;"></div></td>
          </tr>
          <tr>
           <td id="category" class="justify-content-center" style="width: 70%;">
               <figure id="MT1" src="resources/images/houseDetailImages/pin-shopping.png">
               	<img src="resources/images/houseDetailImages/pin-shopping.png" alt="" >
			    <figcaption>마트</figcaption>
			   </figure>
			   <figure id="CS2" src="resources/images/houseDetailImages/pin-convenience.png">
               	<img src="resources/images/houseDetailImages/pin-convenience.png" alt="" >
			    <figcaption>편의점</figcaption>
			   </figure>
			   <figure id="BK9" src="resources/images/houseDetailImages/pin-bank.png">
               	<img src="resources/images/houseDetailImages/pin-bank.png" alt="" >
			    <figcaption>은행</figcaption>
			   </figure>
			   <figure id="FD6" src="resources/images/houseDetailImages/pin-restaurant.png">
               	<img src="resources/images/houseDetailImages/pin-restaurant.png" alt="" >
			    <figcaption>음식점</figcaption>
			   </figure>
			   <figure id="CE7" src="resources/images/houseDetailImages/pin-cafe.png">
               	<img src="resources/images/houseDetailImages/pin-cafe.png" alt="" >
			    <figcaption>카페</figcaption>
			   </figure>
			   <figure id="HP8" src="resources/images/houseDetailImages/pin-hospital.png">
               	<img src="resources/images/houseDetailImages/pin-hospital.png" alt="" >
			    <figcaption>병원</figcaption>
			   </figure>
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
              <div class="p-3 bg-light rounded-4" id="" style="width: 70%;">
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
  
  	// 카카오 지도 API
  	$(function() {
  		
  		// 카테고리 변수 생성
  		var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), // 편의 시설 카테고리 클릭 시 엘리먼트
  		    markers = [], // 마커를 담을 배열입니다
  		    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
  		 
  		// 지도 생성
  		var mapContainer = document.getElementById('landDetailMap'), // 지도를 표시할 div 
  		    mapOption = {
  		        center: new kakao.maps.LatLng(${ house.lat }, ${ house.lng }), // 지도의 중심좌표
  		        level: 5 // 지도의 확대 레벨
  		    };  
  		var map = new kakao.maps.Map(mapContainer, mapOption); 
  		
  		// 매물 위치
  		var housePin = 'resources/images/houseDetailImages/pin-home.png', // 마커이미지의 주소입니다    
  	    pinSize = new kakao.maps.Size(50, 50), // 마커이미지의 크기입니다
  	    pinOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	  	var pinImg = new kakao.maps.MarkerImage(housePin, pinSize, pinOption),
	  	    pinPosition = new kakao.maps.LatLng(${ house.lat }, ${ house.lng }); // 마커가 표시될 위치입니다
	  	var pin = new kakao.maps.Marker({
	  	    position: pinPosition, 
	  	    image: pinImg // 마커이미지 설정 
	  	});
	  	pin.setMap(map);  
  		
  		
  		// 장소 검색 객체를 생성합니다
  		var ps = new kakao.maps.services.Places(map); 

  		// 각 카테고리에 클릭 이벤트를 등록합니다
  		addCategoryClickEvent();

  		// 카테고리 검색을 요청하는 함수입니다
  		function searchPlaces() {
  		    if (!currCategory) {
  		        return;
  		    }
  		    
  		    // 지도에 표시되고 있는 마커를 제거합니다
  		    removeMarker();
  		    
  		    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
  		}

  		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
  		function placesSearchCB(data, status, pagination) {
  		    if (status === kakao.maps.services.Status.OK) {

  		        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
  		        displayPlaces(data);
  		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
  		        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

  		    } else if (status === kakao.maps.services.Status.ERROR) {
  		        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
  		        
  		    }
  		}

  		// 지도에 마커를 표출하는 함수입니다
  		function displayPlaces(places) {

  		    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
  		    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
  		    var imgUrl = document.getElementById(currCategory).getAttribute('src');

  		    for ( var i = 0; i < places.length; i++ ) {

  		            // 마커를 생성하고 지도에 표시합니다
  		            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), imgUrl);

  		            // 마커와 검색결과 항목을 클릭 했을 때
  		            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
  		            (function(marker, place) {
  		                kakao.maps.event.addListener(marker, 'click', function() {
  		                    displayPlaceInfo(place);
  		                });
  		            })(marker, places[i]);
  		    }
  		}

  		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
  		function addMarker(position, imgUrl) {
  		    var imageSrc = imgUrl, // 마커 이미지 url, 스프라이트 이미지를 씁니다
  		        imageSize = new kakao.maps.Size(40, 40),  // 마커 이미지의 크기
  		        imgOption = { offset: new kakao.maps.Point(11, 28) },
  		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOption),
  		            marker = new kakao.maps.Marker({
  		            position: position, // 마커의 위치
  		            image: markerImage 
  		        });

  		    marker.setMap(map); // 지도 위에 마커를 표출합니다
  		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

  		    return marker;
  		}

  		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
  		function removeMarker() {
  		    for ( var i = 0; i < markers.length; i++ ) {
  		        markers[i].setMap(null);
  		    }   
  		    markers = [];
  		}

  		// 각 카테고리에 클릭 이벤트를 등록합니다
  		function addCategoryClickEvent() {
  		    var category = document.getElementById('category'),
  		        children = category.children;

  		    for (var i=0; i<children.length; i++) {
  		        children[i].onclick = onClickCategory;
  		    }
  		}

  		// 카테고리를 클릭했을 때 호출되는 함수입니다
  		function onClickCategory() {
  		    var id = this.id,
  		        className = this.className;

  		    placeOverlay.setMap(null);

  		    if (className === 'on') {
  		        currCategory = '';
  		        changeCategoryClass();
  		        removeMarker();
  		    } else {
  		        currCategory = id;
  		        changeCategoryClass(this);
  		        searchPlaces();
  		    }
  		}

  		// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
  		function changeCategoryClass(el) {
  		    var category = document.getElementById('category'),
  		        children = category.children,
  		        i;

  		    for ( i=0; i<children.length; i++ ) {
  		        children[i].className = '';
  		    }

  		    if (el) {
  		        el.className = 'on';
  		    } 
  		} 
  		
  	})
  
	// 상담 예약 기능
	$(function() {
		
		// 상담 예약 모달창 버튼 활성화
		$("#reservation").mouseenter(function() {
			if (${ not empty loginUser and loginUser.identifier eq 'member' }) {
				$(this).attr("data-bs-toggle", "modal");
			} else {
				$(this).attr("data-bs-toggle", "");
			}
		})
		
		// 상담 예약 모달창 버튼 클릭
		$("#reservation").click(function() {
			
			// 로그인 상태
			if (${ not empty loginUser and loginUser.identifier == 'member' }) {
				$.ajax({
					url: "select.ag",
					data: {
						agentNo: ${ house.agentNo }
					},
					type: "POST",
					success: function(agent) {
						$("#ceoName").text(agent.ceoName);
						$("#agentPhone").text(agent.agentPhone);
						$("#agentAddress").text(agent.agentAddress);
					},
					error: function() {
						console.log("상담 예약 모달창 정보 조회 ajax 실패");
					}
				})
				
			// 로그아웃 상태
			} else {
				alert("개인 회원 로그인 후 사용 가능한 서비스입니다. ");
				return false;
			}
		})
		
		// 상담 예약 모달창 예약 버튼 클릭
 		$("#reservationBtn").click(function() {
			
			var form = document.createElement("form");
			var input1 = document.createElement("input");
			var input2 = document.createElement("input");
			var input3 = document.createElement("input");
			var input4 = document.createElement("input");
			var input5 = document.createElement("input");
			var input6 = document.createElement("input");
			var input7 = document.createElement("input");
			var input8 = document.createElement("input");
			var input9 = document.createElement("input");
			
			form.action = "insert.rs";
			form.method = "POST";
			input1.name = "partner_order_id"; // 가맹점 주문번호
			if (${ not empty loginUser }) {
				input1.value = $("#houseNo").text() + ${ house.agentNo } + ${ loginUser.memberNo } + Date.now()
			}
			input2.name = "partner_user_id"; // 가맹점 회원 ID (문의 업체)
			input2.value = $("#agentName").text();
			
			input3.name = "classification";
			input3.value = "ready";
			
			input4.name = "memberNo";
			input4.value = Number(${ loginUser.memberNo });
			input5.name = "agentNo";
			input5.value = Number(${ house.agentNo });
			input6.name = "houseNo";
			input6.value = Number($("#houseNo").text());
			input7.name = "reservationDate";
			input7.value = $("#bookingDate").val();			
			input8.name = "reservationTime";
			input8.value = $("#bookingTime").val();
			input9.name = "content";
			input9.value = $("#content").val();
			
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);
			form.appendChild(input6);
			form.appendChild(input7);
			form.appendChild(input8);
			form.appendChild(input9);
			form.style.display = "none";
			document.body.appendChild(form);
			form.submit();
		})
	  
	  // 날짜, 시간 변수 셋팅
	  // 현재 시간이 오후 6시 이상이면 minDate를 내일 날짜로 설정
	  let minDate = (new Date().getHours() >= 18) ? new Date(new Date().setDate(new Date().getDate() + 1)) : new Date();
	  
	  // 현재 날짜를 #bookingDate의 string 형식으로 설정
	  let today = new Date().getFullYear() + "-"
	  	  today += ((new Date().getMonth() + 1 <= 9) ? '0' + (new Date().getMonth() + 1) : (new Date().getMonth() + 1)) + "-"
	  	  today += ((new Date().getDate() <= 9) ? '0' + (new Date().getDate()) : (new Date().getDate()));
	
	  // Datepicker 설정
	  $("#bookingDate").datepicker();
	  $("#bookingDate").datepicker("option", "dateFormat", "yy-mm-dd");
	  $("#bookingDate").datepicker("option", "minDate", minDate);
	  $("#bookingDate").datepicker("option", "maxDate", "+1W");
	
	  // Timepicker 설정
	  $("#bookingTime").timepicker({
	    zindex: 99999,
	    timeFormat: 'hh:mm p',
	    interval: 60,
	    minTime: '10',
	    maxTime: '18',
	    startTime: '10:00',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true,
	    disabled: true
	  });
	
	  // 날짜 먼저 선택할 수 있는 기능
	  $("#mouseEnterTime").mouseenter(function() {
	    if ($("#bookingDate").val() != "") {
	      $("#bookingTime").attr("disabled", false);
	      
	      // 선택한 날짜가 오늘 날짜이면 현재 시간 기준으로 minTime 변경
	      if ($("#bookingDate").val() == today) {
	        $("#bookingTime").timepicker("option", "minTime", String(minDate.getHours() + 1));
	      }
	    }
	  });
	  $("#mouseEnterTime").click(function() {
	    if ($("#bookingDate").val() == "") {
	      alert("날짜를 먼저 선택해주세요.");
	      return false;
	    }
	  })
	
	  // 날짜, 시간 선택시에만 예약하기 버튼 활성화
	  $("#mouseEnterBooking").mouseenter(function() {
	    if ($("#bookingDate").val() != "" && $("#bookingTime").val() != "") {
	      $("#consultBookingModal .btn-primary").attr("disabled", false);
	    } 
	  })
	  $("#mouseEnterBooking").click(function() {
	    if ($("#bookingDate").val() == "" || $("#bookingTime").val() == "") {
	      alert("상담하실 날짜와 시간을 선택해주세요.");
	      return false;
	    }
	  })
	});
  	
	// 찜 기능 관련
	$(function() {
		
		// 매물 찜 조회
		if (${ not empty loginUser and loginUser.identifier == 'member' }) { // 로그인한 상태
			$.ajax({
				url: "select.zz",
				data: {
					memberNo: Number(${ loginUser.memberNo == "" ? 0 : loginUser.memberNo }),
					houseNo: Number(${ house.houseNo })
				},
				type: "POST",
				success: function(result) {
					if (result != ${ house.houseNo }) { // 찜하지 않은 경우
						$("#zzimImg").attr("class", "notZzim");
					} else { // 찜한 경우
					  	$("#zzimImg").attr("class", "isZzim");
					}
				},
				error: function() {
					console.log("찜 조회 ajax 통신 실패");
				}
			})
		} else { // 로그아웃 상태
			$("#zzimImg").attr("class", "notZzim");
		}
		
		// 찜 버튼 클릭  
		$("#zzimBtn").click(function() {
			
			// 로그인 상태
			if (${ not empty loginUser and loginUser.identifier == 'member' }) {
				// 찜이 되어있는 경우 - 찜 삭제
				if ($("#zzimImg").attr("class") == "isZzim") {
					$.ajax({
						url: "delete.zz",
						data: {
							memberNo: Number(${ loginUser.memberNo == "" ? 0 : loginUser.memberNo }),
							houseNo: Number(${ house.houseNo })
						},
						type: "POST",
						success: function(result) {
							if (result < 0) {
								alert("찜 삭제에 실패했습니다. 다시 시도해주세요.");
								return false;
							} else {
								$("#zzimImg").attr("class", "notZzim");
							}
						},
						error: function() {
							console.log("찜 삭제 ajax 통신 실패");
						}
					})
				  
				// 찜이 되어있지 않은 경우 - 찜 추가
				} else if ($("#zzimImg").attr("class") == "notZzim") {
					$.ajax({
						url: "insert.zz",
						data: {
							memberNo: Number(${ loginUser.memberNo == "" ? 0 : loginUser.memberNo }),
							houseNo: Number(${ house.houseNo })
						},
						type: "POST",
						success: function(result) {
							if (result < 0) {
								alert("찜 하기에 실패했습니다. 다시 시도해주세요.");
								return false;
							} else {
								$("#zzimImg").attr("class", "isZzim");
							}
						},
						error: function() {
							console.log("찜 추가 ajax 통신 실패");
						}
					})
				}
				
			// 로그아웃 상태
			} else {
				alert("개인 회원 로그인 후 사용 가능한 서비스입니다. ");
				return false;
			}
		})
	})
	
	$(function() {
		
		// 평, m2 변환 버튼 클릭
		$("#sizeChange").click(function() {
			if ($("#size").attr("class") == "m2") {
				$("#size").text(${ Math.ceil(house.size_p) } + "평");
				$("#change").text("m²");
				$(".m2").attr("class", "p");
			} else {
				$("#size").text(${ house.size_m2 } + "m²");
				$("#change").text("평");
				$(".p").attr("class", "m2");
			}
		})
		
		
	})
	
	// 허위 매물 신고
	$(function() {
		// 허위 신고 모달창 버튼 활성화
		$("#notify").mouseenter(function() {
			if (${ not empty loginUser and loginUser.identifier eq 'member' }) {
				$(this).attr("data-bs-toggle", "modal");
			} else {
				$(this).attr("data-bs-toggle", "");
			}
		})
		
		// 허위 신고 모달창 버튼 클릭
		$("#notify").click(function() {
			if (${ empty loginUser or loginUser.identifier ne 'member' }) {
				alert("개인 회원 로그인 후 사용 가능한 서비스입니다. ")
				return false;
			}
		})
		
		// 허위 신고 버튼 클릭
		$("#notifyBtn").click(function() {
			$.ajax({
				url: "update.rp",
				data: {houseNo: ${ house.houseNo }},
				type: "POST",
				succeess: function(result) {
					if (result <= 0) {
						alert("허위 매물 신고에 실패했습니다. 다시 시도해주세요.");
						return false;
					}
				},
				error: function() {
					console.log("허위 매물 신고 추가 ajax 실패");
				}
			})
		})
		
	})
  </script>
  
</body>
</html>