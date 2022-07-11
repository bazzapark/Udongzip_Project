<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
    <!-- css -->
    <link rel="stylesheet" href="resources/css/user/agentInquiryDetailView.css">
</head>
<body>
    <div id="wrap">

        <jsp:include page="../../common/header.jsp" />

        <div id="content-area">

            <h1 align="center">1:1문의</h1>
            <br><br>

            <div id="detail-area">
            	<form action="delete.in" method="post">
            		<input type="hidden" name="inquiryNo" value="${ inquiry.inquiryNo }">
	                <table id="inquiry-detail-table">
	                    <tbody>
	                        <tr>
	                            <th height="50px">문의 번호</th>
	                            <td width="150px">${ inquiry.inquiryNo }</td>
	                            <th>카테고리</th>
	                            <td width="150px">${ inquiry.category }</td>
	                            <th>작성일</th>
	                            <td width="150px">${ inquiry.createDate }</td>
	                        </tr>
	                        <tr>
	                            <th height="50px">제목</th>
	                            <td colspan="5">${ inquiry.title }</td>
	                        </tr>
	                        <tr>
	                            <th height="300px">문의 내용</th>
	                            <td colspan="5">
	                                <textarea class="inquiry-content" readonly disabled>${ inquiry.content }</textarea>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th height="300px">답변 내용</th>
	                            <td colspan="5">
	                            	<c:choose>
	                            		<c:when test="${ empty inquiry.answerContent }">
	                            			답변이 등록되지 않았습니다.
	                            		</c:when>
	                            		<c:otherwise>
	                            			<textarea class="inquiry-content" readonly disabled>${ inquiry.answerContent }</textarea>
	                            		</c:otherwise>
	                            	</c:choose>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th height="50px">답변일</th>
	                            <td colspan="5">${ inquiry.answerDate }</td>
	                        </tr>
	                    </tbody>
	                </table>
	
	                <div class="btn-area">
	                    <button type="button" class="button back-btn" onclick="history.back()">뒤로가기</button>
	                    <button type="submit" class="button delete-btn">삭제하기</button>
	                </div>
                </form>

            </div>

        </div>

        <jsp:include page="../../common/footer.jsp" />

    </div>
</body>
</html>