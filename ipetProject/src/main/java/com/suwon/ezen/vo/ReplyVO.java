package com.suwon.ezen.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReplyVO {
	private int bno;
	private int rno;
	private String id;
	private String reply;
	private Date replyDate;
	private List<MultipartFile> imgList;
    private String imagePath;
    private String imageName;
}
