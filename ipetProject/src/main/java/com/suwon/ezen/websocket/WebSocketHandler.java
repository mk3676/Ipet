package com.suwon.ezen.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.suwon.ezen.mapper.ChatMapper;
import com.suwon.ezen.vo.ChatVO;
import com.suwon.ezen.vo.MemberVO;

import lombok.Setter;

@Component
public class WebSocketHandler extends TextWebSocketHandler{
	private List<WebSocketSession> users;
	
	private Map<String, Object> userMap;
	
	@Setter(onMethod_ = @Autowired)
	private ChatMapper mapper;
	
	public WebSocketHandler() {
		users = new ArrayList<WebSocketSession>();
		userMap = new HashMap<String, Object>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("웹소켓 연결 생성");
		users.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("웹 소켓 메세지 수신");
		System.out.println("메세지 : " + message.getPayload());
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		
		if(type != null && type.equals("register")) {
			String user = object.getString("userid");
			userMap.put(user, session);
			if(!object.getString("targetId").equals("admin")) {
				String id = object.getString("targetId");
				WebSocketSession ws = (WebSocketSession) userMap.get(user);
				List<String> getMsg = mapper.getChatList(id);
				if(ws != null) {
					for(String msg : getMsg) {
						ws.sendMessage(new TextMessage(msg));
					}
				}
				
			}
		}else{
			String target = object.getString("target");
			if(!target.equals("admin")) {
				mapper.readChat(target);
			}else {
				ChatVO vo = new ChatVO(); 
				vo.setId(object.getString("userid"));
				vo.setContents(object.getString("message"));
				mapper.insertChat(vo);
			}
			
			WebSocketSession ws = (WebSocketSession) userMap.get(target);
			String msg = object.getString("message");
			if(ws != null) {
				ws.sendMessage(new TextMessage(msg));
			}
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 해제");
		users.remove(session);
	}
	
	
	
	
    
}
