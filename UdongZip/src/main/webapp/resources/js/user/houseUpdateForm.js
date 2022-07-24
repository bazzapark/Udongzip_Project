$(function() {

	getLatLng($("#address1").val());

    $(document).on("click", "img", function() {

        if($(this).attr("src") == undefined || $(this).attr("src") == "") {

            onClickUpload(this);

        } else {
	
		
			imgCount--;
			
			$(this).next().val("");
            $(this).attr("src", "");
            $(this).nextAll().eq(1).remove();

        }
        
        imgValidate();

    });

    $(document).on("change", ".file-input", function() { // file-input의 값이 바뀌면
    
    	var maxSize = 10 * 1024 * 1024;
    	var fileSize = this.files[0].size;
			
		if(fileSize > maxSize) {
		
			alert("10MB 이하의 이미지 파일만 등록 가능합니다.");
			$(this).val("");
			
		} else {
		
			imgCount++;
			
			 // 해당 input의 형제 중 img 태그를 가져와서
			 var imgEl = $(this).prev();

        	setPreview(this, imgEl); // 프리뷰 등록 함수에 같이 전달
		
		}
		
		imgValidate();

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
			
	});
	
	$(".delete-btn").on("click", function() {
	
		var response = confirm("삭제 후에는 복구가 불가능합니다. 삭제하시겠습니까?");
	
		if(response) {
			$("#delete-form").submit();
		};
	
	});

});

function getSelected(el, value) {

	$(el).each(function() {
	
		if($(this).val() == value) {
			$(this).attr("selected", true);
		}
	
	})

};

function getChecked(el, value) {

	$(el).each(function() {
	
		if($(this).val() == value) {
			$(this).attr("checked", true);
		}
	
	})

};

function arrChecked(el, value) {

	$(el).each(function(){
	
		var str = value;
			
		var arr = str.split(";");
			
		if(arr.includes($(this).val())) {
				
			$(this).attr("checked", true);
			
		}
	
	})


}

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

	function checkImgs() {
			
		if(thumbnailCheck && imgCheck) {
			return true;
		} else if(thumbnailCheck == false) {
			alert("대표 사진을 등록하세요.");
		} else if(imgCheck == false) {
			alert("매물 사진을 4장 이상 등록하세요.");
		}
				
		return false;
	
	};

	function imgValidate() {
	
		if($("#thumbnailFile").val() == "" || $("#thumbnailFile").val() == undefined) {
			thumbnailCheck = false;
		} else {
			thumbnailCheck = true;
		}
			
		if(imgCount >= 4) {
			imgCheck = true;
		} else {
			imgCheck = false;
		}
	
	};