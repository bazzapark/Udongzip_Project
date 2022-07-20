<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우동집 | 우리동네집 모아보기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="resources/css/user/serviceListView.css">
</head>

<body>


    <!-- 전체 영역 -->
    <div id="wrap">
    <jsp:include page="../../common/header.jsp" /> <!-- 헤더 -->

        <!-- 콘텐츠 영역 -->
        <div id="content-area">

            <!-- 큰 제목 -->
            <div class="Service">
                <h1 align="center"><b>고객센터</b></h1>
            </div>

            <!-- 네비 바 -->
            <div class="navi-area">
                <ul class="navi">
                    <li class="tab-link current"  data-tab="tab-3" onclick="noticeajax()">공지사항</li>
                    <li class="tab-link" data-tab="tab-1">자주 묻는 질문</li>
                    <c:if test="${ !empty loginUser and loginUser.identifier ne 'root' }">
                    	<li class="tab-link"  data-tab="tab-2">1 : 1 문의</li>
                    </c:if>
                </ul>



                <!-- 탭의 내용 -->

                <!-- FAQ -->
                <div id="tab-1" class="tab-content">
                    <br>
                    <h3 align="center">
                        <!-- 중간 문구-->
                        편의를 위해 자주 묻는 질문과 답변을 모아놓았습니다.<br>
                        원하시는 질문을 찾아보세요!
                    </h3><br><hr><br>
				<c:forEach var="f" items="${ list }">	
                 <div class="faqq"><b>Q.</b>&nbsp; ${ f.title }</div>
	                 <p class="faqa">A. ${f.content }</p>
     			</c:forEach>
                 <br>
                </div>
                    

                <!-- 1 : 1 문의글 작성 -->
                <div id="tab-2" class="tab-content">
                    <br><br>
                    <div class="innerOuter" align="center">
                        <h2>1 : 1  문의하기</h2>
                        <br>
            
                        <form id="enrollForm" method="post" action="insert.in">
                        	<c:choose>
                        		<c:when test="${ loginUser.identifier == 'member' or loginUser.identifier == 'root' }">
		                            <input type="hidden" name="memberNo" value="${ loginUser.memberNo }" />
		                            <table align="center">
		                                <tr>
		                                    <th>카테고리</th>
		                                    <td>
		                                        <select name="category">
		                                            <option value="계정 문의">계정 문의</option>
		                                            <option value="매물 문의">매물 문의</option>
		                                            <option value="예약 문의">예약 문의</option>
		                                            <option value="기타 문의">기타 문의</option>
		                                        </select>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <th><label for="title">제목</label></th>
		                                    <td><input type="text" id="title" class="form-control" name="title" required></td>
		                                </tr>
		                                <tr>
		                                    <th><label for="content">내용</label></th>
		                                    <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="content" required></textarea></td>
		                                </tr>
		                            </table>
		                         </c:when>
		                         
		                         <c:otherwise>
		                         	<input type="hidden" name="agentNo" value="${ loginUser.agentNo }" />
		                         	<table align="center">
		                                <tr>
		                                    <th>카테고리</th>
		                                    <td>
		                                        <select name="category">
		                                            <option value="계정 문의">계정 문의</option>
		                                            <option value="매물 문의">매물 문의</option>
		                                            <option value="예약 문의">예약 문의</option>
		                                            <option value="기타 문의">기타 문의</option>
		                                        </select>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <th><label for="title">제목</label></th>
		                                    <td><input type="text" id="title" class="form-control" name="title" required></td>
		                                </tr>
		                                <tr>
		                                    <th><label for="content">내용</label></th>
		                                    <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="content" required></textarea></td>
		                                </tr>
		                            </table>
		                         </c:otherwise>   
		                         
	                          </c:choose>  
                            <br>
            
                            <div class="wt-btn" align="right">
                                <button type="submit" class="btn">등록하기</button>
                            </div>
                        </form>
                    </div>
                    <br><br>
                </div>


                <!-- 공지사항 -->
                <div id="tab-3" class="tab-content current">
                    <div id="notice-area">
                        <table class="table" id="test">
                            <thead>
                              <tr>
                                <th>No.</th>
                                <th style="width: 70%;">제목</th>
                                <th>작성일</th>
                              </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="page_wrap">
							<div class="page_nation">
							</div>
						</div>
                    </div>

                    <!-- 공지사항 상세-->
                    <div id="noticeDT">
                        <!-- 제목 -->
                        <div id="DTtitle">
                        </div>
                        <!-- 작성일 -->
                        <div id="DTdate">
                        </div>
                        <!-- 내용 -->
                        <div id="DTcontent">
                            <textarea rows="15px" cols="80%" style="resize: none;" readonly>내용
                            </textarea>
                        </div>
                        <div align="center">
                            <button type="button" class="btn btn-danger" onclick="noticeajax()">이전으로</button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <jsp:include page="../../common/footer.jsp" /> <!-- 푸터 -->
    </div>


    <!-- 화면 변경 없이 메뉴가 클릭 하는 스크립트 -->
    <script>
        $(document).ready(function(){
	
            $('ul.navi li').click(function(){							//선택자를 통해 tabs 메뉴를 클릭 이벤트를 지정해줍니다.
                var tab_id = $(this).attr('data-tab');

                $('ul.navi li').removeClass('current');			//선택 되있던 탭의 current css를 제거하고 
                $('.tab-content').removeClass('current');		

                $(this).addClass('current');								////선택된 탭에 current class를 삽입해줍니다.
                $("#" + tab_id).addClass('current');
            })

        });
    </script>

    <!-- FAQ 관련 스크립트 -->
    <script>
        $(function() {

            $(".faqq").click(function() {

                // $(this) : 현재 클릭이벤트가 발생한 div 요소 (타겟)
                // $(this).next() : 현재 클릭이벤트가 발생한 div 요소 바로 다음에 나오는 p 요소 => 해당 답변

                var $p = $(this).next(); // p 요소 자체를 변수에 담아두기
                // jQuery 방식으로 선택된 요소를 변수에 담고자 할 때에는 변수명 앞에 $ 를 붙이곤 함

                // p 요소가 보이지 않는다면 
                if($p.css("display") == "none") {
                // css() 메소드 또한 속성명만 매개변수로 넘기게 되면 해당 속성값을 반환해준다.
                // (getter / setter 역할 동시에 가능)

                    // 기존에 열려있던 답변들을 닫아주기
                    $(this).siblings("p").slideUp(300);

                    // 보여지게끔
                    $p.slideDown(300); // 밀리세컨초 단위로 시간부여 가능
                }
                else { // p 요소가 보인다면

                    // 사라지게끔
                    $p.slideUp(0);
                }
            });
        });
    </script>

    <script>
    
    var list;
    var listCount; // 전체 리스트의 수
    var listLimit = 10; // 한 페이지에 보여줄 리스트 수
    var pageLimit = 5; // 페이징바에 보여줄 페이지의 수
    
    <!-- 공지사항 관련 스크립트 -->
    
        function noticeajax() {

            $.ajax({
                url : "list.no",
                success : function(result){
                	$("#notice-area").css("display", "block");
					$("#noticeDT").css("display", "none");
					list = result;
					listCount = result.length;
					
					if(listCount > 0) {
                	
                	displayList(1, listLimit, list);
	                
	                paging(listCount, listLimit, pageLimit, 1, list);
                	
	                } else {
	                	
	                	// 0
	                	
	                }
                },
                error : function() {
                	console.log("ajax 통신 실패!");
                }
            });

        };
        
     
     function paging(listCount, listLimit, pageLimit, currentPage, filterList) {
         
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
            $("#notice-area tbody").text("");
            
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
                 +         "<td id='noDT'>" + filterList[i].noticeNo + "</td>"
                 +         "<td>" + filterList[i].title + "</td>"
                 +         "<td>" + filterList[i].createDate + "</td>"
                 + "</tr>";
                
            }
            
            $("#notice-area tbody").append(listStr);
            
        }
        
        <!-- 공지사항 제목 클릭 시 해당 공지 상세보기 페이지로 비동기식 이동 -->
        
    	$(function(){
    		
    		noticeajax();
    		
    		$("#notice-area>.table>tbody").on("click", "tr", function(){
    			
    			$.ajax({
    				url: "detail.no",
    				data: {noticeNo: $(this).children().eq(0).text()},
    				success: function(notice) {
    					$("#notice-area").css("display", "none");
    					$("#noticeDT").css("display", "block");
    					
    					$("#DTtitle").html("<h3>" + notice.title + "</h3>"); 
    					$("#DTdate").html("<h5><u>" + notice.createDate + "</u></h5>");
    					$("#DTcontent").html("<textarea rows='15px' cols='80%' style='resize: none;' readonly>" + notice.content + "</textarea>");
    					
    				},
    				error: function() {
    					console.log("ajax 실패");
    				}
    			})
    		});            		
    	});
        

        
        
     <!-- FAQ 관련 스크립트 -->   
     /*	
	     function faqAjax() {
	
	         $.ajax({
	             url : "faq.no",
	             success : function(result){
	             	// console.log(result);
	             	
	            	 var resultStr1 ="";
	            	 var resultStr2 ="";
	            	 for(var i = 0; i < result.length; i++) {
	            		 resultStr1 += "<div><b>Q.</b>&nbsp;" + result[i].title + "</div>"
	                     resultStr2	+= result[i].content 
	            	 }
	             	
	            	 $(".faqq").html(resultStr1);
	            	 $(".faqa").html(resultStr2);
	             },
	             error : function() {
	                	comsole.log("ajax 통신 실패!");
	             }
	         });
	
	     }
     */
     
    </script>

    
</body>
</html>