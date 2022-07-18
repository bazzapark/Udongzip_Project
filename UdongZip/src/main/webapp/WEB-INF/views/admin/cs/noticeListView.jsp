@@ -1,115 +1,116 @@
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
    <link rel="stylesheet" href="resources/css/admin/noticeListView.css">
</head>
<body>
    <!-- 전체를 감싸는 div -->
    <div class="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

        <!-- 콘텐트 영역 -->
        <div class="content-wrap">

            <h1>공지사항 목록</h1>
            <hr>
            <br>

            <!-- 게시글 관련 영역 -->
            <div id="noticelist-area">
                <!-- 글 삭제 / 글 작성 -->
                <form id="" action="delete.no" method="GET">
                    <div class="admin-btn">
                        <a class="btn btn-secondary" style="float:right;" href="enrollForm.no">글쓰기</a>
                        <button type="submit" class="btn btn-outline-danger delete-btn">삭제하기</button>
                        <br><br>
                    </div>

                    <!-- 공지사항 목록 -->
                    <table class="table table-list" id="notice-list">
                        <thead align="center">
                        <tr>
                            <th style="width: 5%;"><input type="checkbox" id="all_check"></th>
                            <th style="width: 10%;">No.</th>
                            <th style="width: 45%;">제목</th>
                            <th style="width: 30%;">작성일</th>
                            <th style="width: 10%">활성화</th>
                        </tr>
                        </thead>
                        <tbody align="center">
	                        <c:forEach var="n" items="${ list }">
		                        <tr>
		                            <td><input type="checkbox" class="each_check" name="delList" value="${ n.noticeNo }"></td>
		                            <td class="nno">${ n.noticeNo }</td>
		                            <td>${ n.title }</td>
		                            <td>${ n.createDate }</td>
		                            <td>${ n.status }</td>
		                        </tr>
	               			</c:forEach>
                        </tbody>
                    </table>
                </form>
            </div>   


            <br><br>

            <!-- 게시글 클릭 시 -->
            <script>
                $(function() {
    
                    $("#notice-list>tbody>tr>td").not(":first-child").click(function(){
                    $(document).on("click", "#notice-list>tbody>tr>td:not(:first-child)", function(){
                    	
    
                        location.href = "updateForm.no?nno=" + $(this).children(".nno").eq(0).text();
                        location.href = "updateForm.no?nno=" + $(this).parents().children(".nno").eq(0).text();
                    });
                });

                // 전체 선택 체크박스 클릭 시 실행 함수
                $("#all_check").click(function() {

                    if($(this).is(":checked")) { // 전체 선택 체크박스가 체크가 되었다면

                        $(".each_check").prop("checked", true); // 모든 개별 선택 체크박스 체크

                    } else { // 체크가 풀렸다면

                        $(".each_check").prop("checked", false); // 모든 개별 선택 체크박스 해제

                    }

                });

                // 개별 선택 체크박스 클릭 시 실행 함수
                $(".each_check").click(function() {

                    if($(".each_check:checked").length == $(".each_check").length) { // 체크된 개별 선택 체크박스의 수가 전체 체크박수의 수와 같다면

                        $("#all_check").prop("checked", true); // 전체 선택 체크박스 체크

                    } else { // 아니라면

                        $("#all_check").prop("checked", false); // 전체 선택 체크박스 해제

                    }

                });
            </script>
            
        </div>
		<jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
    </div>
    
</body>
</html>