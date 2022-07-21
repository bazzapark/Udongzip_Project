<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
		
<!-- css -->
<link rel="stylesheet" href="resources/css/user/chatRoomListView.css">

    <title>실시간 채팅 문의</title>
    <style>

    </style>
</head>

<script type="text/javascript">
	var userNo; // 개인회원 및 업체회원 채팅방 목록 설정을 위한 변수 설정
	var identifier = ""; // 로그인한 식별자 확인위한 변수 설정
	var userId = ""; // 개인회원 및 업체회원 따로 뺴서 쓰기 위세 변수 설정
</script>

<body>

<c:choose>
	<c:when test="${ loginUser.identifier eq 'member' }"> 
	<!-- 로그인한 식별자가 개인회원이면 -->
	<!-- 로그인 정보들을 통해 메세지를 주고받을때 송신자를 알 수 있고 -->
	<!-- 여러가지 결과값을 뽑을 수 있음 / 변수는 젼역변수로 뺴서 담아둠 -->
		<script>
			userNo = ${ loginUser.memberNo }; // 개인회원로그인시 보여질 채팅방 목록 설정
			identifier = "MEMBER_NO";  // 개인회원로그인시 로그인한 식별자
			userId = "${ loginUser.memberId }"; 
		</script>
	</c:when>
	<c:otherwise>
		<script>
			userNo = ${ loginUser.agentNo }; // 업체회원로그인시 보여질 채팅방 목록 설정
			identifier = "AGENT_NO"; // 로그인한 식별자
			userId = "${ loginUser.agentId }";	
		</script>
	</c:otherwise>
</c:choose>

	<div id="wrap">
	
	<jsp:include page="../../common/header.jsp" />
	
	<div id="content-area">

	<div id="ChatTitle-div" align="center"><span id="ChatTitle">실시간 채팅 문의</span></div><br>
	
    <div class="wrap" style="border: 2px solid lightgray;">
    	
        <div id="header">
            <div id="header_1"><b>채팅목록</b></div>
            <div id="header_2">
            <c:choose>
            	<c:when test="${ loginUser.identifier eq 'member' }">
            		<p id="userTitle"></p>
            	</c:when>
            	<c:otherwise>
            		<p id="userTitle"></p>
            	</c:otherwise>
            </c:choose>
            </div>
        </div>

        <div id="content">
        
          		  <div id="content_1" style="overflow:auto">
          		  	<ul id="chview">
          		  	
          		  	</ul>
          		  </div>
          
            <div id="content_2" style="overflow:auto; color:#595959;">
				
            </div>
			
        </div>
        <div id="footer">
            <div id="footer_1"></div>
            <div id="footer_2">

              <input type="text" id="message" placeholder="채팅방을 선택해주세요." disabled />

            </div>
      		
            <div id="footer_3"><input type="button" id="sendBtn" name="sendBtn1" value="전송" /></div>
     
        </div>
        
    </div>
    
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    </div>
</body>

