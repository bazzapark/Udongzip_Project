package com.kh.udongzip.chat.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;

public interface ChatService {
	
	// 채팅방 유무 확인용
	ChatRoom selectChatRoom(ChatRoom room);
	
	// 채팅방 생성
	int createChatRoom(ChatRoom room);
	
	// 채팅방 전체 조회
	ArrayList<ChatRoom> selectChatRoomList(HttpSession session);
	
	// 내가 확인하지 않은 메시지 몇개인지 조회
	int selectUnReacCount(int roomNo);
	
	// 채팅 메시지 전체 조회
	ArrayList<ChatMessage> selectChatMessageList(int roomNo);
	
	// 안읽은 메시지를 확인 메시지로 변경
	int updateUnRead(ChatMessage message);
	
	// 메시지 저장
	int insertChatMessage(ChatMessage message);

}
