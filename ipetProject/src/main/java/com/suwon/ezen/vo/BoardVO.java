package com.suwon.ezen.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private List<MultipartFile> imgList;
    private String imagePath;
    private String imageName;
    
    private String searchOption;
    private String searchCondition;
    
    private int offset;
}
