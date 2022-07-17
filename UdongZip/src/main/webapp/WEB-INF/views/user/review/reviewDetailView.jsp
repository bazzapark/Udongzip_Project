<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .content {
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
        
    </style>
</head>
<body>
    
    <!-- 메뉴바 -->
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br><br><br><br>
        <div class="innerOuter">
            <h2>나의 리뷰 상세보기</h2>
            <br>

            <table id="contentArea" algin="center" class="table">
                <tr>
                    <th width="100">No</th> 
                    <td>${ r.reviewNo }</td>
                    <th width="100">예약정보</th>
                    <td>${ r.reservationNo }</td>
                </tr>
               
                <tr>
                    <th width="100">대상 업체</th>
                    <td>${ r.agentName }</td>
                    <th width="100">만족도</th>
                    <td>
                    	<c:choose>
                    		<c:when test="${ r.satisfied eq 'Y' }">
                    			만족
                    		</c:when>
                    		<c:otherwise>
                    			불만족
                    		</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>
            
                <tr>
                    <th >리뷰 내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr style = "border-style : hidden!important;">
                    <td colspan="4"><p style="height:150px; text-align: center">${ r.content }</p></td>
                </tr>
            </table>
            <br>
			
			<c:if test="${ (not empty loginUser) }">
            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                <a class="btn btn-danger" onclick="postFormSubmit(1);">삭제하기</a>
                <a class="btn btn-secondary"  href="reviewlist.bo">이전</a>
            </div>
            <br><br>
            
            <form id="postForm" action="" method="post">
            	<input type="hidden" name="bno" value="${ r.reviewNo }">
            </form>
            
	            <script>
	            	function postFormSubmit(num) {
	            		
	            		if(num == 1) {
	            		$("#postForm").attr("action", "delete.bo").submit();
	            	  }
	            	}
	            </script>
			</c:if>
        </div>
        <br><br>

    </div>
    
    <!-- 푸터바 -->
    <jsp:include page="../../common/footer.jsp" />
    
</body>
</html>