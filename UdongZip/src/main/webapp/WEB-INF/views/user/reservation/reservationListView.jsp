<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우동집 | 우리동네집 모아보기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="resources/css/admin/inquiryListView.css">
    <style>
        .content {
            width:100%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #boardList {text-align:center;}
        #boardList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
        
        td { text-align: center; }
    </style>
</head>
<body>
    
    <!-- 메뉴바 -->
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br><br><br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>나의 예약</h2>
            <br>
            <br>
            <table class="table table-hover" id="reservation-list" align="center">
                <thead align="center">
                    <tr>
                        <th>예약번호</th>
                        <th>예약일</th>
                        <th>예약시간</th>
                        <th>업체명</th>
                        <th>문의매물</th>
                        <th>예약상태</th>
                        <th>결제상황</th>
                        <th>리뷰작성</th>
                    </tr>
                </thead>
                <tbody align="center">
                 <c:forEach var="re" items="${ list }">
                    <tr>
                        <td class="bno">${ re.reservationNo }</td>
                        <td>${ re.reservationDate }</td>
                        <td>${ re.reservationTime }</td>
                        <td>${ re.agentName }</td>
                        <td>${ re.houseNo }</td>
                        <td>${ re.result }</td>
                        <td>${ re.deposit }</td>
                        
                        <c:choose>
                          <c:when test="${ re.result eq '방문 완료' }">
                     	   <td> 
                     	   	<c:choose>
                     	   		<c:when test="${ re.reviewNo eq 0 }">
                     	   			<button type="button" class="btn btn-primary" onclick="r(this)">글쓰기</button>
                     	   			<input type="hidden" value="${ re.agentNo }">
                     	   			<input type="hidden" value="${ re.agentName }">
                     	   		</c:when>
                     	   		<c:otherwise>
                     	   			<button type="button" class="btn btn-primary disabled" onclick="r()">글쓰기</button>
                     	   		</c:otherwise>
                     	   	</c:choose>
                     	   </td>
                          </c:when>
                        
                          <c:otherwise>
                            <td> <button type="button" class="btn btn-primary disabled" onclick="r()">글쓰기</button></td>
                          </c:otherwise>
                        </c:choose>
                        
                    </tr>
                  </c:forEach>
                </tbody>
            </table>
            <br>
            
			<script>
			function r(el) {
				
				var resNo = $(el).parent().siblings().eq(0).text();
				var agentNo = $(el).siblings().eq(0).val();
				var agentName = $(el).siblings().eq(1).val();
				
				location.href = "reservationFome.bo?agentNo=" + agentNo + "&aname=" + agentName + "&reservationNo=" + resNo;
			}
			</script>
			
            <div id="pagingArea">
                <ul class="pagination">
                    <c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                   			 <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="reservationlist.bo?cpage=${ pi.currentPage - 1 }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                    <li class="page-item"><a class="page-link" href="reservationlist.bo?cpage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="reservationlist.bo?cpage=${ pi.currentPage + 1 }">Next</a></li>
                    	</c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
        </div>
        <br><br>

    </div>

    	<!-- 버튼 클릭 시 보여질 Modal -->

        <div class="modal" id="reservation-modal">
            <div class="modal-dialog">
                <div class="modal-content">
        
            <div class="modal-header">
                <h4 class="modal-title">예약내역</h4>
                <button type="button" class="btn btn-outline-secondary btn-sm modal-close">&times;</button>
            </div>

                <form id="enrollForm" method="post">
                <input type="hidden" name="memberNo">
                    <table algin="center">
                        <tr>
                            <th><label for="title">예약번호</label></th>
                            <td id="reservationNo"></td>
                        </tr>
                        <tr>
                            <th><label for="title">예약일</label></th>
                            <td id="reservationDate"></td>
                        </tr>
                        <tr>
                            <th><label for="title">예약시간</label></th>
                            <td id="reservationTime"></td>
                        </tr>
                        <tr>
                            <th><label for="title">업체명</label></th>
                            <td id="agentName"></td>
                            
                        </tr>
                        <tr>
                            <th><label for="title">매물번호</label></th>
                            <td id="houseNo"></td>
                        </tr>
                    </table>
                    <br>
        
                    <div align="center">
                        <button type="submit" class="btn btn-primary">확인</button>
                    </div>
        
                </form>
            </div>
        </div>
        </div>
    
        <!-- 모달 끝 -->
    
    <script>
        $(function() {


            // inquiry-table의 tbody의 tr의 td 중 첫번째 자식 td를 제외한 모든 td 클릭 시 함수
            // 체크박스 선택 시에도 모달창이 뜨는 현상을 방지하기 위해서 제외시키기 위한 선택자
            $("#reservation-list>tbody>tr>td").not(":last-child").click(function(){

                $("#reservation-modal").show(); // 모달 창 띄우기

            });

            // 모달 닫기 버튼 클릭 시 함수
            $(".modal-close").click(function() {

                $("#reservation-modal").hide(); // 모달 닫기

            });
        });
    </script>
    
    <script>
	    $(function() {
	       
	       // 해당 tr 내용 표시
	       $("#reservation-list>tbody").on("click", "tr", function() {
	          $.ajax({
	             url: "reservationdetail.bo",
	             data: {reservationNo: $(this).children().eq(0).text()},
	             success: function(reservation) {
	            	 
	            	 console.log(reservation);
	            	
	            	$("input[name=memberNo]").val(reservation.memberNo);
	            	$("#reservationNo").text(reservation.reservationNo);
	                $("#reservationDate").text(reservation.reservationDate);
	                $("#reservationTime").text(reservation.reservationTime);
	                $("#agentName").text(reservation.agentName);
	                $("#houseNo").text(reservation.houseNo);
	                
	             },
	             error: function() {
	                console.log("상세 조회 ajax 실패");
	             }
	          })
	       })
	    })
    
    </script>

    <!-- 푸터바 -->
    <jsp:include page="../../common/footer.jsp" />
    
    

</body>
</html>