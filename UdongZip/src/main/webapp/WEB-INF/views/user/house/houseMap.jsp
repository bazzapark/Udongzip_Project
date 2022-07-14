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
							<td><input type="text" class="form-control" id="search-input" name="address1" size="100%" placeholder="주소를 입력해주세요."></td>
							<td><button style="width:60px" type="button" id="searchBtn" align="center" class="btn btn-primary"><img src="resources/images/search-btn.png" style="width:30px; height:30px;"></button></td>
						</tr>
					</table>
				</div>
				
				<!-- 조건 검색 -->
				<div id="search-detail">
					<div id="search-q"style="font-size: 15px; margin:3px;">상세보기<img src="resources/images/angle.png" id="angle" style="width:20px; height:20px;"></div>
					<div id="search-a">
						<form action="" method="get">
						<table align="center" id="search">
							<tr>
								<th>계 약 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="salesType" value="월세"> 월 세</label>
									<label><input type="checkbox" name="salesType" value="전세"> 전 세</label>
								</td>
							</tr>
							<tr>
								<th>건 물 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="buildingType" value="다가구주택"> 다 가 구 주 택</label>
									<label><input type="checkbox" name="buildingType" value="단독주택"> 단 독 주 택</label>
									<label><input type="checkbox" name="buildingType" value="오피스텔"> 오 피 스 텔</label>
								</td>
							</tr>
							<tr>
								<th>건 물 층 수</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="floor" value="지상"> 지 상</label>
									<label><input type="checkbox" name="floor" value="옥탑"> 옥 탑</label>
									<label><input type="checkbox" name="floor" value="반지하"> 반 지 하</label>
								</td>
							</tr>
							<tr>
								<th>방 유 형</th>
							</tr>
							<tr>
								<td>
									<label><input type="checkbox" name="roomType" value="오픈형 원룸"> 오 픈 형 원 룸</label>
									<label><input type="checkbox" name="roomType" value="분리형 원룸"> 분 리 형 원 룸</label>
									<label><input type="checkbox" name="roomType" value="복층형 원룸"> 복 층 형 원 룸</label>
									<label><input type="checkbox" name="roomType" value="투룸"> 투 룸</label><br><br>
								</td>
							</tr>
							<tr>
								<td>
									<button type="reset" id="resetBtn" class="btn btn-warning">초기화</button>
									<button type="button" id="checkBtn" class="btn btn-primary">매물보기</button>
									<br>
								</td>
							</tr>
						</table>
						</form>
					</div>
				</div>
				<div id="select-house" style="overflow:auto; height:630px;">
					<table id="result">
					</table>
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
	
		
		$(function() {
			
			$.ajax({
				url : "list.lo",
				success : function(data) {
					
					
					test01(data);
					
				},
				error : function() {
					console.log("ajax 통신 실패!");
				}
			});
		
		});
		
    	
    	$("#checkBtn").on("click", function() {	
    		
    		getList();
    	
    	});
    	
    	
    	function getCheckList(condition) {
    		var temp = document.getElementsByName(condition);

    		var arr = [];
    		var count = 0;
    		for(var i = 0; i < temp.length; i++) {
    			
    			if(temp[i].checked) {
    				arr[count++] = temp[i].value;
    			}
    		}
    		return arr;
    	}
    	
    	function getList() {
    		
    		var salesType = getCheckList("salesType");
    		var buildingType = getCheckList("buildingType");
    		var floor = getCheckList("floor");    		
    		var roomType = getCheckList("roomType");
    		
    		$.ajax({
    			url : "search.ma",
    			data : {
    				salesType : salesType,
    				buildingType : buildingType,
    				floor : floor,
    				roomType : roomType
    			},
    			success : function(data) {
    				if(data != 0) {
    				
    					$("#result").empty();
    					test01(data);
    				}
    				else {
    					$("#result").empty();
    					$("#result").html("검색결과가 없습니다.");
    				}
    			},
    			error : function() {
    				console.log("ajax 통신 실패!");
    			}
    		});
    		
    		
    		
    	};
    	
		$("#searchBtn").on("click", function() {	
    		
    		search();
    	
    	});
    	
    	function search() {
    		
    		$.ajax({
    			url : "search.lo",
    			headers : { 'Authorization' : 'KakaoAK a8b77d874cdf7d0680055d6b64f7eb45'},
    			data : {
    				address1 : $("#search-input").val(),
    			},
    			success : function(data) {
    				
    				if(data != 0) {
    					$("#result").empty();
        				test01(data);	
    				}
    				else {
    					$("#result").empty();
    					$("#result").html("검색결과가 없습니다.");
    				}
    			},
    			error : function() {
    				console.log("ajax 통신 실패!");
    			}
    		});
    	}
    	
		
		// slide

		$(function() {
			$("#search-detail>#search-q").click(function() {
				
				var $p = $(this).next();


				if($p.css("display") == "none") {
					
					$(this).siblings("div").slideUp(1000);
					

					$p.slideDown(0);
				}
				else {

					$p.slideUp(0);
				}
			});
		});
		
		
		
	
		function test01(data) {
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.5251992697347, 126.897104767379), // 지도의 중심좌표
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
		        minLevel: 5, // 클러스터 할 최소 지도 레벨 
		        calculator: [10, 20, 30, 40, 50, 60], // 클러스터의 크기 구분 값, 각 사이값마다 설정된 text나 style이 적용된다
		        styles: [{ // calculator 각 사이 값 마다 적용될 스타일을 지정한다
	                width : '30px', height : '30px',
	                background: 'green',
	                borderRadius: '15px',
	                color: '#000',
	                textAlign: 'center',
	                fontWeight: 'bold',
	                lineHeight: '31px'
	            },
	            {
	                width : '40px', height : '40px',
	                background: 'yellow',
	                borderRadius: '20px',
	                color: '#000',
	                textAlign: 'center',
	                fontWeight: 'bold',
	                lineHeight: '41px'
	            },
	            {
	                width : '50px', height : '50px',
	                background: 'orange',
	                borderRadius: '25px',
	                color: '#000',
	                textAlign: 'center',
	                fontWeight: 'bold',
	                lineHeight: '51px'
	            },
	            {
	                width : '60px', height : '60px',
	                background: 'red',
	                borderRadius: '30px',
	                color: '#000',
	                textAlign: 'center',
	                fontWeight: 'bold',
	                lineHeight: '61px'
	            }
	           
	        ]
		    
		    
		    
		    });
			
