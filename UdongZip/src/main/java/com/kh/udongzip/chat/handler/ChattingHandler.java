package com.kh.udongzip.chat.handler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.udongzip.chat.model.service.ChatService;
import com.kh.udongzip.chat.model.vo.ChatMessage;
@Controller
@RequestMapping("/chatting.do")
public class ChattingHandler extends TextWebSocketHandler implements InitializingBean {
	// TextWebSocketHandler (자체)클래스를 상속받아 사용
	@Autowired
	private ChatService chatService;
	// 세션리스트
	// private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	// 채팅방 Map(방번호, session 목록) => 해당 방에 접속한 세션 정보를 알 수 있다.
	private Map<Integer, ArrayList<WebSocketSession>> roomList = new ConcurrentHashMap<Integer, ArrayList<WebSocketSession>>();
	
	// session, 방 번호가 매칭된 Map => 해당 세션이 속해있는 방을 알 수 있다.
	private Map<WebSocketSession, Integer> sessionList = new ConcurrentHashMap<WebSocketSession, Integer>();
	
	private static Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	// websocket 접속 성공 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
		// sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
	}
	
	// websocket 접속 종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		if(sessionList.get(session) != null) {
			// 세션리스트에서 키값(session) 밸류(방번호)를 불러왔는데 null이 아니면 기존의 방을 삭제시켜줘야함
			
			roomList.get(sessionList.get(session)).remove(session);
			// 세션리스트에서 키값(session)을 불러왔을떄 밸류(방번호)를 불러와 담고
			// roomList로 불러와서 해당 session (방번호)를 삭제
			
		}
		
		// sessionList.remove(session);
		logger.info("{} 연결 끊김.", session.getId());
	}
	
	// 클라이언트가 메시지를 보낸 경우
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메세지를 사용자에게 전송(사용자 수만큼 반복하여 전송)
		// TextMessage에 jsp에서 넘긴 JSON이 담김 
		// message.getPayload메소드를 통해서 넘긴값 매개변수에 넣어서 받은 후 ObjectMapper로 VO객체랑 파싱
				
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		
		String currentTime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
		
		System.out.println(currentTime);
		
		String chatinfo = message.getPayload();
		
		ChatMessage chatmessage = new ChatMessage();
		// JsonObject, JsonArray, JsonElement 를 이용해서 파싱할 수 있음
		// => gson 라이브러리에서 제공
		// 주의 - 기존의 JSONObject, JSONArray 랑은 다른 객체임 (json 라이브러리에서 제공하던것)
		JsonObject totalObj = JsonParser.parseString(chatinfo).getAsJsonObject();
		// chatinfo에 jsp에서 json으로 넘겨준 키 : 밸류가 다 담겨져있는 상태 
		
		int chatRoomNo = totalObj.get("chatRoomNo").getAsInt();
		String content = totalObj.get("content").getAsString();
		String senderId = totalObj.get("senderId").getAsString();
		
		chatmessage.setChatRoomNo(chatRoomNo);
		chatmessage.setContent(content);
		chatmessage.setSenderId(senderId);
		
		if(roomList.get(chatRoomNo) == null && content.equals("ENTER_CHAT")) {
			// DB에채팅방은 있는데 접속한 사람이 아무도 없을 경우 (비활성화)
			
    		if(sessionList.get(session) != null) {
    			// 세션리스트에서 키값(session) 밸류(방번호)를 불러왔는데 null이 아니면 기존의 방을 삭제시켜줘야함
    			
    			int num = sessionList.get(session);
    			// 세션리스트에서 키값(session) 밸류(방번호)를 불러와서 담아두고
    			
    			ArrayList<WebSocketSession> sessions = roomList.get(num);
    			// ArrayList웹소켓세션에 룸리스트에서 해당하는 방 번호를 불러오고
    			
    			sessions.remove(session);
    			// 해당하는 방번호에 맞게 삭제
    			// roomList.get(sessionList.get(session)).remove(session);
    			
    		}
			
			// 활성화상태로 변경시켜야하고 활성화된 방번호, 접속한 session 목록 추가
			
			// 채팅방에 들어갈 session들
            ArrayList<WebSocketSession> sessionTwo = new ArrayList<>();
            
            // session 추가
            sessionTwo.add(session);
            
            // roomList에 추가
            roomList.put(chatRoomNo, sessionTwo);
            // 현 시점에서 이제 활성화가 시작함
            
            // sessionList에 추가
            // session 정보들이랑 방번호를 추가시켜서 기록(기록을 통해서 추후에 기존 방 세션 삭제할것)
            sessionList.put(session, chatRoomNo);
            // 키 : session, 밸류 : chatRoomNo 
            
		} else if(roomList.get(chatRoomNo) != null && content.equals("ENTER_CHAT")) {
			// DB에 채팅방도있고, 채팅방에 접속한사람이 한명이라도 있는 경우 (활성화된 상태)
			// 접속한사람이 있기때문에 roomList에 정보가 담겨있다.
			
			if(sessionList.get(session) != null) {
				// 세션리스트에서 키값(session) 밸류(방번호)를 불러왔는데 null이 아니면 기존의 방을 삭제시켜줘야함
				
				roomList.get(sessionList.get(session)).remove(session);
				// 세션리스트에서 키값(session)을 불러왔을떄 밸류(방번호)를 불러와 담고
				// roomList로 불러와서 해당 session (방번호)를 삭제
				
			}
			
			roomList.get(chatRoomNo).add(session);
			// roomList 방번호를 불러와서 새로운 (키값)session/방번호 를 추가시킴
			
			// sessionList에 추가
            // session 정보들이랑 방번호를 추가시켜서 기록(기록을 통해서 추후에 기존 방 세션 삭제할것)
            sessionList.put(session, chatRoomNo);
            // 키 : session, 밸류 : chatRoomNo 			
			// log.info("채팅방 입장");
			
		} else if (roomList.get(chatRoomNo) != null && !content.equals("ENTER_CHAT")) {
			// DB에 채팅방이있고, 채팅방에 접속한사람이 있는 조건에
			// 해당 방번호에 해당하는 세션들한테만 메세지를 보내줘야함
		
			ArrayList<WebSocketSession> sessions = roomList.get(chatRoomNo);
			// roomList에서 해당 방번호를 뽑아오고
			
			int sessionCount = 0;
			// 현재 세션 수
			// 차후에 메세지읽음 안읽음을 구별하기위에 카운트 추가
			
			// 현재 웹 소켓 서버에 해당 방 번호에 맞는 Session들한테만 메세지 전달
			// 송신자 수신자 구분은 jsp에서 이미 카톡처럼 만들어둠 (해당 방에만 전부 메세지 뿌려주면 끝)
			for(WebSocketSession sess : sessions) {
				
					sess.sendMessage(new TextMessage(senderId + "^^" + content + "^^" + currentTime));
					sessionCount++;
					// sess.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
			}
			
			if(sessionCount == 1) {
				chatmessage.setUnRead("Y");
			}
			else if(sessionCount == 2) {
				chatmessage.setUnRead("N");
			}
			 // 동적쿼리에서 사용할 sessionCount 저장
            // sessionCount == 2 일 때는 unReadCount = 0,
            // sessionCount == 1 일 때는 unReadCount = 1
			//chatMessage.setSessionCount(sessionCount);
			
			int result = chatService.insertChatMessage(chatmessage);
				
		}
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		
	}

}