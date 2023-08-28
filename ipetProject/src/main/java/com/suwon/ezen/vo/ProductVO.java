package com.suwon.ezen.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProductVO {
	
	private int pno;
	private String id;
	private String category;
	private String pname;
	private String price;
	private String description;
	private MultipartFile img;
	private Date regtime;
	private Date updateTime;
	private String imageName;
	private String imagePath;
}