var markers = [];
			
			var dataStr = "";
			
			for(var i = 0; i < data.length; i++) {
			
				var deposit = data[i].deposit.toLocaleString('ko-KR');
			
				
				if(data[i].salesType === "월세") {
					dataStr += "<tr>"
							 +      "<td style='display: none;' id='houseNo'>" + data[i].houseNo + "</td>"
							 +		"<td style='display: none;' id='lat'>" + data[i].lat + "</td>"
							 +		"<td style='display: none;' id='lng'>" + data[i].lng + "</td>"
							 +		"<td><img src='" + data[i].thumbnail + "'style='width:100%; height:100%;'><td>"
							 + 		"<td><div style='width:100%; font-size :17px;'><img src='resources/images/housemapicons/wal.png' style='width:20px; height:20px;'><b>" + data[i].salesType +" "+ data[i].monthlyCost + "만원</b><br></div><div style='width:100%; font-size :15px;'>" 
							 + 											 data[i].address1 + "</div><div style='width:100%; font-size :15px;'>"
							 +											 data[i].buildingType + " | 방" + data[i].roomCount + "개 | " + data[i].floor + "층/ " + data[i].buildingFloor + " | <br> 관리비 " + data[i].manageCost + "만원<br>" + data[i].title + "</div>"
							 + "</tr>" 
				}
				else {
					dataStr += "<tr>"
							 +      "<td style='display: none;' id='houseNo'>" + data[i].houseNo + "</td>"
							 +		"<td style='display: none;' id='lat'>" + data[i].lat + "</td>"
							 +		"<td style='display: none;' id='lng'>" + data[i].lng + "</td>"
							 +		"<td><img src='" + data[i].thumbnail + "'style='width:100%; height:100%;'><td>"
							 + 		"<td><div style='width:100%; font-size :15px;'><img src='resources/images/housemapicons/jun.png' style='width:20px; height:20px;'><b>" + data[i].salesType +" "+ deposit + "만원</b></div><div style='width:100%; font-size :13px;'>" 
							 + 											 data[i].address1 + "</div><div style='width:100%; font-size :13px;'>"
							 +											 data[i].buildingType + " | 방" + data[i].roomCount + "개 | " + data[i].floor + "층/ " + data[i].buildingFloor + " | <br> 관리비 " + data[i].manageCost + "만원<br>" + data[i].title + "</div>"
							 + "</tr>" 
						 
				}
				
				
				$("#result").html(dataStr);
				
				
				if(data[i].buildingType === "오피스텔") {		 
				
					var markerImageUrl = 'resources/images/housemapicons/opi.png', 
				    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
				    markerImageOptions = { 
				        offset : new kakao.maps.Point(20, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
				    };
				}
				else if(data[i].buildingType === "다가구주택") {		 
					
					var markerImageUrl = 'resources/images/housemapicons/da.png', 
				    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
				    markerImageOptions = { 
				        offset : new kakao.maps.Point(20, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
				    };
				}
				else {
					
					var markerImageUrl = 'resources/images/housemapicons/dan.png', 
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
				    map : map, // 마커를 표시할 지도 객체
				    title : data[i].houseNo
				});
				
				// 마커 위에 표시할 인포윈도우를 생성한다
				var infowindow = new kakao.maps.InfoWindow({
				    content : '<div style="width:400px; padding:5px;">' + data[i].title + '</div>' // 인포윈도우에 표시할 내용
				});
				
				markers.push(marker);
				
				 // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			   
			    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
				kakao.maps.event.addListener(marker, 'click', function() {
					
					window.open("/udongzip/detail.ho?hno=" + this.Gb);
					
				});
			    
			} 
			
			
			$('#searchBtn').click(function(){
		    	
		    	// 주소-좌표 변환 객체를 생성합니다
		        var geocoder = new kakao.maps.services.Geocoder();
		    	
		     	// 주소로 좌표를 검색합니다
				geocoder.addressSearch($('#search-input').val(), function(data, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng($("#result>tr").children().eq(1).html(), $("#result>tr").children().eq(2).html());
			        
			        // 추출한 좌표를 통해 도로명 주소 추출
			        var lat = $("#result>tr").children().eq(1).html();
			        var lng = $("#result>tr").children().eq(2).html();
			        getAddr(lat,lng);
			        
			        function getAddr(lat,lng){
			            var geocoder = new kakao.maps.services.Geocoder();
		
			            var coord = new kakao.maps.LatLng(lat, lng);
			            var callback = function(data, status) {
			                if (status === kakao.maps.services.Status.OK) {
			                	// 추출한 도로명 주소를 해당 input의 value값으로 적용
			                    $('#search-input').val();
			                    level: 3
			                }
			            }
			            geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
			        }
		        
				     	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
			    	} 
				});  
			});
		    
			
			
			 // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
			
			// 지도의 우측에 확대 축소 컨트롤을 추가한다
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
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
			
	        // list 클릭 시 상세보기 페이지로 이동
	        $(function() {
	        	
		         $("#result").on("click", "tr", function() {
		            
		            var hno = Number($(this).children().eq(0).text());
		            var form = document.createElement("form");
		            var input = document.createElement("input");
		            
		            
		            form.action = "detail.ho";
		            form.method = "GET";
		            form.target = "_blank";
		            input.name = "hno";
		            input.value = hno;
		            form.appendChild(input);
		            form.style.display ="none";
		            document.body.appendChild(form);
		            form.submit();
		            
		         })
		      });
	        
	        // list : hover
	        var hoverMarker;
	        
	        
	        $("#result").on("mouseover", "tr", function() {
		        
	        	
	        	$(this).css('cursor','pointer');
	        	$(this).css('background-color', 'lightgray');
	        	
	        	
	        	// 지도에 마커를 생성하고 표시한다
				hoverMarker = new kakao.maps.Marker({
				    position: new kakao.maps.LatLng($(this).children().eq(1).html(), $(this).children().eq(2).html()), // 마커의 좌표
				    
				});
	        	
	        	hoverMarker.setMap(map);
	        	
	        	
	         });
	         $("#result").on("mouseout", "tr", function() {
	        	 
	        	$(this).css('cursor','default');
	        	$(this).css('background-color', 'white');
	        	
	        	hoverMarker.setMap(null);
	        	
	         });
		}
		
	</script>
</body>
</html>