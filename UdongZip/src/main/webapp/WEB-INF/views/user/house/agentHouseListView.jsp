<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/user/agentHouseListView.css">
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- js -->
<script type="text/javascript" src="resources/js/user/agentHouseListView.js"></script>
</head>
<body>

<div id="wrap">

        <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">내 매물 목록</h1>

            <div id="house-list-area">

                <div class="search-area">
                	<select id="category">
                        <option value="TITLE">제목</option>
                        <option value="ADDRESS1">위치</option>
                    </select>
                    <input type="text" id="search-input" placeholder="검색어를 입력하세요">
                    <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id="search-icon">
                </div>

                <span class="list-amount"></span>
                <table id="house-list">
                    <thead>
                        <tr align="center">
                            <th style="width: 80px; height: 60px;">매물 번호</th>
                            <th>대표사진</th>
                            <th>매물 위치</th>
                            <th>매물 제목</th>
                            <th style="width: 100px;">등록일</th>
                            <th style="width: 100px;">계약 상태</th>
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
			                	<button type="button" class="enroll-btn">신규 등록</button>
		                	</td>
	                	</tr>
                	</tfoot>
                </table>

                

            </div>

        </div>

        <jsp:include page="../../common/footer.jsp" />

    </div>
    
    <form action="updateForm.ho" method="post" style="display: none;" id="update-form">
    
    	<input type="hidden" name="houseNo">
    
    </form>
    
    <script>
	    $(function() {
	        
	        getList();
	        
	    })
	    
	    $("#search-icon").on("click", function() {
	    
	    	getList();
	    	
	    });
	    
		function getList() {
	    	
	    	$.ajax({
	            url : "listView.ho",
	            data : {
	            	agentNo : ${ loginUser.agentNo },
	            	category : $("#category").children(":selected").val(),
	    			keyword : $("#search-input").val()
	        	},
	            type : "post",
	            success : function(result) {
	                
	                list = result;
	                
	                listCount = result.length;
	                
	                $(".list-amount").text("총 " + listCount + "건");
	                
	                if(listCount > 0) {
	                	
	                	displayList(1, listLimit, list);
		                
		                paging(listCount, listLimit, pageLimit, 1);
	                	
	                } else {
	                	
	                	$("#house-list tbody").text("");
	                	
	                	var noList = "<tr id='no-list'>"
	                			   + "<td colspan='5' class='not-click'>"
	                			   + "조회된 매물이 없습니다."
	                			   + "<td>"
	                			   + "</tr>";
	                			   
	                	$("#house-list tbody").append(noList);
	                	
	                }
	                
	                
	                
	            },
	            error : function() {
	                
	            }
	        });
		};
	    
	    $(document).on("change", ".not-click", function() {
	    	
	    	console.log();
	    	
	    	$.ajax({
	    		url : "changeStatus.ho",
	    		type : "post",
	    		data : {
	    			houseNo : $(this).siblings().eq(0).text(),
	    			salesStatus : $(this).children().val()
	    		},
	    		success : function(result) {
	    			
	    			if(result == "NNNNY") {
	    				alert("상태 변경 되었습니다.");
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