package com.suwon.ezen.service;

import java.util.List;
import java.util.Map;

import org.python.jline.internal.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.CartMapper;
import com.suwon.ezen.mapper.MemberMapper;
import com.suwon.ezen.mapper.ProductMapper;
import com.suwon.ezen.mapper.PurchaseMapper;
import com.suwon.ezen.vo.CartVO;
import com.suwon.ezen.vo.EmailAuthVO;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_ =@Autowired )
	private MemberMapper mapper;
	
	@Setter(onMethod_ =@Autowired )
	private ProductMapper productMapper;
	
	@Setter(onMethod_ =@Autowired )
	private CartMapper cartMapper;
	
	@Setter(onMethod_ =@Autowired )
	private PurchaseMapper purchaseMapper;
	
	@Override
	public MemberVO login(MemberVO vo) {
		MemberVO getVO = mapper.checkIdDupli(vo.getId());
		return getVO;
	}
	
	@Override
	public MemberVO checkIdDupli(String id) {
		MemberVO result = mapper.checkIdDupli(id);
		System.out.println("서비스단 : "+result);
		return result;
	}

	@Override
	public int regist(MemberVO vo) {
		int result = mapper.register(vo);
		Log.info("회원정보 저장 완료" + result);
	
		return result;
	}
	// 이메일과 인증번호를 서버에 저장
	@Override
	public void insertAuth(EmailAuthVO vo) {
		mapper.insertAuth(vo);
	}

	// 이메일을 조건으로 하여 인증 번호를 가져온다.
	@Override
	public String selectAuth(String email) {
		String auth = mapper.selectAuth(email);
		
		return auth;
	}

	// 이메일을 조건으로 하여 인증 번호를 삭제한다.
	@Override
	public void deleteAuth(String email) {
		mapper.deleteAuth(email);
	}
	
	// 회원 정보 가져오기
	@Override
	public List<MemberVO> getMemberList(int offset) {
		return mapper.getMemberList(offset);
	}
	// 총 회원수
	@Override
	public int getMemberCount() {
		return mapper.getMemberCount();
	}

	@Override
	public MemberVO getByMno(int mno) {
		 
		return mapper.getByMno(mno);
	}

	@Override
	public int update(MemberVO vo) {
		
		return mapper.update(vo);
	}

	@Override
	public int delete(int mno) {
		 
		return mapper.delete(mno);
	}

	@Override
	public String getId(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.getId(vo);
	}

	@Override
	public MemberVO checkMember(MemberVO vo) {
		 
		return mapper.checkMember(vo);
	}

	@Override
	public void updatePwd(MemberVO vo) {
		System.out.println(vo.getPassword());
		mapper.updatePwd(vo);
		
	}

	@Override
	public String searchAuth(String email) {
		 
		return mapper.searchAuth(email);
	}

	@Override
	public ProductVO getProduct(int pno) {
		// TODO Auto-generated method stub
		return productMapper.getProduct(pno);
	}

	@Override
	public void insertCart(CartVO vo) {
		cartMapper.insertCart(vo);
		
	}

	@Override
	public List<CartVO> getCartList(int mno,int offset) {
	
		return cartMapper.getCartList(mno,offset);
	}

	@Override
	public int getCountCart(int mno) {
		
		return cartMapper.getCountCart(mno);
	}

	@Override
	public String checkCart(int mno, int pno) {
	
		return cartMapper.checkCart(mno, pno);
	}

	@Override
	public void deleteCartFromMno(int mno, int pno) {
		cartMapper.deleteCartFromMno(mno, pno);
		
	}

	@Override
	public void purchase(PurchaseVO vo) {
		 purchaseMapper.purchase(vo);
		
	}

	@Override
	public void deleteCartAll(int mno) {
		// TODO Auto-generated method stub
		cartMapper.deleteCartAll(mno);
	}

	@Override
	public List<PurchaseVO> getPurchaseList(int mno, int offset) {
		// TODO Auto-generated method stub
		return purchaseMapper.getPurchaseList(mno, offset);
	}

	@Override
	public int getCountPurchase(int mno) {
		// TODO Auto-generated method stub
		return purchaseMapper.getCountPurchase(mno);
	}

	@Override
	public List<Map<String, Object>> getCreateRate() {
		// TODO Auto-generated method stub
		return mapper.getCreateRate();
	}

	

}
