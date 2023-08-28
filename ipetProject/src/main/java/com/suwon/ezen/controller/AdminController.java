package com.suwon.ezen.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.suwon.ezen.service.AdminService;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.Paging;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

import lombok.Setter;
@RestController
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ =@Autowired )
	private AdminService service;
	
	@GetMapping("/member")
	public ModelAndView member(Integer pageNum, ModelAndView mav, HttpServletRequest req) {
		Paging paging = new Paging(service.getMemberCount(),pageNum);
		mav.addObject("memberList", service.getMemberList(paging.getOffset()));
		mav.addObject("paging", paging);
		mav.addObject("index", 0);
		mav.setViewName("/admin/member");
		
		return mav;
	}
	@GetMapping("/update")
	public ModelAndView update(int mno,ModelAndView mav) {
		MemberVO vo = service.getByMno(mno);
		mav.addObject("member", vo);
		mav.addObject("index", 0);
		mav.setViewName("/admin/update");
		return mav;
	}
	
	@Transactional
	@PutMapping("/update")
	public ResponseEntity<Map<String, String>> updateComplete(@RequestBody MemberVO vo){
		System.out.println("데이터 확인 : "+ vo);
		int result = service.memberUpdate(vo);
		Map<String,String> map = new HashMap<>();
		if(result==1)map.put("message", "고객 번호: "+vo.getMno()+"번 수정 완료");
		else map.put("message", "수정실패");
		return new ResponseEntity<>(map,HttpStatus.OK);
			
	}
	@Transactional
	@DeleteMapping("/delete/{mno}")
	public ResponseEntity<Map<String, String>> delete(@PathVariable("mno")int mno){
		System.out.println("데이터 확인 : "+ mno);
		Map<String,String> map = new HashMap<>();
		int result = service.delete(mno);
		if(result==1)map.put("message", "고객 번호: "+mno+"번 삭제 완료");
		else map.put("message", "삭제 실패");
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	 @GetMapping("/productList") public ModelAndView productList(ModelAndView
		mav,@Param("pageNum")Integer pageNum)  {
		mav.addObject("index", 1);
		Paging paging = new	Paging(service.productCount(), pageNum); mav.addObject("paging", paging);
		mav.addObject("productList", service.productList(paging.getOffset()));
		mav.setViewName("/admin/productList"); return mav; 
	 }
	
	@GetMapping("/productInsert")
	public ModelAndView goProductInsert(ModelAndView mav) {
		mav.addObject("index", 1);
		mav.setViewName("/admin/productInsert");
		return mav;
	}
	@GetMapping("/productsUpdate")
	public ModelAndView goUpdate(@Param("pno") int pno,ModelAndView mav) {
		mav.addObject("index", 1);
		ProductVO vo = service.getProduct(pno);
		mav.addObject("vo", vo);
		mav.setViewName("/admin/productUpdate");
		return mav;
	}
	
	
	@Transactional
	@PostMapping("/productsUpdate")
	public  ResponseEntity<Map<String, String>> productUpdate(@ModelAttribute ProductVO vo) throws IllegalStateException, IOException {
		
		System.out.println("originalFileName : " + vo.getImg().getOriginalFilename());
		
		if(vo.getImg().getOriginalFilename() != null && !vo.getImg().getOriginalFilename().isEmpty()) {
			String id = vo.getId();
			String imageName = id+vo.getPno()+vo.getImg().getOriginalFilename().substring(vo.getImg().getOriginalFilename().length()-4, vo.getImg().getOriginalFilename().length());
			MultipartFile m_file = vo.getImg();
			String imagePath="C:\\Users\\upload\\productImage";
			
			vo.setImageName(imageName);
			vo.setImagePath(imagePath);
			service.imageInsert(vo);
			service.productUpdate(vo);
			m_file.transferTo(new File(vo.getImagePath(),vo.getImageName()));
		}else {
			System.out.println(vo.getPno());
			service.productUpdate(vo);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "성공");
		
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
	@DeleteMapping("/productDelete")
	public ResponseEntity<Map<String,String>> productDelete(@Param("pno") int pno,
			@Param("imageName")String imageName) throws IOException{
			
		
		Map<String,String> map = new HashMap<String, String>();
		service.deleteProduct(pno);
		service.deleteCart(pno);
		File file = new File("C:\\Users\\upload\\productImage\\"+imageName);
		    	if( file.exists() ){
		    		if(file.delete()){
		    			System.out.println("파일삭제 성공");
		    		}else{
		    			System.out.println("파일삭제 실패");
		    		}
		    	}else{
		    		System.out.println("파일이 존재하지 않습니다.");
		    	}
        	
	
		map.put("result", "삭제 되었습니다");
		
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
	@GetMapping(value = "/history")
	public ModelAndView getHistory(Integer pageNum,ModelAndView mav,String delivery) {
		PurchaseVO vo = new PurchaseVO();
		vo.setDelivery(delivery);
		Paging paging = new Paging(service.getAllCountPurchase(vo),pageNum);
		Integer offset = paging.getOffset();
		vo.setOffset(offset);
		mav.addObject("purchaseList", service.getAllPurchaseList(vo));
		mav.addObject("paging", paging);
		if(delivery != null) mav.addObject("delivery", delivery);
		mav.setViewName("/admin/history");
		mav.addObject("index", 3);
		return mav;
	}

	@Transactional
	@PostMapping(value = "/changeDelivery",produces = "application/text; charset=utf8")
	public ResponseEntity<String> changeDelivery(PurchaseVO vo){
		service.changeDelivery(vo.getPurchaseNo(), vo.getDelivery());
		return new ResponseEntity<String>("배송 현황이 변경 되었습니다.",HttpStatus.OK);
	}
	@GetMapping(value = "/sales")
	public ModelAndView goSales(ModelAndView mav) {
		mav.setViewName("/admin/sales");
		Gson gsonObj = new Gson();
		
		Map<Object,Object> map = null;
		List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		float calc = service.getCountCategory("food")+service.getCountCategory("pad")+service.getCountCategory("bath");
		map = new HashMap<Object,Object>(); map.put("label", "사료/간식"); map.put("y", String.format("%.2f",service.getCountCategory("food")/calc*100)); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "패드/장난감"); map.put("y", String.format("%.2f",service.getCountCategory("pad")/calc*100)); list.add(map);
		map = new HashMap<Object,Object>(); map.put("label", "목욕/하네스"); map.put("y", String.format("%.2f",service.getCountCategory("bath")/calc*100)); list.add(map);
		 
		String dataPoints = gsonObj.toJson(list);
		
		
		List<Map<Object,Object>> list2 = new ArrayList<Map<Object,Object>>();
		Map<Object,Object> map2 = null;
		
		for(Map ob : service.getTop5()) {
			map2 = new HashMap<Object,Object>(); map2.put("label", ob.get("pname")); map2.put("y", ob.get("amount")); list2.add(map2);
		}
		
		String dataPoints2 = gsonObj.toJson(list2);
		
		
		Map<Object,Object> map3 = null;
		List<Map<Object,Object>> list3 = new ArrayList<Map<Object,Object>>();
		System.out.println(service.getSalesRate());
		for(Map ob : service.getSalesRate()) {
			map3 = new HashMap<Object,Object>(); map3.put("label", ob.get("paydate")); map3.put("y", ob.get("sales")); list3.add(map3);	
		}
		
		String dataPoints3 = gsonObj.toJson(list3);
		
		Map<Object,Object> map4 = null;
		List<Map<Object,Object>> list4 = new ArrayList<Map<Object,Object>>();
		System.out.println(service.getCreateRate());
		for(Map ob : service.getCreateRate()) {
			map4 = new HashMap<Object,Object>(); map4.put("label", ob.get("createdate")); map4.put("y", ob.get("regmember")); list4.add(map4);	
		}
		
		String dataPoints4 = gsonObj.toJson(list4);
		
		mav.addObject("dataPoints", dataPoints);
		mav.addObject("dataPoints2", dataPoints2);
		mav.addObject("dataPoints3", dataPoints3);
		mav.addObject("dataPoints4", dataPoints4);
		return mav;
	}
	@GetMapping(value = "/makeImage", produces = "application/text; charset=utf8")
	public ResponseEntity<String> makeImg(String img,HttpSession session) {
		RestTemplate restTemplate = new RestTemplate();

		// Prepare the request headers and body
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
		map.add("key1", img);
		map.add("key2", vo.getId());
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

		// Send the request and retrieve the response
		ResponseEntity<String> response = restTemplate.exchange("http://localhost:5500/makeImage", HttpMethod.POST, request, String.class);

		// Handle the response as needed
		String responseBody = response.getBody();
		System.out.println(responseBody);
		
		return new ResponseEntity<String>(responseBody,HttpStatus.OK);
	}
	@GetMapping("/qna")
	public ModelAndView goQna(ModelAndView mav,@Param("readCheck")String readCheck,
			@Param("pageNum")Integer pageNum) {
		mav.addObject("index", 2);
		if(readCheck != null && readCheck !="") {
			Paging paging = new Paging(service.getMemberCountUnReadChat(),pageNum);
			int offset = paging.getOffset();
			mav.addObject("chatList", service.getMemberUnReadChat(offset));
			mav.addObject("readCheck", readCheck);
			mav.addObject("paging", paging);
		}else {
			Paging paging = new Paging(service.getMemberCountLastChat(),pageNum);
			int offset = paging.getOffset();
			mav.addObject("chatList", service.getMemberLastChat(offset));
			mav.addObject("paging", paging);
		}
		
		mav.setViewName("/admin/qna");
		return mav;
	}
	@GetMapping("/answerQna")
	public ModelAndView asnwerQna(ModelAndView mav,@Param("id") String id,HttpSession session) {
		service.readChat(id);
		session.setAttribute("targetId", id);
		mav.setViewName("/member/chat");
		return mav;
	}
	@DeleteMapping(value = "/deleteQna",produces = "application/text; charset=utf8")
	public ResponseEntity<String> deleteQna(@Param("id") String id) {
		service.deleteQna(id);
		return new ResponseEntity<String>("삭제 됐습니다.",HttpStatus.OK);
	}
}
