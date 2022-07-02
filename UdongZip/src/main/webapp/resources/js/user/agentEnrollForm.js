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
        
        var regExp = /^[a-z0-9!@#$%^]{8,20}$/i;

        if(!regExp.test($(this).val())) {

            $("#pwd-validate").removeClass("possible")
            .addClass("impossible")
            .html("유효하지 않은 형식입니다.<br>영문자(대소문자), 숫자, 특수문자(!@#$%^)로만 (8~20글자)");
            
            
        } else {
            
            $("#pwd-validate").removeClass("impossible")
            .addClass("possible")
            .html("안전한 비밀번호입니다.");
            
        }
        
    });
    
    // pwd 일치 검사
    $("#checkPwd").on("keyup", function() {

        if($(this).val() != $("#agentPwd").val()) {

            $("#check-validate").removeClass("possible")
            .addClass("impossible")
            .html("비밀번호가 일치하지 않습니다.");
            
            
        } else {
            
            $("#check-validate").removeClass("impossible")
            .addClass("possible")
            .html("비밀번호가 일치합니다.");
            
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

    $(".file-input").on("change", function() { // file-input의 값이 바뀌면

        var imgEl = $(this).siblings("img"); // 해당 input의 형제 중 img 태그를 가져와서

        setPreview(this, imgEl); // 프리뷰 등록 함수에 같이 전달

    });
    
    // id중복 체크
    $("#idCheck").on("click", function() {
    
        $.ajax({
            url : "idCheck.ag",
            data : { agentId : $("#agentId").val() },
            success : function(result) {
                
                if(result == "NNNNY") {
                    
                    alert("사용 가능한 ID입니다.");
                    
                } else {
                    alert("중복된 ID입니다. 다른 ID를 사용해주세요.");
                    $("#agentId").val("");
                    $("#agentId").focus();
                }
                
            },
            error : function() {
                console.log("통신 실패");	
            },
        });
        
    });

});

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