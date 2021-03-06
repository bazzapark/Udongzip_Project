	var pwdValidate = false;
	var pwdValidate2 = false;
	var runningTimer;
	
	$(function() {
	
	   	$("#memberEmail").change(function() {
    		
    		emailValidate = false;
    		
    	});
    
    // pwd 유효성 검사
    $("#newPwd").on("keyup", function() {
        
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
        
        if($("#checkPwd").val() == $("#newPwd").val() &&  $("#newPwd").val().length > 0) {

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

    	if($("#checkPwd").val() == $("#newPwd").val() &&  $("#newPwd").val().length > 0) {

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
    
    $("#pwd-update-form .update-btn").click(function() {
    	
    		if(pwdValidate && pwdValidate2 && $("#memberPwd").val().length > 0) {
    			$("#pwd-update-form").submit();
    		} else {
    			alert("양식에 맞게 작성해주세요.");
    		}
    	
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
    
    $("#email-modal .close-btn").on("click", function() {

    	$("#email-modal").hide();
       	$("#memberEmail").val(currentEmail);
        emailValidate = false;
        clearInterval(runningTimer);
        	
    });  

});  

	function checkValidate() {
	
		if(emailValidate) {
		
			return true;
			
		} else {
		
			alert("이메일을 인증해주세요.");
			return false;
		}
	}
    
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
	        	$("#agentEmail").val(currentEmail);
	        
	        }
	   
	    },1000); //1초마다 

};