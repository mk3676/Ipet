package com.suwon.ezen.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatVO {
	private String id;
	private String contents;
	private Date insertDate;
	private String readCheck;
}
