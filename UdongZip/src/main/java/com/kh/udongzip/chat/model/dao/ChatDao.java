package com.kh.udongzip.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;

@Repository
public class ChatDao {

	// 채팅방 유무 확인용
	public int selectChatRoom(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("chatMapper.selectChatRoom", map);
	}
		
	// 채팅방 생성
	public int createChatRoom(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("chatMapper.createChatRoom", map);
	}
		
	// 채팅방 전체 조회
	public ArrayList<ChatRoom> selectChatRoomList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
			
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatRoomList", map);	
	}
		
	// 내가 확인하지 않은 메시지 몇개인지 조회
	public int selectUnReadCount(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("chatMapper.selectUnReadCount", map);
	}
		
	// 채팅 메시지 전체 조회
	public ArrayList<ChatMessage> selectChatMessageList(SqlSessionTemplate sqlSession, int chatRoomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatMessageList", chatRoomNo);
	}
		
	// 안읽은 메시지를 확인 메시지로 변경
	public int updateUnRead(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("chatMapper.updateUnRead", map);
	}
		
	// 메시지 저장
	public int insertChatMessage(SqlSessionTemplate sqlSession, ChatMessage message) {
		return sqlSession.insert("chatMapper.insertChatMessage", message);
	}

}