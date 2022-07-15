<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
	<!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- kakao Map API -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb745863a35f0463287daae4b2b8e51&libraries=services"></script>
    <!-- 주소 검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- css -->
    <link rel="stylesheet" href="resources/css/user/houseEnrollForm.css">
    <!-- js -->
    <script type="text/javascript" src="resources/js/user/houseEnrollForm.js"></script>
</head>
<body>

	    <div id="wrap">
	    
	    <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">신규 매물 등록</h1>
            <br>

            <form id="house-enroll-form" action="insert.ho" method="post" enctype="multipart/form-data">

                <h2>위치 정보</h2>
                <hr>
	
				<input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
                <table class="info-table" style="margin-bottom: 30px;">
                    <tr>
                        <th style="width: 200px; height: 250px;">주소</th>
                        <td colspan="3">
                            <div class="form-floating">
                                <input type="text" id="address1" name="address1" class="form-control long-input" required>
                                <label for="address1">도로명 주소</label>
                            </div>
                            <div class="form-floating">
                                <input type="text" id="address2" name="address2" class="form-control long-input" required>
                                <label for="address2">상세 주소</label>
                            </div>
                            <div class="form-floating">
                                <input type="text" id="zipCode" name="zipCode" pattern="[0-9]+" maxlength="5" class="form-control short-input" required">
                                <label for="zipCode" class="input-label">우편번호</label>
                                <input type="hidden" name="lat" id="lat">
                                <input type="hidden" name="lng" id="lng">
                            </div>
                            <button type="button" id="map-btn" class="button map-btn">위치 확인하기</button>
                        </td>
                    </tr>
                </table>
                <div id="map-area">
                    <div class="info-text map-info">
                        <p>
                            1. 상세주소는 검증과 지도 노출 시 사용되며 고객에게 노출되지 않습니다.
                            <br><br>
                            2. 상세주소가 정확하지 않으면 등기부등본 조회 시 등록이 취소됩니다. <br>
                                - 등기부에 나와있는 동/호수를 정확히 입력해주세요.
                            <br><br>
                            3. 실제 위치와 우측에 지도 상의 위치가 일치하지 않는 경우 <br>
                               - 도로명 주소와 상세주소를 다시 한 번 확인해주세요. <br>
                               - 올바른 주소를 입력 했다면 고객센터로 문의해주세요. <br><br>
                            4. 위치 정보는 추후에 수정이 불가합니다.
                        </p>
                    </div>
                    <div id="map" class="real-map"></div>
                </div>

                <h2>매물 사진</h2>
                <hr>

                <div id="img-area">
                    <div class="thumbnail-area">
                        <img class="previewer-big">
                        <input type="file" class="file-input" name="thumbnailFile" accept="png, jpg, jpeg" required>
                        <h4 align="center">대표사진</h4>
                    </div>
                    <div class="etc-area">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg" required>
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg" required>
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg" required>
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                        <img class="previewer-small">
                        <input type="file" class="file-input" name="houseImg" accept="png, jpg, jpeg">
                    </div>
                    <br clear="both">
                    <div class="info-text info-area">
                        <p>
                            * 이미지를 등록하려면 해당 영역을 클릭, 삭제를 원하시면 다시 한 번 클릭하세요. <br>
                            * 대표사진을 포함하여 최소 4장 이상의 사진을 등록해야 하며, 최대 10장까지 등록할 수 있습니다. (한 장당 10MB 이내) <br>
                            * 매물 사진 이외의 다른 사진을 등록하는 경우 삭제 조치 될 수 있습니다. <br>
                            * 직접 찍은 사진만 등록해야 합니다. <br>
                            * png, jpg, jpeg 파일만 등록 가능합니다.
                        </p>
                    </div>
                </div>

                <h2>거래 정보</h2>
                <hr>

                <table class="info-table">
                    <tr>
                        <th style="width: 200px; height: 50px;">계약 형태</th>
                        <td colspan="3">
                            <input type="radio" name="salesType" value="월세" id="월세" required>
                            <label for="월세">월세</label> &nbsp;
                            <input type="radio" name="salesType" value="전세" id="전세">
                            <label for="전세">전세</label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 140px;">가격</th>
                        <td colspan="3">
                            <div class="form-floating">
                                <input type="text" id="deposit" name="deposit" pattern="[0-9]+" class="form-control short-input" required>
                                <label for="deposit" class="input-label">전세(보증)금 (만원)</label>
                            </div>
                            <div class="form-floating">
                                <input type="text" id="monthlyCost" name="monthlyCost" pattern="[0-9]+" class="form-control short-input" required>
                                <label for="monthlyCost">월세 (만원)</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 50px;">전세 대출</th>
                        <td colspan="3">
                            <input type="radio" name="loan" value="가능" id="대출가능" required>
                            <label for="대출가능">가능</label> &nbsp;
                            <input type="radio" name="loan" value="불가" id="대출불가">
                            <label for="대출불가">불가</label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 110px;">관리비</th>
                        <td colspan="3">
                            <div class="form-floating">
                                <input type="text" id="manageCost" name="manageCost" pattern="[0-9]+" class="form-control short-input" required>
                                <label for="manageCost">관리비 (만원)</label>
                            </div>
                            <b>포함 항목</b> &nbsp;
                            <c:forEach var="manage" items="${ manageList }">
                            	<input type="checkbox" name="manageInfo" id="${ manage.manageName }" value="${ manage.manageNo }">
                            	<label for="${ manage.manageName }">${ manage.manageName }</label> &nbsp;
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 80px;">
                        	입주가능일 <br>
                        	<span class="info-text">* 년(4자리)/월/일</span>
                        </th>
                        <td colspan="3">
                            <div class="form-floating">
                                <input type="date" id="moveinDate" name="moveinDate" class="form-control short-input" required>
                            	<label for="moveinDate">입주일</label>
                            </div>
                            <input type="checkbox" id="moveinNow">
                            <label for="moveinNow">즉시입주 가능</label>
                        </td>
                    </tr>
                </table>

                <h2>매물 정보</h2>
                <hr>

                <table class="info-table">
                    <tr>
                        <th style="width: 200px; height: 50px;">건물 유형</th>
                        <td colspan="3">
                            <input type="radio" name="buildingType" value="단독주택" id="단독주택" checked>
                            <label for="단독주택">단독주택</label> &nbsp;
                            <input type="radio" name="buildingType" value="다가구주택" id="다가구주택">
                            <label for="다가구주택">다가구주택</label> &nbsp;
                            <input type="radio" name="buildingType" value="오피스텔" id="오피스텔">
                            <label for="오피스텔">오피스텔</label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 150px;">
                        	공급면적 <br>
                        	<span class="info-text">* 입력 시 자동 환산됩니다.</span>
                        </th>
                        <td>
                            <div class="form-floating">
                                <input type="text" id="size_m2" name="size_m2" pattern="[0-9.]+" class="form-control short-input" required>
                                <label for="size_m2">m2</label>
                            </div>
                            <div class="form-floating">
                                <input type="text" id="size_p" name="size_p" pattern="[0-9.]+" class="form-control short-input" required>
                                <label for="size_p">평</label>
                            </div>
                        </td>
                        <th style="width: 200px; height: 150px;">층수</th>
                        <td>
                            <div class="form-floating">
                                <select name="buildingFloor" id="buildingFloor" class="form-control" required>
                                	<c:forEach var="i" begin="1" end="80">
                                    	<option value="${ i }">${ i }층</option>
                                    </c:forEach>
                                </select>
                                <label for="buildingFloor" class="input-label">건물 전체 층수</label>
                            </div>
                            <div class="form-floating">
                                <select name="floor" id="floor" class="form-control" required>
                                    <option value="지하">지하</option>
                                    <option value="반지하">반지하</option>
                                    <option value="옥탑">옥탑</option>
                                    <c:forEach var="i" begin="1" end="80">
                                    	<option value="${ i }">${ i }층</option>
                                    </c:forEach>
                                </select>
                                <label for="floor">매물 층수</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 50px;">방 유형</th>
                        <td colspan=>
                            <div class="form-floating">
                                <select name="roomType" id="roomType" class="form-control short-input" required>
                                    <option value="오픈형 원룸">오픈형 원룸</option>
                                    <option value="분리형 원룸">분리형 원룸</option>
                                    <option value="복층형 원룸">복층형 원룸</option>
                                    <option value="투룸">투룸</option>
                                </select>
                                <label for="roomType">방 유형</label>
                            </div>
                            <input type="hidden" name="roomCount" id="roomCount" value="1">
                        </td>
                        <th style="width: 200px; height: 60px;">방향</th>
                        <td colspan="3">
                            <div class="form-floating">
                                <select id="direction" name="direction" class="form-control" required>
                                    <option value="동향">동향</option>
                                    <option value="서향">서향</option>
                                    <option value="남향">남향</option>
                                    <option value="북향">북향</option>
                                    <option value="남동향">남동향</option>
                                    <option value="남서향">남서향</option>
                                    <option value="북동향">북동향</option>
                                    <option value="북서향">북서향</option>
                                </select>
                                <label for="direction">방향</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 100px;">
                        	지하철 <br>
                        	<span class="info-text">* 가장 가까운 역 1개만 선택</span>
                        </th>
                        <td id="subway-column">
                            <div class="form-floating">
                                <select name="line" id="line" class="form-control short-input" required>
                                	<option>호선</option>
                                    <option value="1호선">1호선</option>
                                    <option value="2호선">2호선</option>
                                    <option value="3호선">3호선</option>
                                    <option value="4호선">4호선</option>
                                    <option value="5호선">5호선</option>
                                    <option value="6호선">6호선</option>
                                    <option value="7호선">7호선</option>
                                    <option value="8호선">8호선</option>
                                    <option value="9호선">9호선</option>
                                    <option value="공항철도">공항철도</option>
                                    <option value="경의선">경의선</option>
                                    <option value="중앙선">중앙선</option>
                                    <option value="수인분당선">수인분당선</option>
                                    <option value="신분당선">신분당선</option>
                                </select>
                                <label for="line">호선</label>
                            </div>
                            <div class="form-floating">
	                            <select name="subwayNo" id="subwayNo" class="form-control short-input" required>
	                            </select>
	                            <label for="subwayNo">역</label>
                            </div>
                        </td>
                        <br clear="both">
                        <th>
                        	주차 가능 <br>
                        	<span class="info-text">* 차량 대수를 입력하세요.</span>
                        </th>
                        <td>
                        	<div class="form-floating">
                                <input type="text" id="parking" name="parking" pattern="[0-9]+" class="form-control" style="width: 120px;" required>
                                <label for="parking" class="input-label">주차 가능 (대)</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 170px;">옵션</th>
                        <td colspan="3" style="width: 700px;">
                        	<c:forEach var="option" items="${ optionList }" varStatus="status">
                        		<c:choose>
	                        		<c:when test="${ status.count mod 6 eq 0 }">
	                            		<input type="checkbox" name="optionInfo" id="${ option.optionName }" value="${ option.optionNo }">
	                            		<label for="${ option.optionName }"><span class="optionText">${ option.optionName }</span></label> <br><br>
	                            	</c:when>
	                            	<c:otherwise>
	                            		<input type="checkbox" name="optionInfo" id="${ option.optionName }" value="${ option.optionNo }">
	                            		<label for="${ option.optionName }"><span class="optionText">${ option.optionName }</span></label>
	                            	</c:otherwise>
                            	</c:choose>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 50px;">반려동물</th>
                        <td colspan="3">
                            <input type="radio" name="pet" value="가능" id="동반가능">
                            <label for="동반가능">가능</label> &nbsp;
                            <input type="radio" name="pet" value="불가" id="동반불가" required>
                            <label for="동반불가">불가</label>
                        </td>
                    </tr>
                </table>

                <h2>안내 정보</h2>
                <hr>

                <table class="info-table">
                    <tr>
                        <th style="width: 200px; height: 90px;">
                        	제목<br>
                        	<span class="info-text"><span id="title-length">0</span>/50</span>
                        </th>
                        <td colspan="3">
                            <div class="form-floating">
                                <input type="text" id="title" name="title" class="form-control long-input" maxlength="50" required>
                                <label for="title" class="input-label">매물 제목</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 200px; height: 600px;">
                        	상세 안내 <br>
                        	<span class="info-text"><span id="description-length">0</span>/950</span>
                        </th>
                        <td colspan="3">
                            <div class="form-floating">
                                <textarea id="description" name="description" class="form-control long-input" maxlength="950" required></textarea>
                                <label for="description" class="input-label">매물 상세정보</label>
                            </div>
                        </td>
                    </tr>
                </table>

                <button type="submit" class="button enroll-btn">등록하기</button>

            </form>

        </div>
        
        <jsp:include page="../../common/footer.jsp" />

    </div>

</body>

<script>
	
	$(function() {
	
		$("select[name=line]").on("change", function() {
		
			$.ajax({
				url : "stationList.ho",
				data : { line : $(this).val() },
				success : function(result) {
					
					$("select[name=subwayNo]").text("");
					
					var resultStr = "";
					
					for(var i = 0; i < result.length; i++) {
						
						resultStr += "<option value='" + result[i].subwayNo + "'>"
								   + result[i].station
								   + "</option>";
						
					}
					
					$("select[name=subwayNo]").append(resultStr);
					
				},
				error : function() {
					alert("지하철 정보를 불러오는데에 실패했습니다. 잠시 후 다시 시도해주새요.");
				}
			})
			
		})
		
	})
	

</script>
</html>