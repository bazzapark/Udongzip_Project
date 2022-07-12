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
    <link rel="stylesheet" href="resources/css/admin/inquiryListView.css">
</head>
<body>
    <!-- 전체를 감싸는 div -->
    <div class="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

        <!-- 콘텐트 영역 -->
        <div class="content-wrap">

            <h1>1 : 1 문의 목록</h1>
            <hr>
            <br>

            <!-- 게시글 관련 영역 -->
            <div id="inquirylist-area">

                <!-- 공지사항 목록 -->
                <table class="table table-list" id="inquiry-list">
                    <thead align="center">
                    <tr>
                        <th>No.</th>
                        <th>회원 번호</th>
                        <th>업체 번호</th>
                        <th>문의 분류</th>
                        <th>작성일</th>
                        <th>답변일</th>
                        <th>활성화</th>
                    </tr>
                    </thead>
                    <tbody align="center">
	                    <c:forEach var="i" items="${ list }">
		                    <tr>
		                        <td>${ i.inquiryNo }</td>
		                        <td>${ i.memberNo }</td>
		                        <td>${ i.agentNo }</td>
		                        <td>${ i.category }</td>
		                        <td>${ i.createDate }</td>
		                        <td>${ i.answerDate }</td>
		                        <td>${ i.status }</td>
		                    </tr>
	                	</c:forEach>
                    </tbody>
                </table>
            </div>   


            <br><br>
            
        </div>
    </div>

    <!-- 문의 클릭 시 모달 -->
    <div class="modal" id="inquiry-modal" style="overflow: scroll;">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header" >
                    <button type="button" class="btn btn-outline-secondary btn-sm modal-close">&times;</button>
                </div>

                <form action="" method="post">
                	<input type="hidden" name="inquiryNo">
	                    <div class="modal-body">
	                        <table class="table">
	                            <tr>
	                                <th>문의분류</th>
	                                <td id="category"></td>
	                                <th>작성일</th>
	                                <td id="createDate"></td>
	                            </tr>
	                            <tr>
	                                <th>문의 제목</th>
	                                <td colspan="3" id="title"></td>
	                            </tr>
	                            <tr>
	                                <th>문의 내용</th>
	                                <td colspan="3" style="height:100px">
	                                    <textarea id="content" name="content" cols="30" rows="10" style="resize:none;"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>답변 내용</th>
	                                <td colspan="3" style="height:100px">
	                                    <textarea id="answerContent" name="answerContent" cols="30" rows="10" style="resize:none;"></textarea>
	                                </td>
	                            </tr>
	                        </table>
	
	                        <div class="modal-footer">
	                            <button type="submit" class="btn btn-outline-dark">답변하기</button>
	                        </div>
	                    </div>
                </form>

            </div>
        </div>
		<jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
    </div>

    <script>
        $(function() {


            // inquiry-table의 tbody의 tr의 td 중 첫번째 자식 td를 제외한 모든 td 클릭 시 함수
            // 체크박스 선택 시에도 모달창이 뜨는 현상을 방지하기 위해서 제외시키기 위한 선택자
            $("#inquiry-list>tbody>tr>td").not(":first-child").click(function(){

                $("#inquiry-modal").show(); // 모달 창 띄우기

            });

            // 모달 닫기 버튼 클릭 시 함수
            $(".modal-close").click(function() {

                $("#inquiry-modal").hide(); // 모달 닫기

            });
        });
    </script>
    
    <script>
	    $(function() {
	       
	       // 업체 회원 상세 조회 모달창 출력
	       $("#inquiry-list>tbody").on("click", "tr", function() {
	          $.ajax({
	             url: "admindetail.in",
	             data: {inquiryNo: $(this).children().eq(0).text()},
	             success: function(inquiry) {
	                $("#category").text(inquiry.category);
	                $("#createDate").text(inquiry.createDate);
	                $("#title").text(inquiry.title);
	                $("#content").text(inquiry.content);
	                $("#answerContent").text(inquiry.answerContent);
	                
	             },
	             error: function() {
	                console.log("관리자 1:1문의 상세 조회 ajax 실패");
	             }
	          })
	       })
	    })
    
    </script>
    
</body>
</html>