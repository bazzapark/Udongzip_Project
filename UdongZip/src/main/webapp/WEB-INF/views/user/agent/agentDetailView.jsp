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
<link rel="stylesheet" href="resources/css/user/agentDetailView.css">

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>

  <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

    <div id="content-area">

      <!-- 업체 정보 -->
      <table class="table table table-borderless mb-5 agentDetailTable">
        <thead>
          <tr>
            <th scope="col">업체 정보</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">업체명</th>
            <td>KH공인중개사사무소</td>
            <td rowspan="10" class="col-6"><div class="container-fluid rounded-4 bg-light" id="landDetailMap">지도자리</div></td>
          </tr>
          <tr>
            <th scope="row">대표자명</th>
            <td>김대표</td>
          </tr>
          <tr>
            <th scope="row">연락처</th>
            <td>010-0010-0002</td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>kh@udong.com</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>서울 영등포구 선유동2로 57 이레빌딩 19, 20층</td>
          </tr>
        </tbody>
      </table>

      <!-- 업체 설명 -->
      <table class="table table table-borderless mb-5 mt-5 agentDetailTable">
        <thead>
          <tr>
            <th scope="col">상세 설명</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <div class="p-3 bg-light rounded-4" name="" id="">
			                ★ 특징 ★ <br>
			                ✔ 도보 1분 버스 정류장 가깝습니다. <br>
			                ✔ 도보 15분이면 당산역 도착합니다. <br>
			                ✔ 혼자 살기 좋은 풀옵션 원룸입니다. <br>
			                ✔ 화장실에 창문이 있어 환기하기 좋습니다. <br>
			                ✔ 인근에 식당, 카페, 편의점, 병원등 편의시설 다수 있습니다. <br>
              </div>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 상담 후기 -->
      <div class="listTitle ps-2 mb-3">상담 후기</div>
      <table class="table table mb-3 text-center" id="reviewTable">
        <thead class="border-top">
          <tr>
            <th class="col-1">번호</th>
            <th class="col-2">아이디</th>
            <th class="col-5">내용</th>
            <th class="col-2">만족도</th>
            <th class="col-2">작성일</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>user01</td>
            <td>친절하고 꼼꼼해요.</td>
            <td><img src="resources/images/houseDetailImages/like.png" alt=""></td>
            <td>2022-06-23</td>
          </tr>
          <tr>
            <td>1</td>
            <td>user02</td>
            <td>친절하고 꼼꼼해요.</td>
            <td><img src="resources/images/houseDetailImages/dislike.png" alt=""></td>
            <td>2022-06-23</td>
          </tr>
          <tr>
            <td>1</td>
            <td>user03</td>
            <td>친절하고 꼼꼼해요.</td>
            <td></td>
            <td>2022-06-23</td>
          </tr>
          <tr>
            <td>1</td>
            <td>user04</td>
            <td>친절하고 꼼꼼해요.</td>
            <td></td>
            <td>2022-06-23</td>
          </tr>
          <tr>
            <td>1</td>
            <td>user05</td>
            <td>친절하고 꼼꼼해요.</td>
            <td></td>
            <td>2022-06-23</td>
          </tr>
        </tbody>
      </table>
      <ul class="pagination pagination-sm mb-5 justify-content-center">
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

      <!-- 다른 매물 -->
      <div class="listTitle ps-2 mb-3">이 업체의 다른 매물</div>
      <div id="landImgList" class="carousel carousel-dark slide mb-5" data-bs-ride="carousel">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#landImgList" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#landImgList" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#landImgList" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
          <div class="carousel-item active" data-bs-interval="10000">
            <img src="resources/images/error.png" class="d-block" alt="...">
            <div class="carousel-caption d-none d-md-block">
              <h5>서울 당산동</h5>
              <p>Some representative placeholder content for the first slide.</p>
            </div>
          </div>
          <div class="carousel-item" data-bs-interval="2000">
            <img src="resources/images/error.png" class="d-block" alt="...">
            <div class="carousel-caption d-none d-md-block">
              <h5>서울 당산동</h5>
              <p>Some representative placeholder content for the second slide.</p>
            </div>
          </div>
          <div class="carousel-item">
            <img src="resources/images/error.png" class="d-block" alt="...">
            <div class="carousel-caption d-none d-md-block">
              <h5>서울 당산동</h5>
              <p>Some representative placeholder content for the third slide.</p>
            </div>
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#landImgList" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#landImgList" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>

    </div>

    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
  </div>
  
</body>
</html>