<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우동집 | 우리동네집 모아보기</title>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<!-- CSS파일 -->
<link rel="stylesheet" href="resources/css/admin/reportListView.css">

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>


  <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

    <!-- 리뷰 삭제 요청 상세조회 모달창 -->
    <div class="modal" tabindex="-1" id="removeDetailModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">리뷰 삭제 요청 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <table class="table align-middle">
              <tr>
                <th class="col-5">요청 번호</th>
                <td>1</td>
              </tr>
              <tr>
                <th>업체명</th>
                <td>일공인중개사사무소</td>
              </tr>
              <tr>
                <th>예약 번호</th>
                <td>15</td>
              </tr>
              <tr>
                <th>작성자</th>
                <td>user01</td>
              </tr>
              <tr>
                <th>만족도</th>
                <td><img src="dislike.png" alt=""></td>
              </tr>
              <tr>
                <th>리뷰 작성일</th>
                <td>2022-06-28</td>
              </tr>
              <tr>
                <th>삭제 요청일</th>
                <td>2022-06-28</td>
              </tr>
              <tr>
                <th>요청 사유</th>
                <td><textarea name="removeContent" id="removeContent" maxlength="30" readonly></textarea></td>
              </tr>
              <tr>
                <th>상태</th>
                <td></td>
              </tr>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-warning">반려</button>
            <button type="button" class="btn btn-danger">삭제</button>

          </div>
        </div>
      </div>
    </div>

    <div id="content-area">

      <!-- 리뷰 삭제 요청 전체 목록 -->
      <div id="removeListTitlebar">
        <div class="ps-2 mb-3 mt-5" id="removeListTitle">리뷰 삭제 요청</div>
        <button class="btn btn-link">삭제전</button>
      </div>
      <table class="table table mb-5 text-center table-hover" id="removeList">
        <thead class="border-top">
          <tr>
            <th class="col-1">번호</th>
            <th class="col-3">업체명</th>
            <th class="col-2">예약번호</th>
            <th class="col-2">작성자</th>
            <th class="col-1">만족도</th>
            <th class="col-2">삭제요청일</th>
            <th class="col-1">상태</th>
          </tr>
        </thead>
        <tbody>
          <tr data-bs-toggle="modal" data-bs-target="#removeDetailModal">
            <td>1</td>
            <td>일공인중개사사무소</td>
            <td>15</td>
            <td>user01</td>
            <td><img src="dislike.png" alt=""></td>
            <td>2022-06-28</td>
            <td></td>
          </tr>
          <tr data-bs-toggle="modal" data-bs-target="#removeDetailModal">
            <td>1</td>
            <td>일공인중개사사무소</td>
            <td>15</td>
            <td>user01</td>
            <td><img src="dislike.png" alt=""></td>
            <td>2022-06-28</td>
            <td></td>
          </tr>
          <tr data-bs-toggle="modal" data-bs-target="#removeDetailModal" class="table-secondary">
            <td>1</td>
            <td>일공인중개사사무소</td>
            <td>15</td>
            <td>user01</td>
            <td><img src="dislike.png" alt=""></td>
            <td>2022-06-28</td>
            <td>삭제</td>
          </tr>
          <tr data-bs-toggle="modal" data-bs-target="#removeDetailModal" class="table-warning">
            <td>1</td>
            <td>일공인중개사사무소</td>
            <td>15</td>
            <td>user01</td>
            <td><img src="dislike.png" alt=""></td>
            <td>2022-06-28</td>
            <td>반려</td>
          </tr>
          <tr data-bs-toggle="modal" data-bs-target="#removeDetailModal">
            <td>1</td>
            <td>일공인중개사사무소</td>
            <td>15</td>
            <td>user01</td>
            <td><img src="dislike.png" alt=""></td>
            <td>2022-06-28</td>
            <td></td>
          </tr>
        </tbody>
      </table>
      <ul class="pagination mb-5 justify-content-center">
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>

    </div>

    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
  </div>
  
</body>
</html>