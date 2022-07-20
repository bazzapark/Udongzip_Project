<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8b77d874cdf7d0680055d6b64f7eb45&libraries=services,clusterer,drawing"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<style>
    div{
        box-sizing: border-box;
    }

    .wrap{
        width: 900px;
        /* height: 1500px; */
        margin: auto;
    }

    .w_{
        width: 100%;
    }

    .top{
        height: 10%;
    }

    .body{
        height: 70%;
    }

    .bottom{
        height: 20%;
    }

    td.body_r{
        width: 80%;
        height: 97%;
        vertical-align: top;
    }

    /* 상세 항목 */
    /* 사진 */
    .list-area {
    width : 1000px;
    height : 900px;
    margin : auto;
    }
    
    .board-body {
    	width: 100%;
    	height: auto;
    }
    
    .delete {
    	height: auto;
    	width: 100%;
    }

    .thumbnail {
        border : 1px solid lightgray;
        width : 220px;
        height : 250px;
        display : inline-block;
        margin : 30px;
        overflow : hidden;
    }

    .thumbnail:hover {
        cursor : pointer;
        opacity : 0.7;
    }

    #pagingArea {width:fit-content; margin:auto;}
</style>
</head>

<body>

<div id="wrap">
   <!-- 메뉴바 -->
   <jsp:include page="../../common/header.jsp" />
   
   <div id="content-area">
	
    <div class="wrap">
        <!-- 메인 페이지 이미지 영역 -->
        <div class="body">
            <br><br>

            <table class="board-body">
                <td class="body-r">
                    <div class="delete">
                        <b style="font-size:24px;">찜한매물</b>
                        <hr>
                           <c:forEach var="zi" items="${ list }">
	                            <div class="thumbnail" align="center">
	                               <a href="detail.ho?hno=${ zi.houseNo }"> 
	                               <img src="${ zi.thumbnail }" width="200px" height="150px">
	                               <p> No. ${ zi.houseNo } </p>
	                               <p>${ zi.title }</p>
	                               </a>
	                            </div>
                           </c:forEach>
                           
                            <br><br>
                    </div>
                </td>
            </table>
        </div>
    </div>
    
    </div>
    
    <!-- 푸터바 -->
    <jsp:include page="../../common/footer.jsp" />

</div>
</body>
</html>