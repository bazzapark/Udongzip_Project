<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/user/houseMap.css">
</head>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8b77d874cdf7d0680055d6b64f7eb45&libraries=services,clusterer,drawing"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<body>
	
	
	
	<div class="wrap">
		<!-- 헤더 -->
		<jsp:include page="../../common/header.jsp" /> 
		<br><br>
		<div>
		<h2 align="center">매물 조회</h2>
		</div>
		<br>
		
		<div id="content">
			
			<!-- 맵 -->
			<div id="content1" align="center">
				<div id="map"></div>
			</div>
			
			<!-- 매물정보 -->
			<div id="content2">
			
				<!-- 검색 -->
				<div id="search">
					<table>
						<tr>
							<td><input type="text" id="address_kakao" name="address" size="100%" readonly></td>
							<td><button style="width:50px" type="submit" id="searchBtn">검색</button></td>
						</tr>
					</table>
				</div>
				
				<!-- 조건 검색 -->
				<div id="search-detail">
					<div id="search-q"style="font-size: 5px; margin:3px;">조건검색 상세조건을 선택해주세요</div>
					<div id="search-a">
						<form action="list.ma" method="get">
						<table border="1" align="center">
							<tr>
								<th>계 약 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="a" value="월세"> 월 세</label>
									<label><input type="checkbox" name="a" value="전세"> 전 세</label>
								</td>
							</tr>
							<tr>
								<th>건 물 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="b" value="다가구주택"> 다 가 구 주 택</label>
									<label><input type="checkbox" name="b" value="단독주택"> 단 독 주 택</label>
									<label><input type="checkbox" name="b" value="오피스텔"> 오 피 스 텔</label>
								</td>
							</tr>
							<tr>
								<th>건 물 층 수</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="c" value="1층 ~ 5층"> 1 층 ~ 5 층</label>
									<label><input type="checkbox" name="c" value="6층이상"> 6 층 이 상</label>
									<label><input type="checkbox" name="c" value="옥탑"> 옥 탑</label>
									<label><input type="checkbox" name="c" value="반지하"> 반 지 하</label>
								</td>
							</tr>
							<tr>
								<th>방 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="d" value="오픈형"> 오 픈 형</label>
									<label><input type="checkbox" name="d" value="분리형"> 분 리 형</label>
									<label><input type="checkbox" name="d" value="복층형"> 복 층 형</label>
								</td>
							</tr>
							<tr>
								<th>평 수</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="e" value="5평이하"> 5 평 이 하</label>
									<label><input type="checkbox" name="e" value="6평 ~ 10평"> 6 평 ~ 1 0 평</label>
									<label><input type="checkbox" name="e" value="11평이상"> 1 1 평 이 상</label>
								</td>
							</tr>
							<tr>
								<td>
									<button type="reset">초기화</button>
									<button type="submit">매물보기</button>
								</td>
							</tr>
						</table>
						</form>
					</div>
				</div>
				<div id="select-house" style="overflow:auto; height:600px;">
					<table id="result" border="1"></table>
					<br>
				</div>
				
				<br><br>
			</div>	
		</div>
	</div>
	
	<!-- 푸터  -->
	<div id=footer>
	<jsp:include page="../../common/footer.jsp" />
	</div>			
	
	
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.56567098274831, 126.97895819773866), // 지도의 중심좌표
		        level: 8, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 
		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();	

		// 마커 클러스터러를 생성합니다 
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 5 // 클러스터 할 최소 지도 레벨 
	        
	    });
		
	    $('#searchBtn').click(function(){
	    	
	    	// 주소-좌표 변환 객체를 생성합니다
	        var geocoder = new kakao.maps.services.Geocoder();
	    	
	     // 주소로 좌표를 검색합니다
			geocoder.addressSearch($('#address_kakao').val(), function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        // 추출한 좌표를 통해 도로명 주소 추출
		        let lat = result[0].y;
		        let lng = result[0].x;
		        getAddr(lat,lng);
		        function getAddr(lat,lng){
		            let geocoder = new kakao.maps.services.Geocoder();
	
		            let coord = new kakao.maps.LatLng(lat, lng);
		            let callback = function(result, status) {
		                if (status === kakao.maps.services.Status.OK) {
		                	// 추출한 도로명 주소를 해당 input의 value값으로 적용
		                    $('#address_kakao').val(result[0].road_address.address_name);
		                    level: 8
		                }
		            }
		            geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		        }
	        
			     	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
		    	} 
			});  
		});
	 	
		var markers = [];
		
		$(function() {
		
			$.ajax({
				url : "list.lo",
				//dataType : "json",
				success : function(data) {
					
					//console.log(data);
					
					
					
					dataStr = "";
					
					
					for(var i = 0; i < data.length; i++) {
						
						if(data[i].salesType === "월세") {
							dataStr += "<tr>"
									 +		"<td><img src='" + data[i].thumbnail + "'style='width:150px; height:150px;'><td>"
									 + 		"<td><div style='width:100%;'><b>" + data[i].salesType +" "+ data[i].monthlyCost + "만원</b></div><div>" 
									 + 											 data[i].address1 + "</div><div>"
									 +											 data[i].buildingType + " | " + data[i].roomCount + "층 | " + data[i].floor + "층/ " + data[i].buildingFloor + " | <br> 관리비 " + data[i].manageCost + "만원</div>"
									 + "</tr>" 
						}
						else {
							dataStr += "<tr>"
								 +		"<td><img src='" + data[i].thumbnail + "'style='width:150px; height:150px;'><td>"
								 + 		"<td><div style='width:100%;'><b>" + data[i].salesType +" "+ data[i].deposit + "만원</b></div><div>" 
								 + 											 data[i].address1 + "</div><div>"
								 +											 data[i].buildingType + " | " + data[i].roomCount + "층 | " + data[i].floor + "층/ " + data[i].buildingFloor + " | <br> 관리비 " + data[i].manageCost + "만원</div>"
								 + "</tr>" 
								 
						}
						
						
						$("#result").html(dataStr);
						
						if(data[i].buildingType === "오피스텔") {		 
						var markerImageUrl = 'resources/images/housemapicons/skyscraper.png', 
						    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
						    markerImageOptions = { 
						        offset : new kakao.maps.Point(20, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
						    };
						}
						else if(data[i].buildingType === "빌라") {
							var markerImageUrl = 'resources/images/housemapicons/house.png', 
						    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
						    markerImageOptions = { 
						        offset : new kakao.maps.Point(20, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
						    };
							
						}
						else if(data[i].buildingType === "다가구주택") {
							var markerImageUrl = 'resources/images/housemapicons/house.png', 
						    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
						    markerImageOptions = { 
						        offset : new kakao.maps.Point(20, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
						    };
							
						}
						
						
						
						// 마커 이미지를 생성한다
						var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);		 
								 
						// 지도에 마커를 생성하고 표시한다
						var marker = new kakao.maps.Marker({
						    position: new kakao.maps.LatLng(data[i].lat, data[i].lng), // 마커의 좌표
						    image : markerImage,
						    map: map // 마커를 표시할 지도 객체
						});
						
						// 마커 위에 표시할 인포윈도우를 생성한다
						var infowindow = new kakao.maps.InfoWindow({
						    content : data[i].title // 인포윈도우에 표시할 내용
						});

						
						markers.push(marker);
						
						 // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
					    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
					    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
					    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
					    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
					    
					    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
						kakao.maps.event.addListener(marker, 'click', function() {
							
							// location.href = "detail.ma?pno=" + ${houseNo};
						});
					    
					} 
					
					 // 클러스터러에 마커들을 추가합니다
			        clusterer.addMarkers(markers);
					
					// 지도의 우측에 확대 축소 컨트롤을 추가한다
					map.addControl(zoomControl, kakao.maps.ControlPosition.LEFT);
					
					map.setMaxLevel(8);
					
					 // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
			        function makeOverListener(map, marker, infowindow) {
			            return function() {
			                infowindow.open(map, marker);
			            };
			        }

			        // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			        function makeOutListener(infowindow) {
			            return function() {
			                infowindow.close();
			            };
			        }
					
			    
			        
				},
				error : function() {
					console.log("실패");
				}
			});
		});
		

    	

		// slide

		$(function() {
			$("#search-detail>#search-q").click(function() {
				
				var $p = $(this).next();

				console.log($p.css("display"));

				if($p.css("display") == "none") {
					
					$(this).siblings("div").slideUp(1000);

					$p.slideDown(0);
				}
				else {

					$p.slideUp(0);
				}
			});
		});
		
		// 검색창
		window.onload = function(){
		    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
		        //카카오 지도 발생
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("address_kakao").value = data.address; // 주소 넣기
		            }
		        }).open();
		    });
		}
		
		// 상세보기 페이지로 이동
		$(function() {
			
			$("#result").click(function() {

				location.href = "detail.ma?pno=" + $(this).children().children().eq(1).text();  
				
			});
		});
		
		
		
	
	</script>
</body>
</html>