package com.suwon.ezen.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.CartMapper;
import com.suwon.ezen.mapper.ChatMapper;
import com.suwon.ezen.mapper.PurchaseMapper;
import com.suwon.ezen.vo.ChatVO;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

import jdk.jfr.SettingDefinition;
import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService{

	@Setter(onMethod_ =@Autowired )
	private MemberService memberService;
	
	@Setter(onMethod_ =@Autowired )
	private ProductService productService;
	
	@Setter(onMethod_ =@Autowired )
	private CartMapper cartMapper;
	
	@Setter(onMethod_ =@Autowired )
	private PurchaseMapper purchaseMapper;
	
	@Setter(onMethod_ =@Autowired )
	private ChatMapper chatMapper;
	// 고객 정보 가져오기
	@Override
	public List<MemberVO> getMemberList(int offset) {
		return memberService.getMemberList(offset);
	}
	//총 고객갯수 가져오기
	@Override
	public int getMemberCount() {
		return memberService.getMemberCount();
	}
	//mno로 회원 정보 가져오기
	@Override
	public MemberVO getByMno(int mno) {
		 
		return memberService.getByMno(mno);
	}
	
	@Override
	public int memberUpdate(MemberVO vo) {
		
		return memberService.update(vo);
	}
	@Override
	public int delete(int mno) {
		 
		return memberService.delete(mno);
	}
	@Override
	public int productCount() {
		
		return productService.productCount();
	}
	@Override
	public List<ProductVO> productList(int offset) {
		
		return productService.productList(offset);
	}
	@Override
	public ProductVO getProduct(int pno) {
		
		return productService.getProduct(pno);
	}
	@Override
	public void productUpdate(ProductVO vo) {
		productService.productUpdate(vo);
		
	}
	@Override
	public void imageInsert(ProductVO vo) {
		productService.imageInsert(vo);
		
	}
	@Override
	public void deleteProduct(int pno) {
		productService.deleteProduct(pno);
		
	}
	@Override
	public void deleteCart(int pno) {
		cartMapper.deleteCart(pno);
		
	}
	@Override
	public List<PurchaseVO> getAllPurchaseList(PurchaseVO vo) {
		// TODO Auto-generated method stub
		return purchaseMapper.getAllPurchaseList(vo);
	}
	@Override
	public int getAllCountPurchase(PurchaseVO vo) {
		// TODO Auto-generated method stub
		return purchaseMapper.getAllCountPurchase(vo);
	}
	@Override
	public void changeDelivery(int purchaseNo, String delivery) {
		 purchaseMapper.changeDelivery(purchaseNo, delivery);
		
	}
	@Override
	public int getCountCategory(String category) {
		
		return purchaseMapper.getCountCategory(category);
	}
	@Override
	public List<Map<String, Object>> getTop5() {
		// TODO Auto-generated method stub
		return purchaseMapper.getTop5();
	}
	@Override
	public List<Map<String,Object>> getSalesRate() {
		// 
		return purchaseMapper.getSalesRate();
	}
	@Override
	public List<Map<String, Object>> getCreateRate() {
		 
		return memberService.getCreateRate();
	}
	@Override
	public List<ChatVO> getMemberLastChat(int offset) {
		// TODO Auto-generated method stub
		return chatMapper.getMemberLastChat(offset);
	}
	@Override
	public void readChat(String id) {
		// TODO Auto-generated method stub
		chatMapper.readChat(id);
	}
	@Override
	public List<ChatVO> getMemberUnReadChat(int offset) {
		// TODO Auto-generated method stub
		return chatMapper.getMemberUnReadChat(offset);
	}
	@Override
	public int getMemberCountLastChat() {
		// TODO Auto-generated method stub
		return chatMapper.getMemberCountLastChat();
	}
	@Override
	public int getMemberCountUnReadChat() {
		// TODO Auto-generated method stub
		return chatMapper.getMemberCountUnReadChat();
	}
	@Override
	public void deleteQna(String id) {
		// TODO Auto-generated method stub
		chatMapper.deleteQna(id);
	}

}
