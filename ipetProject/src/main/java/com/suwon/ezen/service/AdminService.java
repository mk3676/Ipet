package com.suwon.ezen.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.ChatVO;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

public interface AdminService {
	//회원 정보 가져오기
	public List<MemberVO> getMemberList(int offset);
	//총 회원수
	public int getMemberCount();
	
	public MemberVO getByMno(int mno);
	
	public int memberUpdate(MemberVO vo);
	
	public int delete(int mno);
	
	public int productCount();
	
	public List<ProductVO> productList(int offset);
	
	public ProductVO getProduct(int pno);
	
	public void productUpdate(ProductVO vo);
	
	public void imageInsert(ProductVO vo);
	
	public void deleteProduct(int pno);
	
	public void deleteCart(int pno);
	
	public List<PurchaseVO> getAllPurchaseList(PurchaseVO vo);
	
	public int getAllCountPurchase(PurchaseVO vo);
	
	public void changeDelivery(int purchaseNo, String delivery);
	
	public int getCountCategory(String category);
	
	public List<Map<String,Object>> getTop5();
	
	public List<Map<String,Object>> getSalesRate();
	
	public List<Map<String,Object>> getCreateRate();
	
	public List<ChatVO> getMemberLastChat(int offset);
	
	public void readChat(String id);
	
	public List<ChatVO> getMemberUnReadChat(int offset);
	
	public int getMemberCountLastChat();
	
	public int getMemberCountUnReadChat();

	public void deleteQna(String id);
}
