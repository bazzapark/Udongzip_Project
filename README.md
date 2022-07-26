# 우동집

## 프로젝트 제작 목표
사회초년생들이 사회로 나와 독립하는 과정에서 겪는 많은 어려움 중 가장 큰 어려움이 '집'이다.

누구나 좋은 집을 얻고 싶어하지만, 상대적으로 부동산 계약 경험이 적은 사회초년생들은 어떤 집이 좋은 집인지 어떤 중개사가 좋은 중개사인지 판단하기 어렵다.

특히, 사회초년생들이 주로 찾는 원룸/투룸 전월세 매물은 중개사무소가 허위매물로 고객을 유인하는 것도 비일비재하다.

이러한 결과로 이용자들은 부동산 중개 플랫폼은 본격적으로 집을 알아보기 전 대략적인 시세를 파악하는 참고자료일 뿐이고, 실질적으로는 직접 발품을 팔아 집을 구해야 한다는 인식이 퍼져있다.

우동집은 불량 중개사무소와 허위매물 문제를 해결하고, 사용자가 직접 발품을 팔지 않아도 사이트 내에서 좋은 방과 좋은 중개사무소를 만날 수 있도록 하는 것을 목표로 제작되었다.

## 기술 스택
* Java8
* Spring MVC
* MyBatis
* Oracle
* MySQL
* Maven
* Apache Tomcat
* Javascript
* HTML5
* CSS3

## 테이블 구성
![UdongzipERD](https://user-images.githubusercontent.com/96688007/180923021-741b0970-1640-412e-a047-a6f292b39667.png)

## 구현 기능
* 개인회원 기능
  * 회원가입 및 이메일 인증(ID, PW 유효성 검사)
  * 마이페이지
    * 회원 정보 수정 및 탈퇴
    * 예약 내역 조회 (방문 결과에 따른 리뷰 작성 가능 여부 판단)
    * 리뷰 내역 관리
    * 찜한 매물 조회
    * 1:1 문의 내역 조회
    
 * 업체회원 기능

## 주요 기능 이미지

### 매물 조회
  * Kakao Map API를 활용한 매물 지도
  * 구역별 매물 개수에 따른 클러스트 스타일 변경
  * 줌 레벨에 따른 클러스터 및 마커 스타일 변경
  
![UdongzipMap1](https://user-images.githubusercontent.com/96688007/180924112-f0c0cdd2-7048-4b1e-9a07-52681d31b32b.png)
![UdongzipMap2](https://user-images.githubusercontent.com/96688007/180924243-fededa4a-5154-44aa-886f-3642781eddb4.png)

### 개인회원과 중개사무소 1:1 실시간 채팅 문의
  * WebSocket 통신을 활용한 1:1 실시간 채팅
  * 읽지 않은 메시지 수 count
  * 메시지 확인 시 읽음 처리
  * 비동기식 통신으로 읽지 않은 메시지 확인
  
![UdongzipChat1](https://user-images.githubusercontent.com/96688007/180924744-6f5f39c0-81a8-45cd-abab-202b2b064b3b.png)
![UdongzipChat2](https://user-images.githubusercontent.com/96688007/180924789-d3879dd9-da03-4318-9de8-82e410d66c5b.png)

### 방문 상담 예약 및 예약금 결제
  * Kakao Pay API를 활용한 결제 시스템
  * 방문 완료 시 자동 환불
  
![UdongzipPay1](https://user-images.githubusercontent.com/96688007/180925169-03c195b2-f6ab-40e5-8f1b-2dee860471ba.png)
![UdongzipPay2](https://user-images.githubusercontent.com/96688007/180925184-084c472e-6912-4000-8854-e4ad2f014926.png)
![UdongzipPay3](https://user-images.githubusercontent.com/96688007/180925935-621b5145-676f-4785-894c-894842f9fadb.png)