<script type="text/javascript">

	$(function(){
		test1();
		setInterval(function(){test1()},1000);
	});
	
	
	function test1(){
	
	$.ajax({ // 채팅방보여주는 ajax
		url : "listview.ch",
		data : {userNo : userNo, identifier : identifier, userId : userId}, // userNo키값에 로그인한 개인/업체 회원 userId 담기
		type : "post",
		success : function(result){
			
			$("#chview").html(""); // 한번씩 비워주는 구문
			
			var resultStr = "";
			
			for(var i in result){ // result가 순차적으로 i만큼 반복
				resultStr += "<li>" 
						  + "<input type='hidden' value='" + result[i].chatRoomNo + "'>";
						  // input hidden 으로 result에 담긴값 i만큼반복하면서 result에 담겨져있는 chatRoomNo정보 뽑아오기
						  // 이유는 이따가 chatRoomNo 기준으로 안에있는 채팅내역등 여러가지 정보를 뽑기위해 히든으로 미리 작성
						  
						 if(identifier == "MEMBER_NO"){ 
							 // 식별자가 문자열 MEMBER_NO면 상대방 agent이름이 보이게 설정
							 // (개인회원/업체회원 로그인 후 채팅방목록에 보여질 이름은 각자 반대 이름으로 설정)
							 
							resultStr +=  "<span class='nameTitle'>" + result[i].agentName + "</span>" ;

							if(result[i].unReadCount != 0) {
								resultStr +="<div class='unread-check'>"+ result[i].unReadCount + "</div>";
							}
							  
							resultStr += "</li>";
						 }
						  // Controller에서 DB까지 찍고온 unReadCount(정수) 추가로 읽음 안읽음 표시
						  // result[i]만큼 반복해서  식별자에 맞게 각 이름이 찍힘
						
						else{
							resultStr +=  "<span class='nameTitle'>" + result[i].memberName + "</span>" ;

							if(result[i].unReadCount != 0) {
								resultStr +="<div class='unread-check'>"+ result[i].unReadCount + "</div>";
							}
							  
							resultStr += "</li>";
						}
						  //console.log(result[i]);
			}
			$("#chview").append(resultStr);
			// #chview에 결과값 작성
			
		},
		error : function(){
			console.log("통신실패");
		}
	});
	};
		
	 var roomNo = ""; // 이따 메세지 전송할떄 이벤트 걸린 방번호 순차적으로 넣어두기위한 변수 설정
	
	$(document).on("click", '#chview li', function(){ // 채팅방목록들중 클릭 시 채팅내역보여주는 함수(ajax)
	// 첫번쨰에 이벤트선언을 했기때문에 첫번쨰대상으로 다시 이벤트를 걸수없다 
	// 동적으로 생성된 대상으로 다시 이벤트를 걸려면 document 자체에 적용
	
		$("#message").removeAttr("disabled"); 
		// 채팅방누르고 첫 화면에서 아무 채팅방목록없이 바로 채팅하면 연결끊김
		// 고로 처음에 disabled로 막고 방목록중 아무거나 클릭하면 disabled 지워주는 로직
		
		$("#message").attr("placeholder", "내용을 입력하세요.");
		// 채팅방 클릭시 placehorder 변경내용
		
		// console.log($(this).find("input[type=hidden]").val());
		
		roomNo = $(this).find("input[type=hidden]").val(); // (sendmessage)에서 메세지 전송할떄 이벤트 걸린 방번호 순차적으로 넣어두기위한 변수
		
		$("#userTitle").html(""); 
		// 채팅방 목록클릭시 해당 채팅대화내용이 userTitle에 띄우기위한 로직
		// 클릭이벤트가 계속 일어나면 연속으로 찍히기 때문에 지워주는 구문 추가
		userTitleName = $(this).children(".nameTitle").text();
		// 채팅방 목록클릭시 해당 채팅대화내용이 userTitle에 띄우기위한 로직
		// this 이벤트가 일어났을시 chatview에 text가 찍히는걸 담는 변수
		$("#userTitle").text(userTitleName);
		// 채팅방 목록클릭시 해당 채팅대화내용이 userTitle에 띄우기위한 로직
		// #userTitle에 해당 이벤트 일어났을때 담은 변수 text로 추가
		
		sendMessage("ENTER_CHAT");
		
		$.ajax({ // 채팅방 목록 클릭시 해당되는 대화 내용 불러오기 위한 ajax
		url : "listdetail.ch",
		type : "post",
		data : { chatRoomNo : $(this).find("input[type=hidden]").val(), userId : userId },
		// chatRoomNo에 지금 이벤트가걸린 input[type=hidden]을 찾아서 밸류값을 넣겠다. / userId 도 같이 넘김
		success : function(result){
			
			//console.log(result[0].content);
			$("#content_2").html("");
			// 비워주는역할 전에 있는 채팅내역 목록들을 지워줌
			
			console.log(result);
			
			var resultStr = "";
			
			for(var i in result){ // 반복문으로 result에 담긴 내용물만 i인덱스만큼 뽑기
	
					 if(result[i].senderId == userId){
						 // 내용 불러올때 송신자가 당사자라면 메세지 내역을 오른쪽으로 옮겨서 보여줌(카톡참고)
							resultStr += "<div align='right' class='meid' style='left:350px; text-align:left; background-color:#ffffcc; border-radius: 15px 15px 0px 15px;'>"+ result[i].content + "</div>"
									  +"<div align='right' class='time'>" + result[i].chatTime + "</div>";
						}
						else{
							resultStr += "<div class='meid1' style='border-radius: 15px 15px 15px 0px;'>"+ result[i].content + "</div>"
							+"<div class='time'>" + result[i].chatTime + "</div>";
						} 
			}
			
			$("#content_2").append(resultStr);
			
			$('#content_2').scrollTop($('#content_2')[0].scrollHeight);
			// 채팅방 스크롤 자동으로 내려가게 해주는 로직
			
			test1();
			// setInterval(function(){test1()},1000); 
			// 함수 호출해서 안읽은 메세지 1초마다 setInterval로 최신화
			
			// $("#content_2").append(resultStr);
		
			//console.log($(".meid").text());
			//console.log(me);
			// $("#content_2").append(JSON.stringify(result));
			// JSON.stringify() JSON을 객체화시켜서 출력해주는 메소드
			// JSON.stringify() 없이 그냥 쓰면 object ojbect 발생
		},
		error : function(){
			console.log("통신실패");
		}
	 });
	});
	 
	$("#sendBtn").click(function() { // 전송버튼 클릭시 sendmessage호출
		if($("#message").val().length > 0){ // 빈 공백 전송 시 연결끊김 방지 조건
			sendMessage($("#message").val());
			$('#message').val('');
		}else{
			alert('내용을 입력해야함');
		}
	});
	
	$("#message").on("keyup",function(e){ // 전송버튼 누를필요없이 Enter키 누르면 전송해지는구문
		 if(e.key == "Enter"){
			 if($("#message").val().length > 0){ // 빈 공백 전송 시 연결끊김 방지 조건
			 sendMessage($("#message").val());
			$("#message").val("");
		} else {
			alert('내용을 입력해야함');
			}
		  }		
		});	
	
	
	let sock = new SockJS("http://192.168.40.25:8006/udongzip/chatting.do"); 
	//  SockJS객체를 생성하고, 그 객체가 메세지를 받고, 연결이 끊길 때 각각 어떤 함수를 호출할건지 세팅해주는 과정이다. 
	//	constructor의 매개변수에는 자신의 url(IP)과 Handler를 맵핑한 주소 적기
	//  핸들러로 보내주는 역할 
	
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	// 메시지 전송
	function sendMessage(msg) { // 방번호, senderId, 메세지내용 JSON으로 묶어서 핸들러로보내기
		
		/* 1. jsp에서 sock.send로 json 형식 데이터 전송
		2. 핸들러 handleTextMessage메소드에서 전송된 json 데이터 chatMessage VO 클래스로 파싱
		3. 서비스단 insertChatMessage 메소드 호출해서 DB에 저장
		4. 전체 세션에게 메시지, 송신자ID 전송
		5. jsp에서 sock.onMessage로 받아서 송신/수신 구분해서 화면에 뿌려주기
		
		json으로 묶어서
		sock.send()로 보내고
		핸들러에서 chatMessage 객체로 파싱해서
		content만 뽑아내서 전체 세션한테 메시지 전송하고
		chatMessage 객체는 DB에 넣기
		*/
		
		//sock.send($("#message").val());
		
		const data = {
				// 메세지 전송에 필요한 정보들 키 : 밸류로 보냄
				// 핸들러로 보내면 핸들러의 TextMessage 변수에 담김
				"chatRoomNo" : roomNo,
				"content" : msg,
				"senderId" : userId
		};
      console.log(data);
        let jsonData = JSON.stringify(data);
        console.log(jsonData);
        sock.send(jsonData);
        // json 형태로 보내서 핸들러에서 Vo개체로 파싱
        
        $('#content_2').scrollTop($('#content_2')[0].scrollHeight);
    	 // 채팅방 스크롤 자동으로 내려가게 해주는 로직
        
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		
		
		console.log(data);
		// 핸들러에서 senderId + ":" + content 로 넘어옴
		// 넘어올떈 문자열로 넘어옴 "user01 : asdfsadf"
		
		// split 배열로 만들어서 인덱스로 뽑아쓰기
		var dataList = data.split("^^");
		
		// console.log(dataList[0]); senderId
		// console.log(dataList[1]); content
		// console.log(userId);
		
		if(dataList[0] == userId){ // 핸들러에서 넘어온 senderId가 내 아이디면
			resultStr = "<div align='right' class='meid' style='left:350px; text-align:left; background-color:#ffffcc; border-radius: 15px 15px 0px 15px;'>"+ dataList[1] + "</div>"
			          + "<div align='right' class='time'>" + dataList[2] + "</div>";;
			// 카톡처럼 오른쪽으로 메세지를 보여줌 dataList[1] = content
		}
		else{
			resultStr = "<div class='meid1' style='border-radius: 15px 15px 15px 0px;'>"+ dataList[1] + "</div>"
			          + "<div class='time'>" + dataList[2] + "</div>";;
		} 
		 
		 $("#content_2").append(resultStr);
		 $('#content_2').scrollTop($('#content_2')[0].scrollHeight);
		 // 채팅방 스크롤 자동으로 내려가게 해주는 로직
		 
	 }
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#content_2").append("연결 끊김");
	}
</script>
</html>