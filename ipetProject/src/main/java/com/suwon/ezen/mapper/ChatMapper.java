package com.suwon.ezen.mapper;

import java.util.List;

import com.suwon.ezen.vo.ChatVO;

public interface ChatMapper {
	
	public void insertChat(ChatVO vo);
	
	public List<ChatVO> getMemberLastChat(int offset);
	
	public List<String> getChatList(String id);
	
	public void readChat(String id);
	
	public List<ChatVO> getMemberUnReadChat(int offset);
	
	public int getMemberCountLastChat();
	
	public int getMemberCountUnReadChat();
	
	public void deleteQna(String id);
}
