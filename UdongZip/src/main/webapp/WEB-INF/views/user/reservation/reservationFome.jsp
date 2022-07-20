<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&display=swap" rel="stylesheet">
    
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

        #enrollForm>table {width:100%;}
        #enrollForm>table * {margin:5px;}
    </style>
</head>

<body>

    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br><br><br><br>
        <div class="innerOuter">
            <h2>리뷰 작성</h2>
            <br>

            <form id="enrollForm" method="post" action="insertReview.bo">
             <input type="hidden" id="memberNo" value="${ loginUser.memberNo }" name="memberNo">
             <input type="hidden" id="agentNo" value="${ agentNo }" name="agentNo">
                <table algin="center">
                    <tr>
                        <th><label for="reservationNo">예약번호</label></th>
                        <td><input type="text" id="reservationNo" class="form-control" value="${ reservationNo }" name="reservationNo" readonly></td>
                       
                        <th><label for="agentNo">대상업체</label></th>
                        <td><input type="text" id="agentName" class="form-control" value="${ agentName }" name="agentName" readonly></td>
                    </tr>
                    
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td colspan="3"><textarea id="content" class="form-control" rows="10" style="resize:none;" name="content"></textarea></td>
                    </tr>
                    <tr>
                        <th><label for="satisfied">만족도</label></th>
                        <td colspan="3">
                            
                                <input class="form-check-input" type="radio" name="satisfied" id="satisfied" value="만족" checked>
                                <label class="form-check-label" for="">
                                                                             만족
                                </label>
                            
                                <input class="form-check-input" type="radio" name="satisfied" id="satisfied" value="불만족">
                                <label class="form-check-label" for="">
                                                                             불만족
                                </label>
                        </td>
                    </tr>

                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <a class="btn btn-secondary"  href="reservationlist.bo">이전</a>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <jsp:include page="../../common/footer.jsp" />
</body>
</html>