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
    <link rel="stylesheet" href="resources/css/user/agentInquiryListView.css">
    <!-- js -->
	<script type="text/javascript" src="resources/js/user/agentInquiryListView.js"></script>
</head>
<body>

<div id="wrap">

        <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">1:1문의 내역</h1>

            <div id="inquiry-list-area">

                <div class="search-area">
                </div>

                <div class="filter-area">
                    <select id="filter-select">
                        <option value="전체">전체</option>
                        <option value="계정 문의">계정 문의</option>
                        <option value="매물 문의">매물 문의</option>
                        <option value="예약 문의">예약 문의</option>
                        <option value="기타 문의">기타 문의</option>
                    </select>
                </div>

                <span class="list-amount"></span>
                <table id="inquiry-list">
                    <thead align="center">
                        <tr>
                            <th style="width: 80px; height: 60px;">문의 번호</th>
                            <th style="width: 100px;">카테고리</th>
                            <th>제목</th>
                            <th style="width: 100px;">작성일</th>
                            <th style="width: 100px;">답변 상태</th>
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

            </div>

        </div>

        <jsp:include page="../../common/footer.jsp" />

    </div>

</body>

<form action="agentDetail.in" method="post" id="detail-form" style="display:none;">
	<input type="hidden" name="inquiryNo">
</form>

<script>

	var list;
	var filterList;

	$(function() {
		getList();
	})
	
	function getList() {
		$.ajax({
			url : "agentListView.in",
			data : { agentNo : ${ loginUser.agentNo } },
			type : "post",
			success : function(result) {
				
				console.log(result);
				
				list = result;
				filterList = list;
				listCount = result.length;
                
                if(listCount > 0) {
                	
                	displayList(1, listLimit, list);
	                
	                paging(listCount, listLimit, pageLimit, 1, list);
                	
                } else {
                	
                	$("#review-list tbody").text("");
                	
                	var noList = "<tr id='no-list'>"
                			   + "<td colspan='4' class='not-click'>"
                			   + "조회된 리뷰가 없습니다."
                			   + "<td>"
                			   + "</tr>";
                			   
                	$("#review-list tbody").append(noList);
                	
                }
				
			},
			error : function() {
				console.log("통신 실패");
			}
		})
	}

</script>
</html>