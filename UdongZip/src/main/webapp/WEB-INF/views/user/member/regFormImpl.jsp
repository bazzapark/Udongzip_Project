<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&display=swap" rel="stylesheet">

<style>

     body {
      height : 500px;
      font-size: small; 
      font-family: 'Nanum Gothic', sans-serif; /* 깔끔 폰트 */
      width: 35%;
      margin: auto;
    }

    form {
      border: 2px solid rgb(231, 231, 231);
      border-radius: 20px;
      padding: 50px;
      margin-top: 100px;
      position: relative;
      left: 90%;
    }
    
    /**** 공통 - a 태그 ****/
    a {
      text-decoration: none;
    }
    /***** 공통 스타일 끝 *****/

</style>
</head>
<body>

    <!-- 메뉴바 -->
    <jsp:include page="../../common/header.jsp" />

   

<form action="enrollForm.me" method="get" id="form1" >
    <h1 align="center">우동집 회원가입 약관</h1>
    <br><br>
	<h3>약관선택</h3>
	<br>
	<p>
		<label>
			<input type="checkbox" name="all" id="all">
			전체선택
		</label>
	</p>
    
	<p>
		<label>
			<input type="checkbox" name="c1" id="c1" data-bs-toggle="modal" data-bs-target="#c11"> 
			우동집
			이용약관 동의(필수)
		</label>
	</p>
    <div class="modal fade" id="c11" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="">이용약관</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <pre>
		<br>
    제 1 조 (목적)

    이 약관은 우동집 주식회사 ("회사" 또는 "우동집")가 
    제공하는 우동집 및 우동집 관련 제반 서비스의 
    이용과 관련하여 회사와 회원과의 권리, 
    의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.


    제 2 조 (정의)

    이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
  ①"서비스"라 함은 구현되는 단말기
   (PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 
   "회원"이 이용할 수 있는 우동집 및 우동집 관련 제반 서비스를 의미합니다.
  ②"회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 
  "회사"와 이용계약을 체결하고 
  "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다.
  ③"아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 
  "회원"이 정하고 
  "회사"가 승인하는 문자와 숫자의 조합을 의미합니다.
  ④"비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 
  "회원"임을 확인하고 비밀보호를 위해 "회원" 
    자신이 정한 문자 또는 숫자의 조합을 의미합니다.
  ⑤"유료서비스"라 함은 "회사"가 유료로 제공하는 각종 온라인디지털콘텐츠
  (각종 정보콘텐츠, VOD, 
   아이템 기타 유료콘텐츠를 포함) 
   및 제반 서비스를 의미합니다.
  ⑥"포인트"라 함은 서비스의 효율적 이용을 위해
   회사가 임의로 책정 또는 지급, 
  조정할 수 있는 재산적 가치가 없는 "서비스" 
  상의 가상 데이터를 의미합니다.
  ⑦"게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 
  "서비스상"에게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 
  정보 형태의 글, 사진, 동영상 및 
  각종 파일과 링크 등을 의미합니다. 
    </pre>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
    </div>
    </div>
    </div>

	<p>
		<label>
			<input type="checkbox" name="c2" id="c2" data-bs-toggle="modal" data-bs-target="#c22"> 
			개인정보 수집 및 이용에 대한 안내(필수)
		</label>
	</p>
    <div class="modal fade" id="c22" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="">이용약관</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <pre>
			<br>
    정보통신망법 규정에 따라 우동집에 회원가입 신청하시는 분께 
    수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 
    개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 
    후 동의하여 주시기 바랍니다.

  1. 수집하는 개인정보

    이용자는 회원가입을 하지 않아도 정보 검색, 
    뉴스 보기 등 대부분의 우동집 서비스를 
    회원과 동일하게 이용할 수 있습니다. 
    이용자가 메일, 캘린더, 카페, 블로그 등과 같이 
    개인화 혹은 회원제 서비스를 
    이용하기 위해 회원가입을 할 경우, 
    우동집는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
			</pre>
				<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
        </div>
        </div>
        </div>


	<p>
		<label>
			<input type="checkbox" name="c3" id="c3" data-bs-toggle="modal" data-bs-target="#c33"> 
			위치정보 이용약관 동의(선택)
		</label>
	</p>
    <div class="modal fade" id="c33" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="">이용약관</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <pre>
			<br>
    위치정보 이용약관에 동의하시면, 위치를 활용한 
    광고 정보 수신 등을 포함하는 
    네이버 위치기반 서비스를 이용할 수 있습니다.


    제 1 조 (목적)
    이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치정보사업 
    또는 위치기반서비스사업과 관련하여 회사와 개인위치정보주체와의 권리, 
    의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.


    제 2 조 (약관 외 준칙)
    이 약관에 명시되지 않은 사항은 위치정보의 보호 및 
    이용 등에 관한 법률, 
    정보통신망 이용촉진 및 정보보호 등에 관한 법률, 
    전기통신기본법, 전기통신사업법 등 
    관계법령과 회사의 이용약관 및 개인정보취급방침, 
    회사가 별도로 정한 지침 등에 의합니다.
	
        </pre>
          <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
        </div>
        </div>
        </div>


		  <div class="modal-footer">
	        <input class = "btn btn-secondary" type="submit" value="동의">
	        <input class="btn btn-danger" type="reset" value="비동의" onclick = "window.location='http://localhost:8006/udongzip'">
	      </div>
</form>

<script>

	$(function() {
		$("#loginandEnroll-btn").attr("disabled", true);
	});

	var doc = document; 
	var form1 = doc.getElementById('form1'); 
	var inputs = form1.getElementsByTagName('INPUT'); 
	var form1_data = {
		"c1": false, 
		"c2": false, 
		"c3": true
	}; 

	var c1 = doc.getElementById('c1'); 
	var c2 = doc.getElementById('c2'); 
	var c3 = doc.getElementById('c3'); 

	function checkboxListener() {
		form1_data[this.name] = this.checked; 

		if(this.checked) {
			// submit 할때 체크하지 않아 색이 변한 font 를 다시 원래 색으로 바꾸는 부분. 
			this.parentNode.style.color = "#000"; 
		}
	}


		c1.onclick = c2.onclick = c3.onclick = checkboxListener; 

		var all = doc.getElementById('all'); 

		all.onclick = function() {
			if (this.checked) {
				setCheckbox(form1_data, true); 
			} else {
				setCheckbox(form1_data, false); 
			}
		}; 


		function setCheckbox(obj, state) {
			for (var x in obj) {
				obj[x] = state; 

				for(var i = 0; i < inputs.length; i++) {
					if(inputs[i].type == "checkbox") {
						inputs[i].checked = state; 
					}
				}

			}
		}


	form1.onsubmit = function(e) {
		e.preventDefault(); // 서브밋 될때 화면이 깜빡이지 않게 방지

		if ( !form1_data['c1'] ) {
			alert('우동집 이용약관 동의를 하지 않았습니다'); 
			c1.parentNode.style.color = 'red'; 
			return false; 
		}

		if ( !form1_data['c2'] ) {
			alert('개인정보 수집 및 이용에 대한 안내를 선택하지 않았습니다.'); 
			return false; 
		}

		this.submit(); 
	}; 
</script>

</body>
</html>