package com.kh.udongzip.house.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class House {
	
	private int houseNo;              // 매물 번호
	private int agentNo;			  // 등록 업체 번호
	private String title;             // 매물 정보 제목
	private String description;       // 매물 상세 정보
	private String thumbnail;         // 매물 대표사진
	private String salesType;         // 계약 유형
	private String address1;          // 주소1 (시/군/구/도로명)
	private String address2;          // 주소2 (상세주소)
	private int zipCode;              // 우편번호
	private String buildingType;      // 건물 유형
	private String buildingFloor;     // 건물 전체 층수
	
	private String subwayNo;          // 지하철 정보
	
	private int deposit;              // 전세금(보증금)
	private int monthlyCost;          // 월세
	private int manageCost;           // 관리비
	private String floor;             // 매물이 위치한 층수
	private String roomType;          // 방 유형
	private int roomCount;            // 방 갯수
	private String direction;         // 방향
	
	private String parking;           // 주차 가능 대수
	
	private double lat;               // 위도
	private double lng;               // 경도
	private double size_m2;           // 전용면적 (제곱미터)
	private double size_p;            // 전용면적 (평)
	private String pet;               // 반려동물 동반 가능 여부
	private String loan;              // 전세 대출 가능 여부
	private String moveinDate;        // 입주 가능일
	private String status;            // 활성화 여부
	private String regDate;           // 매물 등록일
	private int viewCount;            // 조회수
	private int reportCount;          // 신고 당한 수
	private String salesStatus;       // 계약 가능 여부
	
	private String manageInfo;        // 관리비 정보
	private String optionInfo;        // 옵션 정보
	
	// HOUSE 테이블에 없는 필드
	private String agentName;		  // 등록 업체명
	private String line;			  // 지하철 노선 정보
	private String station;           // 지하철 역 정보
	
}
