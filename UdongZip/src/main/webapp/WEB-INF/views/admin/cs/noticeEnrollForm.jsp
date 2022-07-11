<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>우동집 | 우리동네집 모아보기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="resources/css/admin/noticeEnrollForm.css">
</head>
<body>
    <!-- 전체 영역 -->
    <div class="wrap">
    	  <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

        <!-- 공지내용 영역 -->
        <div class="enroll-wrap">

            <h1>공지사항 등록</h1>
            <hr>
            <br>

            <div class="enroll-area" >
                <form id="enrollForm" method="post" action="insert.no">
                    <table class="enroll-table">
                        <tr>
                            <th><label for="title">제목</label></th>
                            <td><input type="text" id="title" class="form-control" value="제목" name="title" required></td>
                        </tr>
                        <tr>
                            <th><label for="content">내용</label></th>
                            <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="content" required>내용</textarea></td>
                        </tr>
                    </table>
                    <br>

                    <div align="center">
                        <button type="submit" class="btn btn-primary">등록하기</button>
                        <button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
                    </div>
                </form>
            </div>

        </div>
	  <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->

    </div>
    
</body>
</html>