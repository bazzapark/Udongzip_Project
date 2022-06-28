package com.kh.udongzip.chat.model.vo;

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
public class ChatRoom {
	
	private int chatRoomNo;   // 채팅방 번호
	private int memberNo;     // 개인회원 번호
	private int agentNo;      // 업체회원 번호
	
	// CHATROOM 테이블에 없는 필드
	private int unReadCount; // 

}
