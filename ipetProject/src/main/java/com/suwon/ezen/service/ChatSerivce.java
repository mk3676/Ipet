package com.suwon.ezen.service;

import java.util.List;

import com.suwon.ezen.vo.ChatVO;

public interface ChatSerivce {
	public List<ChatVO> getMemberLastChat(int offset);
}
