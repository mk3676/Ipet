package com.suwon.ezen.controller;



import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.BoardService;
import com.suwon.ezen.service.ProductService;
//import com.suwon.ezen.service.ProductService;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.Paging;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/ipet/*")
@Log4j
public class IpetController {

	@Setter(onMethod_ = @Autowired)
	private BoardService bservice;
	
	@Setter(onMethod_ = @Autowired)
	private ProductService pservice;
	
	@GetMapping(value = "/index")
	public ModelAndView index(ModelAndView mnv) {
		mnv.addObject("index", 1);
		mnv.addObject("productList", pservice.findTop6Product());
		mnv.setViewName("index");
		
		return mnv;
	}
	@GetMapping(value = "/pro")
	public void pro(ModelAndView mnv, HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/products/food");
		rd.forward(request, response);
		
	}
	@GetMapping(value = "/hos")
	public ModelAndView hos(ModelAndView mnv) {
		mnv.addObject("index", 3);
		mnv.setViewName("hospital");
		return mnv;
	}
	
	@GetMapping(value = "/community")
	public ModelAndView commu(ModelAndView mnv, @Param("pageNum") Integer pageNum, @Param("searchOption") String searchOption, @Param("searchCondition") String searchCondition) {
		if (searchOption == null || searchOption.equals("")) {
			Paging paging = new Paging(bservice.getCount(), pageNum);
			List<BoardVO> boardList = bservice.getAllContent(paging.getOffset());
			mnv.addObject("list", boardList);
			mnv.addObject("paging", paging);
		}
		else {
			BoardVO vo = new BoardVO();
			vo.setSearchOption(searchOption);
			vo.setSearchCondition(searchCondition);
			Paging paging = new Paging(bservice.searchListCount(vo), pageNum);
			vo.setOffset(paging.getOffset());
			mnv.addObject("paging", paging);
			mnv.addObject("list", bservice.searchList(vo));
			mnv.addObject("searchOption", vo.getSearchOption());
			mnv.addObject("searchCondition", vo.getSearchCondition());
		}
		
		
		
		
		mnv.addObject("index", 4);
		mnv.setViewName("/board/community");
		return mnv;
	}
	
	// 이미지 보여주기
	@GetMapping("/displayProductImage")
	@ResponseBody
	public  ResponseEntity<byte[]> getContentFile(String imageName) { 
		log.info("upload controller file display: " + imageName);
		File file = new File("C:\\Users\\upload\\productImage\\" + imageName);
		log.info("file 객체 : "+ file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
