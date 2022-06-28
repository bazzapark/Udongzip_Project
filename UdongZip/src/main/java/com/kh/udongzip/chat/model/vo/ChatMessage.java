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
public class ChatMessage {
	
	private int messageNo;     // 메시지 번호
	private int chatRoomNo;    // 채팅방 번호
	private String senderId;   // 송신자
	private String content;    // 메시지 내용
	private String chatTime;   // 전송 시간
	private String unRead;     // 확인 여부

}
