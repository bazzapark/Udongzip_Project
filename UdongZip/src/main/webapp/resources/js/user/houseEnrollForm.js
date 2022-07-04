$(function() {

    document.getElementById("address1").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
            	document.getElementById("address1").value = ""; // 입력칸 비워주기
                document.getElementById("address1").value = data.address; // 주소 넣기
                document.querySelector("input[name=address2").focus(); //상세입력 포커싱
            }
        }).open();
    });

    $("img").on("click", function() {

        if($(this).attr("src") == undefined || $(this).attr("src") == "") {

            onClickUpload(this);

        } else {
	
			$(this).next().val("");
            $(this).attr("src", "");

        }

    });
    
    $("#map-btn").on("click", function() {
        
        var address = $("#address1").val() + " " + $("#address2").val();
    
        getLatLng(address);
        
    })

    $(".file-input").on("change", function() { // file-input의 값이 바뀌면

        var imgEl = $(this).prev(); // 해당 input의 형제 중 img 태그를 가져와서

        setPreview(this, imgEl); // 프리뷰 등록 함수에 같이 전달

    });

    $("#size_m2").on("change", function() {

        var $size_p = ($(this).val() * 0.3025).toFixed(2);
        $("#size_p").val($size_p);

    });

    $("#size_p").on("change", function() {

        var $size_m2 = ($(this).val() * 3.306).toFixed(2);
        $("#size_m2").val($size_m2);

    });
    
    $("#roomType").on("change", function() {
    
    	if($(this).children(":selected").val() == "투룸") {
    	
    		$("#roomCount").val(2);
    		
    	} else {
    	
    		$("#roomCount").val(1);
    		
    	}
    	
    })

    $("#title").keyup(function() {

        $("#title-length").text($(this).val().length);

    });

    $("#description").keyup(function() {

        $("#description-length").text($(this).val().length);

    });
    
	$("#moveinNow").on("change", function() {
		
		if($(this).is(":checked")) {
			$("#moveinDate").prop("type", "text");
			$("#moveinDate").val("즉시입주");
			$("#moveinDate").attr("readonly", true);
		} else {
			$("#moveinDate").prop("type", "date");
			$("#moveinDate").val("");
			$("#moveinDate").attr("readonly", false);
		}
			
	})    

})

function getLatLng(address) {
    
    var geocoder = new kakao.maps.services.Geocoder();

    var callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            console.log(result);
        }
    };

    geocoder.addressSearch(address, createMap);
    
};

function createMap(result) {
    
    var y = result[0].y;
    var x = result[0].x;
    
    $("#lat").val(y);
    $("#lng").val(x);

    var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스

    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };

    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    
     // 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(y, x); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

};

function onClickUpload(el) { // 이미지 영역 클릭 시

    $(el).next().click() // file-input 버튼이 눌리도록

};

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