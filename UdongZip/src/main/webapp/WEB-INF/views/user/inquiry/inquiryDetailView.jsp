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
            <h2>1:1 문의 내역</h2>
            <br>

            <table id="contentArea" algin="center" class="table">
                <tr>
                    <th width="100">작성일</th>
                    <td colspan="3">${ i.createDate }</td>
                </tr>
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ i.title }</td>
                </tr>
                <tr >
                    <th >문의 내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr style = "border-style : hidden!important;">
                    <td colspan="4"><p style="height:150px;">${ i.content }</p></td>
                </tr>
                <tr></tr>
                <tr>
                    <th width="100">답변일</th>
                    <td colspan="3">${ i.createDate }</td>
                </tr>
                <tr>
                    <th>문의 답변</th>
                    <td colspan="3"></td>
                </tr>
                <tr  style = "border-style : hidden!important;">
                    <td colspan="4"><p style="height:150px;">${ i.answerContent }</p></td>
                </tr>
            </table>
            <br>

            <div align="center">
                <a class="btn btn-secondary" style="float:right;" href="inquirylist.bo">확인</a>
            </div>
            <br><br>
        </div>
        <br><br>

    </div>
    
        <!-- 푸터바 -->
    <jsp:include page="../../common/footer.jsp" />
</body>
</html>