package com.kh.udongzip.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;

public interface ChatService {
	
	// 채팅방 유무 확인용
	int selectChatRoom(HashMap<String, Object> map);
	
	// 채팅방 생성
	int createChatRoom(HashMap<String, Object> map);
	
	// 채팅방 전체 조회
	ArrayList<ChatRoom> selectChatRoomList(HashMap<String, Object> map);
	
	// 내가 확인하지 않은 메시지 몇개인지 조회
	int selectUnReadCount(HashMap<String, Object> map);
	
	// 채팅 메시지 전체 조회
	ArrayList<ChatMessage> selectChatMessageList(int chatRoomNo);
	
	// 안읽은 메시지를 확인 메시지로 변경
	int updateUnRead(HashMap<String, Object> map);
	
	// 메시지 저장
	int insertChatMessage(ChatMessage message);


	
}
