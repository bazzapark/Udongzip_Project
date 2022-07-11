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
    <link rel="stylesheet" href="resources/css/user/agentReviewListView.css">
    <!-- js -->
	<script type="text/javascript" src="resources/js/user/agentReviewListView.js"></script>
</head>
<body>

    <div id="wrap">

        <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">리뷰 목록</h1>

            <div id="review-list-area">

                <div class="search-area">
                </div>

                <div class="filter-area">
                    <select id="filter-select">
                        <option value="전체">전체</option>
                        <option value="만족">만족</option>
                        <option value="불만족">불만족</option>
                    </select>
                </div>

                <span class="list-amount"></span>
                <table id="review-list">
                    <thead align="center">
                        <tr>
                        	<th>리뷰 번호</th>
                            <th style="width: 150px; height: 60px;">작성자</th>
                            <th style="width: 350px;">리뷰 내용</th>
                            <th>만족도</th>
                            <th>작성일</th>
                            <th>삭제 요청</th>
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

                <div class="modal" id="request-modal">
                    <div class="modal-body">
        
                        <h3>리뷰 삭제 요청</h3>
                        <hr>
                        <form action="insert.req" method="post">
                            <input type="hidden" name="agentNo" value="${ loginUser.agentNo }">
                            <input type="hidden" name="reviewNo" id="revNo">
                            <table class="modal-table">
                                <tr>
                                    <th>작성자</th>
                                    <td colspan="3" class="memId"></td>
                                </tr>
                                <tr>
                                    <th>평가</th>
                                    <td colspan="3" class="revSatisfied"></td>
                                </tr>
                                <tr>
                                    <th>작성일</th>
                                    <td colspan="3" class="revDate"></td>
                                </tr>
                                <tr style="height: 100px;">
                                    <th>리뷰 내용</th>
                                    <td colspan="3" class="revContent"></td>
                                </tr>
                                <tr>
                                    <th colspan="4">요청 사유</th>
                                </tr>
                                <tr style="height: 200px;">
                                    <td colspan="4">
                                        <textarea name="reason" class="reason" maxlength="300" placeholder="삭제를 요청하는 사유를 입력하세요."></textarea>
                                    </td>
                                </tr>
                            </table>
                            
                            <button type="submit" class="button submit-btn">제출</button>
                            <button type="button" class="button cancle-btn">취소</button>
                        </form>
                    </div>
                </div>
                
                <div class="modal" id="detail-modal">
                    <div class="modal-body">
        
                        <h3>리뷰 상세 내용</h3>
                        <hr>
                        <form>
                            <table class="modal-table">
                                <tr>
                                    <th>작성자</th>
                                    <td colspan="3" class="memId"></td>
                                </tr>
                                <tr>
                                    <th>평가</th>
                                    <td colspan="3" class="revSatisfied"></td>
                                </tr>
                                <tr>
                                    <th>작성일</th>
                                    <td colspan="3" class="revDate"></td>
                                </tr>
                                <tr style="height: 100px;">
                                    <th>리뷰 내용</th>
                                    <td colspan="3" class="revContent"></td>
                                </tr>
                            </table>
                            <button type="button" class="button close-btn">닫기</button>
                        </form>
                    </div>
                </div>

            </div>

        </div>

        <jsp:include page="../../common/footer.jsp" />

    </div>
    
    <script>
    	var list;
    	var filterList;
    
    	$(function() {
    		getList();
    	})
    	
    	function getList() {
    		$.ajax({
    			url : "agentListView.rev",
    			data : { agentNo : ${ loginUser.agentNo } },
    			type : "post",
    			success : function(result) {
    				
    				list = result;
    				filterList = list;
    				listCount = result.length;
	                
	                if(listCount > 0) {
	                	
	                	displayList(1, listLimit, list);
		                
		                paging(listCount, listLimit, pageLimit, 1, list);
	                	
	                } else {
	                	
	                	$("#review-list tbody").text("");
	                	
	                	var noList = "<tr id='no-list'>"
	                			   + "<td colspan='5' class='not-click'>"
	                			   + "조회된 리뷰가 없습니다."
	                			   + "<td>"
	                			   + "</tr>";
	                			   
	                	$("#review-list tbody").append(noList);
	                	
	                }
    				
    			},
    			error : function() {
    				console.log("통신 실패");
    			}
    		});
    		
    	};
    </script>

</body>
</html>