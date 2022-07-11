<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
	<!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- css -->
    <link rel="stylesheet" href="resources/css/user/agentReservationListView.css">
    <!-- js -->
	<script type="text/javascript" src="resources/js/user/agentReservationListView.js"></script>
</head>
<body>

    <div id="wrap">

        <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">상담 예약 현황</h1>
            
            	<div class="search-area">
                </div>

            <div id="reservation-list-area">
                
                <div class="filter-area">
                    <select id="filter-select">
                        <option value="전체">전체</option>
                        <option value="방문 대기">방문 대기</option>
                        <option value="방문 완료">방문 완료</option>
                        <option value="예약 취소">예약 취소</option>
                        <option value="미방문">미방문</option>
                    </select>
                </div>

                <span class="list-amount"></span>
                <table id="reservation-list">
                    <thead align="center">
                        <tr>
                            <th style="width: 80px; height: 60px;">예약 번호</th>
                            <th>예약 고객(ID)</th>
                            <th>문의 매물</th>
                            <th>사전 전달사항</th>
                            <th style="width: 150px;">방문 예정</th>
                            <th style="width: 100px;">결제 상태</th>
                            <th style="width: 100px;">예약 상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                    	<tr>
                    		<td>
                    			<div class="page_wrap">
				                    <div class="page_nation">
				                    </div>
				                </div>
                    		</td>
                    	</tr>
                    </tfoot>
                </table>

                <div class="modal">
                    <div class="modal-body">
        
                        <h3>예약 내역 상세 정보</h3>
                        <hr>
        
                        <table class="modal-table">
                            <tr>
                                <th style="width: 70px;">예약 번호</th>
                                <td id="resNo">1234</td>
                            </tr>
                            <tr>
                                <th>방문 예정일</th>
                                <td id="resDate">2022-06-25 13:00</td>
                            </tr>
                            <tr>
                                <th>고객 ID</th>
                                <td id="resId">gd88</td>
                            </tr>
                            <tr>
                                <th>고객 성함</th>
                                <td id="resName">홍길동</td>
                            </tr>
                            <tr>
                                <th style="height: 60px;">문의 매물</th>
                                <td id="resHouse">
                                    당산동 위치 좋은
                                </td>
                            </tr>
                            <tr>
                                <th>매물 확인</th>
                                <td id="houseCheck">
                                    <a href="">1234</a>
                                </td>
                            </tr>
                            <tr>
                                <th style="height: 150px;">사전<br>문의내용</th>
                                <td id="resContent">이 방이 진짜 있나요</td>
                            </tr>
                            <tr>
                                <th>결제 상태</th>
                                <td id="resDeposit">결제 완료</td>
                            </tr>
                            <tr>
                                <th>방문 상태</th>
                                <td id="resResult">방문 대기</td>
                            </tr>
                        </table>
        
                        <button class="button close-btn">닫기</button>
                    </div>
                </div>

            </div>

        </div>

        <jsp:include page="../../common/footer.jsp" />

    </div>
    
    <script>
    
    	var list;
    
    	$(function() {
    		getList();
    	})
    	
    	function getList() {
    		
    		$.ajax({
    			url : "agentListView.res",
    			data :{ 
    				ano : ${ loginUser.agentNo }
    			},
    			type : "post",
    			success : function(result) {
    				
    				list = result;
    				listCount = result.length;
	                
	                if(listCount > 0) {
	                	
	                	displayList(1, listLimit, list);
		                
		                paging(listCount, listLimit, pageLimit, 1);
	                	
	                } else {
	                	
	                	$("#reservation-list tbody").text("");
	                	
	                	var noList = "<tr id='no-list'>"
	                			   + "<td colspan='6' class='not-click'>"
	                			   + "조회된 내역이 없습니다."
	                			   + "<td>"
	                			   + "</tr>";
	                			   
	                	$("#reservation-list tbody").append(noList);
	                	
	                }
    				
    			},
    			error : function() {
    				console.log("통신 실패");
    			}
    		})
    		
    	}
    	
	    $(document).on("change", ".not-click", function() {
	    	
	    	var status = $(this).children().val();
	    	var el = $(this);
	    	
	    	$.ajax({
	    		url : "changeResult.res",
	    		type : "post",
	    		data : {
	    			reservationNo : $(this).siblings().eq(0).text(),
	    			resultStatus : $(this).children().val()
	    		},
	    		success : function(result) {
	    			
	    			if(result == "NNNNY") {
	    				alert("상태 변경 되었습니다.");
	    				$(el).children().remove();
	    				$(el).text(status);
	    				$(el).removeClass("not-click");
	    			} else {
	    				alert("상태 변경에 실패했습니다. 잠시 후 다시 시도해주세요.");
	    			}
	    			
	    			
	    		},
	    		error : function() {
	    			alert("상태 변경에 실패했습니다. 이 문제가 지속될 시 고객센터로 문의주세요.");
	    		}
	    	})
	    	
	    })
    	
    	
    </script>

</body>
</html>