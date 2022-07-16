package com.kh.udongzip.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udongzip.chat.model.dao.ChatDao;
import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectChatRoom(HashMap<String, Object> map) {
	
		return chatDao.selectChatRoom(sqlSession, map);
	}

	@Override
	public int createChatRoom(HashMap<String, Object> map) {
		
		return chatDao.createChatRoom(sqlSession, map);
	}

	@Override
	public ArrayList<ChatRoom> selectChatRoomList(HashMap<String, Object> map) {

		return chatDao.selectChatRoomList(sqlSession, map);
	}

	@Override
	public int selectUnReadCount(HashMap<String, Object> map) {
	
		return chatDao.selectUnReadCount(sqlSession, map);
	}

	@Override
	public ArrayList<ChatMessage> selectChatMessageList(int chatRoomNo) {
		
		return chatDao.selectChatMessageList(sqlSession, chatRoomNo);
	}

	@Override
	public int updateUnRead(HashMap<String, Object> map) {
		
		return chatDao.updateUnRead(sqlSession, map);
	}

	@Override
	public int insertChatMessage(ChatMessage message) {
		
		return chatDao.insertChatMessage(sqlSession, message);
	}

}
