package com.kh.udongzip.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.udongzip.chat.model.service.ChatService;
import com.kh.udongzip.chat.model.vo.ChatMessage;
import com.kh.udongzip.chat.model.vo.ChatRoom;
import com.kh.udongzip.common.security.Auth;
import com.kh.udongzip.common.security.Auth.Role;
import com.kh.udongzip.member.model.vo.Member;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	// private Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Auth(role=Role.LOGINUSER)
	@RequestMapping("chatting.do")
	public String chat() {
		
		// logger.info("[Controller] : chatting.do");
		
		return "user/chat/ChatRoomListView";
	}
	@Auth(role=Role.LOGINUSER)
	@ResponseBody
	@PostMapping(value="listview.ch", produces="application/json; charset=UTF-8")
	public String ajaxselectChatRoomList(int userNo, String identifier, String userId) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("identifier", identifier);
		map.put("userId", userId);
		// 넘겨야할 값이 여러개일 경우
		// 마땅히 가공할 VO 객체가 없을 때 HashMap으로 가공하면 된다.
		// VO 로 가공했을 경우 => 필드명 - 필드값
		// HashMap 으로 가공했을 경우 => 키값 - 벨류값
		// HashMap으로 가공한거 서비스로 넘기기
		
		ArrayList<ChatRoom> list =  chatService.selectChatRoomList(map);
		// map 으로 DB찍고 온 데이터 ChatRoom list에 담기(화면목록을 보여주기위해(select) ajax로넘긴 값들 map으로 담아서 처리)
		
		for(ChatRoom c : list) { 
			// UnReadCount(읽음,안읽음 처리를 위한 처리) 
			// 향상된 for문 list에 있는 값들 ChatRoom c 에 담아서 반복돌림
			
			map.put("chatRoomNo", c.getChatRoomNo());
			int unreadCount = chatService.selectUnReadCount(map);
			c.setUnReadCount(unreadCount);
			// map에 키값 방번호로 밸류 ChatRoom에 담긴 방번호 불러오고
			//(1인지 2인지 확인하기위해 (1:안읽음) / (2:안읽음) 정수로 담아서  map을 넣고 DB까지 찍기
			// DB까지 찍고온 unReadCount set으로 넣은 후 리턴
		}
		
		return new Gson().toJson(list);
	}
	@Auth(role=Role.LOGINUSER)
	@ResponseBody
	@PostMapping(value="listdetail.ch", produces="application/json; charset=UTF-8")
	public String ajaxselectChatMessageList(int chatRoomNo, String userId) {
		// ajax에서 전체메세지조회랑 안읽음 메세지를 읽음으로 변경하기 위해 방번호,userId 를 넘겨옴
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("chatRoomNo", chatRoomNo);
		map.put("userId", userId);
		
		ArrayList<ChatMessage> list = chatService.selectChatMessageList(chatRoomNo);
		// 전체 메세지 조회를 위한 방번호를 넘겨서 DB를 찍고 list에 담아옴
		
		if(list != null) {
			// DB에 찍고 담긴 list가 null이 아닐경우 
			
			int updateUnRead = chatService.updateUnRead(map);
			// 수정된 updateUnRead Db로 찍고와서 리턴 
		}
		
		return new Gson().toJson(list);
	}
	@Auth(role=Role.LOGINUSER)
	@RequestMapping("newch.ch")
	public String NewChatRoom(int agentNo, HttpSession session) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("agentNo", agentNo);
		map.put("memberNo", ((Member)session.getAttribute("loginUser")).getMemberNo());
		
		int selectChatRoom = chatService.selectChatRoom(map);
		
		if(selectChatRoom == 0) {
			int createChatRoom = chatService.createChatRoom(map);
		}
		System.out.println(selectChatRoom);
		
		return "redirect:chatting.do";
	}
	
}