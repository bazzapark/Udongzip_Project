    
    	var listCount; // 전체 리스트의 수
        var listLimit = 5; // 한 페이지에 보여줄 리스트 수
        var pageLimit = 5; // 페이징바에 보여줄 페이지의 수
        var list;
     
     function paging(listCount, listLimit, pageLimit, currentPage) {
         
         // 현재 페이징바 비우기
         $(".page_nation").text("");
         
         var maxPage = Math.ceil(listCount/listLimit); // 최대 페이지 수
         
         if(maxPage < pageLimit) { // 최대 페이지 수가 페이징바의 수보다 작을 경우
             pageLimit = maxPage; // 페이징바 수를 최대 페이지 수와 맞춤
         }
         
         var startPage = Math.floor((currentPage - 1) / pageLimit) * pageLimit + 1;
         var endPage = startPage + pageLimit - 1; // 해당 페이징바의 끝수
         
         if(endPage > maxPage) { // 페이징바의 끝수가 최대 페이지 수보다 큰 경우
             endPage = maxPage; // 페이징바의 끝수를 최대 페이지 수로 맞춤
         }
         
         // 페이징바 출력
         var pagingStr = ""; // 페이징바 html 요소를 담을 문자열 선언
         
         if(startPage != 1) { // 페이징바 시작수가 1이 아니면
             pagingStr += "<a class='arrow pprev'></a>"; // 이전 페이징바 버튼 생상
         }
         
         if(currentPage > 1) { // 현재 페이지가 1페이지가 아니면
             pagingStr += "<a class='arrow prev'></a>"; // 이전 페이지 버튼 생성
         }
         
         // 시작수부터 끝수까지 반복
         for(var i = startPage; i <= endPage; i++) {
             
             if(currentPage == i) { // i가 현재 페이지와 같다면
                 
                 pagingStr += "<a class='active'>" + i + "</a>"; // active 클래스 추가
                 
             } else {
                 
                 pagingStr += "<a>" + i + "</a>";
                 
             }
             
         }
         
         if(currentPage < maxPage) { // 현재 페이지가 최대 페이지 수보다 작다면
             pagingStr += "<a class='arrow next'></a>"; // 다음 페이지 버튼 생성
         }
         
         if(endPage != maxPage) { // 페이징바의 끝수가 최대 페이지 수가 아니라면
             pagingStr += "<a class='arrow nnext'></a>"; // 다음 페이징바 버튼 생성
         }
         
         $(".page_nation").append(pagingStr); // page_nation 영역에 출력
         
         // 페이징바 버튼들에 클릭 이벤트 부여
         $(".page_nation a").on("click", function() {
             
             var selectedPage = Number($(this).text());
             
             if($(this).hasClass("pprev")) { // 이전 페이징바 버튼인 경우
                 selectedPage = startPage - pageLimit; // 선택한 페이지 = 현재 페이징바의 시작수 - 페이징바에 보여줄 페이지의 수 (ex. 11 - 10 = 1)
             } else if($(this).hasClass("prev")) { // 이전 페이지 버튼인 경우
                 selectedPage = currentPage - 1; // 선택한 페이지 = 헌재 페이지 - 1
             } else if($(this).hasClass("next")) { // 다음 페이지 버튼인 경우
                 selectedPage = currentPage + 1; // 선택한 페이지 = 헌재 페이지 + 1
             } else if($(this).hasClass("nnext")) { // 다음 페이징바 버튼인 경우
                 selectedPage = startPage + pageLimit; // 선택한 페이지 = 현재 페이징바의 시작수 + 페이징바에 보여줄 페이지의 수 (ex. 11 + 10 = 21)
             }
             
             paging(listCount, listLimit, pageLimit, selectedPage); // 페이징바 출력용 함수 재호출
             
             displayList(selectedPage, listLimit, list); // 리스트 출력용 함수 제호출
             
         });
         
     }
        
        // 리스트 출력용 함수
        function displayList(currentPage, listLimit, list) {
            
            // 테이블에 현재 보여주는 리스트 지우기
            $("#house-list tbody").text("");
            
            // 전달 받은 변수 숫자로 변환
            currentPage = Number(currentPage);
            listLimit = Number(listLimit);
            
            var listStr = ""; // 리스트 html 요소를 담을 문자열
            
            var startIndex = (currentPage - 1) * listLimit;
            var endIndex = (currentPage - 1) * listLimit + listLimit;
            
            if(endIndex > list.length) {
            	endIndex = list.length
            }
            
            // 반복문을 통해 출력할 테이블 만들기
            for(var i = startIndex; i < endIndex; i++) {
                
                listStr += "<tr>"
                         + "<td class='houseNo'>" + list[i].houseNo + "</td>"
                         + "<td><img class='house-thumbnail' src='" + list[i].thumbnail + "'></td>"
                         + "<td>" + list[i].address1 + "</td>"
                         + "<td>" + list[i].title + "</td>"
                         + "<td>" + list[i].regDate + "</td>";
                         
                if(list[i].salesStatus == "Y") {
                    
                    listStr += "<td class='not-click'>"
                             + "<select>"
                             + "<option value='Y' selected>계약 가능</option>"
                             + "<option value='N'>계약 불가</option>"
                             + "</select>"
                             + "</td>"
                             + "</tr>";
                    
                } else {
                    
                    listStr += "<td class='not-click'>"
                          + "<select>"
                          + "<option value='Y'>계약 가능</option>"
                          + "<option value='N' selected>계약 불가</option>"
                          + "</select>"
                          + "</td>"
                          + "</tr>";
                    
                }
                
            }
            
            $("#house-list tbody").append(listStr);
            
        }
        
      	$(document).on("click", "#house-list tbody tr td:not(.not-click)", function() {
		    
		    $("#update-form").find("input").val($(this).parents().children(".houseNo").text());
		    
		    $("#update-form").submit();
		    
		});
		
		$(function() {
		
			$("#search-input").keydown(function (key) {
			
		        if (key.keyCode == 13) {
		            getList();
		        }
		        
		    });
		
			$(".enroll-btn").on("click", function() {
				
				location.href="enrollForm.ho";
				
			})
		
		})