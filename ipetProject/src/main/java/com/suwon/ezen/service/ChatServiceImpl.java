package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.ChatMapper;
import com.suwon.ezen.vo.ChatVO;

import lombok.Setter;

@Service
public class ChatServiceImpl implements ChatSerivce{
	@Setter(onMethod_ =@Autowired )
	private ChatMapper mapper;
	
	@Override
	public List<ChatVO> getMemberLastChat(int offset) {
		// TODO Auto-generated method stub
		return mapper.getMemberLastChat(offset);
	}

}
