package com.kh.udongzip.chat.handler;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChattingHandler extends TextWebSocketHandler implements InitializingBean {
	
	// websocket 접속 성공 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
	}
	
	// websocket 접속 종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
	}
	
	// 클라이언트가 메시지를 보낸 경우
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		
	}

}
