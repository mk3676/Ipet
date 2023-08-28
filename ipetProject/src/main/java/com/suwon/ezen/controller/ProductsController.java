package com.suwon.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.ProductService;
import com.suwon.ezen.vo.Paging;
//import com.suwon.ezen.service.ProductService;
import com.suwon.ezen.vo.ProductVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/products/*")
@Log4j
public class ProductsController {

	@Setter(onMethod_ = @Autowired)
	private ProductService service;
	

	@GetMapping(value = "/food")
	public ModelAndView petFood(ModelAndView mnv, Integer pageNum) {
		Paging paging = new Paging(service.getCountbyCategory("food"), pageNum);
		mnv.addObject("index", 2);
		mnv.addObject("paging", paging);
		mnv.addObject("foodList", service.getProductsbyCategory("food", paging.getOffset()));
		mnv.setViewName("/products/food");
		return mnv;
	}
	@GetMapping(value = "/pad")
	public ModelAndView petPad(ModelAndView mnv, Integer pageNum) {
		Paging paging = new Paging(service.getCountbyCategory("pad"), pageNum);
		mnv.addObject("index", 2);
		mnv.addObject("paging", paging);
		mnv.addObject("foodList", service.getProductsbyCategory("pad", paging.getOffset()));
		mnv.setViewName("/products/pad");
		return mnv;
	}
	@GetMapping(value = "/bath")
	public ModelAndView petBath(ModelAndView mnv, Integer pageNum) {
		Paging paging = new Paging(service.getCountbyCategory("bath"), pageNum);
		mnv.addObject("index", 2);
		mnv.addObject("paging", paging);
		mnv.addObject("foodList", service.getProductsbyCategory("bath", paging.getOffset()));
		mnv.setViewName("/products/bath");
		return mnv;
	}

	@Transactional
	@PostMapping(value = "/productRegist")
	public ResponseEntity<Map<String, String>> regist(@ModelAttribute ProductVO vo) throws IllegalStateException, IOException {
		System.out.println("vo : " + vo);
		
		service.productInsert(vo);
		if(vo.getImg().getOriginalFilename() != null && !vo.getImg().getOriginalFilename().isEmpty()) {
			System.out.println("이미지 들어옴 ");
			int pno = vo.getPno();
			String id = vo.getId();
			String imageName = id+pno+vo.getImg().getOriginalFilename().substring(vo.getImg().getOriginalFilename().length()-4, vo.getImg().getOriginalFilename().length());
			System.out.println(imageName);
			MultipartFile m_file = vo.getImg();
			String imagePath="C:\\Users\\upload\\productImage";
		
			vo.setPno(pno);
			vo.setImageName(imageName);
			vo.setImagePath(imagePath);
			service.imageInsert(vo);
			m_file.transferTo(new File(vo.getImagePath(),vo.getImageName()));
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "성공");
		
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
	@GetMapping("/read")
	public ModelAndView readProduct(@Param("pno")int pno,ModelAndView mav) {
		mav.addObject("product",service.getProduct(pno));
		mav.setViewName("/products/readProduct");
		mav.addObject("index", 2);
		return mav;
	}


}