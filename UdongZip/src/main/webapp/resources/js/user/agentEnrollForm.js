	var idValidate = false;
	var pwdValidate = false;
	var pwdValidate2 = false;
	var emailValidate = false;
	var runningTimer;
	
	$(function() {
                
        // id 유효성 검사
        $("#agentId").on("keyup", function() {
            
            var regExp = /^[a-z][a-z\d]{3,17}$/;

            if(!regExp.test($(this).val())) {

                $("#id-validate").removeClass("possible")
                .addClass("impossible")
                .html("유효하지 않은 형식입니다.<br>영어 소문자, 숫자로만 (4~18글자)");
                
                $("#idCheck").css("display", "none");
                
            } else {
                
                $("#id-validate").removeClass("impossible")
                .addClass("possible")
                .html("가능한 형식의 ID입니다. 중복 확인을 해주세요.");
                
                $("#idCheck").css("display", "block");
                
            }
            
    });
    
    // pwd 유효성 검사
    $("#agentPwd").on("keyup", function() {
        
        var regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

        if(!regExp.test($(this).val())) {

            $("#pwd-validate").removeClass("possible")
            .addClass("impossible")
            .html("유효하지 않은 형식입니다.<br>대소문자, 숫자, 특수문자(!@#$%^) 조합 (8글자 이상)");
            pwdValidate = false;
            
            
        } else {
            
            $("#pwd-validate").removeClass("impossible")
            .addClass("possible")
            .html("안전한 비밀번호입니다.");
            pwdValidate = true;
            
        }
        
        if($("#checkPwd").val() == $("#agentPwd").val() &&  $("#agentPwd").val().length > 0) {

			$("#check-validate").removeClass("impossible")
            .addClass("possible")
            .html("비밀번호가 일치합니다.");
            pwdValidate2 = true;

        } else {
            
            $("#check-validate").removeClass("possible")
            .addClass("impossible")
            .html("비밀번호가 일치하지 않습니다.");
            pwdValidate2 = false;
            
        }
        
    });
    
    // pwd 일치 검사
    $("#checkPwd").on("keyup", function() {
    
    	if($(this).val() == $("#agentPwd").val() &&  $("#agentPwd").val().length > 0) {

			$("#check-validate").removeClass("impossible")
            .addClass("possible")
            .html("비밀번호가 일치합니다.");
            pwdValidate2 = true;

        } else {
            
            $("#check-validate").removeClass("possible")
            .addClass("impossible")
            .html("비밀번호가 일치하지 않습니다.");
            pwdValidate2 = false;
            
        }
        
    });

    // 이미지 영역 클릭 시 이벤트
    $(".previewer").on("click", function() {

        if($(this).attr("src") == undefined | $(this).attr("src") == "") {

            onClickUpload(this);

        } else {

            $(this).attr("src", "");

        }

    });

    $(document).on("change", ".file-input", function() { // file-input의 값이 바뀌면
    
    	var maxSize = 10 * 1024 * 1024;
    	var fileSize = this.files[0].size;
			
		if(fileSize > maxSize) {
		
			alert("10MB 이하의 이미지 파일만 등록 가능합니다.");
			$(this).val("");
			
		} else {
			
			 // 해당 input의 형제 중 img 태그를 가져와서
			 var imgEl = $(this).prev();

        	setPreview(this, imgEl); // 프리뷰 등록 함수에 같이 전달
		
		}

    });
    
    // id중복 체크
    $("#idCheck").on("click", function() {
    
        $.ajax({
            url : "idCheck.ag",
            data : { agentId : $("#agentId").val() },
            success : function(result) {
                
                if(result == "NNNNY") {
                    
                    alert("사용 가능한 ID입니다.");
                    idValidate = true;
                    
                } else {
                    alert("중복된 ID입니다. 다른 ID를 사용해주세요.");
                    $("#agentId").val("");
                    $("#agentId").focus();
                    idValidate = false;
                }
                
            },
            error : function() {
                console.log("통신 실패");	
            },
        });
        
    });
    
    $(".confirm-btn").on("click", function() {
    
    	if($("#code").val() == authCode) {
    	
    		alert("인증되었습니다.");
    		emailValidate = true;
    		$("#email-modal").hide();
    		clearInterval(runningTimer);
    	
    	} else {
    	
    		alert("인증번호를 다시 확인하세요.");
    		emailValidate = false;
    		
    	}
    
    });
    
    $(".close-btn").on("click", function() {

    	$("#email-modal").hide();
    	$("#agentEmail").val("");
    	$("#agentEmail").focus();
    	emailValidate = false;
    	clearInterval(runningTimer);
    	
    });

});

	function checkValidate() {
	
		if(idValidate && pwdValidate && pwdValidate2 && emailValidate) {
		
			return true;
		} else {
		
			alert("모든 항목을 양식에 맞게 작성해주세요.");
			return false;
		}
	}

	// 이메일 인증 모달창 띄우기
    function openModal() {
    
    	$("#email-modal").show();
    
    };
    
    function timer(){
    
	    let time= 180000;
		let min=3;
		let sec=60;
    
    	runningTimer = setInterval(function(){
    	
	        time=time-1000; //1초씩 줄어듦
	        min=time/(60*1000); //초를 분으로 나눠준다.
	
	       if(sec>0){ //sec=60 에서 1씩 빼서 출력해준다.
	       
	            sec=sec-1;
	            
	            //실수로 계산되기 때문에 소숫점 아래를 버리고 출력해준다.
	            if(sec < 10) {
	            	$("#timer").text(Math.floor(min)+':'+'0'+sec);
	            } else {
	            	$("#timer").text(Math.floor(min)+':'+sec);
	            }
	        }
	        
	        if(sec===0){
	        
	         	// 0에서 -1을 하면 -59가 출력된다.
	            // 그래서 0이 되면 바로 sec을 60으로 돌려주고 value에는 0을 출력하도록 해준다.
	            
	            sec=60;
	            
	            $("#timer").text(Math.floor(min)+':'+'00');
	            
	        }
	        
	        if(time < 0) {
	        
	        	clearInterval(runningTimer);
	        	alert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
	        	$("#email-modal").hide();
	        
	        }
	   
	    },1000); //1초마다 
	}

	function onClickUpload(btn) { // 서류등록 버튼 누르면
	
	    $(btn).siblings("input").click(); // file-inpur 버튼이 눌리도록
	
	};


	// 프리뷰 등록 함수
	function setPreview(input, el) { // 파일이 등록된 input 요소와 미리보기가 보여질 요소 전달 받음

    	if (input.files && input.files[0]) { // 파일이 있으면

	        var reader = new FileReader(); // 파일 리더 객체 생성
	
	        reader.onload = function (e) { // 로딩이 완료되면
	
	        $(el).attr("src", e.target.result);
	        // 아래 reader로 읽어들인 DataURL을
	        // 등록된 이미지 파일 미리보기 요소의 src 속성값으로 설정

        };

        reader.readAsDataURL(input.files[0]); // 등록된 이미지 파일을 DataURL 형식으로 읽음

    }

};