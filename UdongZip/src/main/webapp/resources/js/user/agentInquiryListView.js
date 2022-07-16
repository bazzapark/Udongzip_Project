    
    	var listCount; // 전체 리스트의 수
        var listLimit = 10; // 한 페이지에 보여줄 리스트 수
        var pageLimit = 5; // 페이징바에 보여줄 페이지의 수
     
     function paging(listCount, listLimit, pageLimit, currentPage, filterList) {
     
     	 $(".list-amount").text("총 " + listCount + "건");
         
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
             
             paging(listCount, listLimit, pageLimit, selectedPage, filterList); // 페이징바 출력용 함수 재호출
             
             displayList(selectedPage, listLimit, filterList); // 리스트 출력용 함수 제호출
             
         });
         
     };
        
        // 리스트 출력용 함수
        function displayList(currentPage, listLimit, filterList) {
            
            // 테이블에 현재 보여주는 리스트 지우기
            $("#inquiry-list tbody").text("");
            
            // 전달 받은 변수 숫자로 변환
            currentPage = Number(currentPage);
            listLimit = Number(listLimit);
            
            var listStr = ""; // 리스트 html 요소를 담을 문자열
            
            var startIndex = (currentPage - 1) * listLimit;
            var endIndex = (currentPage - 1) * listLimit + listLimit;
            
            if(endIndex > filterList.length) {
            	endIndex = filterList.length;
            }
            
            // 반복문을 통해 출력할 테이블 만들기
            for(var i = startIndex; i < endIndex; i++) {
                
                listStr += "<tr>"
                         + "<td>" + filterList[i].inquiryNo + "</td>"
                         + "<td>" + filterList[i].category + "</td>"
                         + "<td>" + filterList[i].title + "</td>"
                         + "<td>" + filterList[i].createDate + "</td>";
                         
                 if(filterList[i].answerContent == null) {
                 	
                 	listStr += "<td>미답변</td>"
                 			 + "</tr>";
                 	
                 } else {
                 
                 	listStr += "<td>답변 완료</td>"
                 			 + "</tr>";
                 
                 }
                
            }
            
            $("#inquiry-list tbody").append(listStr);
            
        }
        
        $(function() {
        	
        	$("#filter-select").on("change", function() {
        	
	        	if($(this).val() == '전체') {
	        	
	        		listCount = list.length;
	        		filterList = list;
	        		
	        		if(listCount > 0) {
	                	
	                	displayList(1, listLimit, list);
		                
		                paging(listCount, listLimit, pageLimit, 1, list);
	                	
	                } else {
	                	
	                	$("#inquiry-list tbody").text("");
	                	
	                	$(".list-amount").text("총 " + listCount + "건");
	                	
	                	var noList = "<tr id='no-list'>"
	                			   + "<td colspan='4' class='not-click'>"
	                			   + "조회된 내역이 없습니다."
	                			   + "<td>"
	                			   + "</tr>";
	                			   
	                	$("#inquiry-list tbody").append(noList);
	                	
	                }
	        	
	        	} else {
	        	
	        		filterList = [];
	        		
	        		for(var i in list) {
	        	
	        		if(list[i].category == $(this).val()) {
	        			
	        			filterList.push(list[i]);
	        			
	        		}
	        		
		        	};
		        	
		        	listCount = filterList.length;
		        	
		        	if(listCount > 0) {
			                	
			        	displayList(1, listLimit, filterList);
				                
				        paging(listCount, listLimit, pageLimit, 1, filterList);
			                	
			         } else {
			                	
			         	$("#inquiry-list tbody").text("");
			         	
			         	$(".list-amount").text("총 " + listCount + "건");
			                	
			            var noList = "<tr id='no-list'>"
			                	   + "<td colspan='4' class='not-click'>"
			                	   + "조회된 내역이 없습니다."
			                	   + "<td>"
			                	   + "</tr>";
			                			   
			            $("#inquiry-list tbody").append(noList);
			                	
			         }
	        	
	        	}
	        	
        	
        	});
        	
        	$(document).on("click", "#inquiry-list tbody tr:not(#no-list) td:not(.not-click)", function() {
        		
        		var inquiryNo = $(this).parents().children().eq(0).text();
        	
        		$("#detail-form").children("input[name=inquiryNo]").val(inquiryNo);
        	
        		$("#detail-form").submit();
        		
        	});
        
        })