package com.kh.udongzip.chat.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;

@Service
public class ChatServiceImpl implements ChatService {

	@Override
	public ChatRoom selectChatRoom(ChatRoom room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int createChatRoom(ChatRoom room) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ChatRoom> selectChatRoomList(HttpSession session) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectUnReacCount(int roomNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ChatMessage> selectChatMessageList(int roomNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateUnRead(ChatMessage message) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertChatMessage(ChatMessage message) {
		// TODO Auto-generated method stub
		return 0;
	}

}
