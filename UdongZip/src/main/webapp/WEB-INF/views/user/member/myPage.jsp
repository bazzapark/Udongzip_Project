<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>

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
        .content {
            background-color: white;
            width: 80%;
            margin: auto;
        }
        
        .innerOuter {
            border:1px solid lightgray;
            width: 600px;
            margin: auto;
            padding: 5% 10%;
            background-color: white;
        }
    </style>
</head>
<body>


    <jsp:include page="../../common/header.jsp" />

<div class="modal fade" id="outForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content">
<div class="modal-header">
  <h5 class="modal-title" id="">회원탈퇴</h5>
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>

<form action="delete.me" method="post">
<pre>회원탈퇴 하시겠습니까?

회원탈퇴와 동시에 서비스 이용내역 및 모든 데이터가 삭제 됩니다. 
이후 동일 계정으로 가입이 가능하지만 기록은 남아있지 않습니다.
            
그동안 우리동네집구하기를 이용해 주셔서 감사합니다.
앞으로 보다 나은 서비스를 제공할 수 있도록 노력하겠습니다.
</pre>
         <input type="hidden" name="memberNo" value="${ loginUser.memberNo }">
        <div align="center">
    <button type="submit" class="btn btn-primary">탈퇴하기</button>
    <br>
    </div>
  </form>
  
</div>
</div>
</div>

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2 style ="border-bottom: 3px solid #757070;">마이 페이지</h2>
            <br>

            <form action="update.me" method="post">
                <div class="form-group" style="width: 300px;">
                    <albel for="memberId">* 아이디 </albel > <br>
                    <input type="text" class="form-control" id="memberId" value="${ loginUser.memberId }" name="memberId" readonly> <br>

                    <label for="memberName">* 이름</label> <br>
                    <input type="text" class="form-control" id="memberName" value="${ loginUser.memberName }" name="memberName" readonly> <br>

                    <label for="memberPhone"> &nbsp; *휴대폰 </label> <br>
                    <input type="text" class="form-control" id="memberPhone" value="${ loginUser.memberPhone }" name="memberPhone" required> <br>

                    <label for="memberEmail"> &nbsp; *이메일 </label> <br>
                    <input type="text" class="form-control" id="memberEmail" value="${ loginUser.memberEmail }" name="memberEmail" requi
                    
                    red> <br>
                </div>
                <div class="btns" align="center">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#outForm">회원탈퇴</button>
                    <button type="submit" class="btn btn-primary">확인</button>
                </div>
            </form>
        </div>
        <br><br>
        <div class="innerOuter">
            <foem action="" method="post">
                <br><br>
                <h2 style ="border-bottom: 3px solid #757070;">비밀번호 변경</h2>
                <br>
                <div class="form-group" style="width: 300px;">
                    <label for="userPwd">* 현재비밀번호 : </label>
                    <input type="password" class="form-control" id="memberPwd" placeholder="현재 비밀번호 입력하세요." name="" required> <br>

                    <label for="wuserPwd">* 새비밀번호 : </label>
                    <input type="password" class="form-control" id="wmemberPwd" placeholder="변경할 비밀번호를 입력하세요." name="" required> <br>

                    <label for="wcheckPwd">* 새비밀번호 확인 : </label>
                    <input type="password" class="form-control" id="wcheckPwd" placeholder="비밀번호를 다시한번 입력하세요." required> <br>
                </div>

                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">변경하기</button>
                </div>
            </foem>
        </div>
    </div>

    <!-- 푸터바 -->
    <jsp:include page="../../common/footer.jsp" />

</body>
</html>