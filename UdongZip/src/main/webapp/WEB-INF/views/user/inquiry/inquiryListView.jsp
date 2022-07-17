<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        
        th, td {
			  text-align: center;
			}
    </style>
</head>
<body>
    
    <!-- 메뉴바 -->
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br><br><br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>1:1 문의내역</h2>
            <br>
            <br>
            <table id="inquiryList" class="table table-hover" align="center">
                <thead align="center">
                    <tr>
                    	<th>문의번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>상태-해야함</th>
                    </tr>
                </thead>
                <tbody>
                
                <c:forEach var="i" items="${ list }">
                    <tr>
                        <td class="bno">${ i.inquiryNo }</td>
                        <td>${ i.title }</td>
                        <td>${ i.createDate }</td>
                        <td>${ i.answerDate }</td>
                    </tr>
                 </c:forEach>
                 
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#inquiryList>tbody>tr").click(function(){
            			
            			location.href = "inquirydetail.bo?bno=" + Number($(this).children(".bno").text());
            		});
            	});
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                   
                    <c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                   			 <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="inquirylist.bo?cpage=${ pi.currentPage - 1 }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                    
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                    <li class="page-item"><a class="page-link" href="inquirylist.bo?cpage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li class="page-item"><a class="page-link" href="inquirylist.bo?cpage=${ pi.currentPage + 1 }">Next</a></li>
                    	</c:otherwise>
                   
                    </c:choose>
                </ul>
            </div>

            <!-- 푸터바 -->
            <br clear="both"><br>
            
        </div>
        <br><br>

    </div>

    <jsp:include page="../../common/footer.jsp" />

</body>
</html>