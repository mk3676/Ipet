package com.suwon.ezen.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.CartVO;
import com.suwon.ezen.vo.EmailAuthVO;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

public interface MemberService {
	public MemberVO login(MemberVO vo);
	public MemberVO checkIdDupli(String id);
	public int regist(MemberVO vo);
	// 이메일과 인증번호를 서버에 저장
	public void insertAuth(EmailAuthVO vo);
	
	// 이메일을 조건으로 하여 인증 번호를 가져온다.
	public String selectAuth(String email);
	
	// 이메일을 조건으로 하여 인증 번호를 삭제한다.
	public void deleteAuth(String email);
	
	//회원 정보 가져오기
	public List<MemberVO> getMemberList(int offset);
	
	//총 회원수
	public int getMemberCount();
	
	//mno로 회원정보 가져오기
	public MemberVO getByMno(int mno);
	
	//회원정보 수정
	public int update(MemberVO vo);
	
	public int delete(int mno);
	
	// 이름과 이메일을 사용해 id 가져오기
	public String getId(MemberVO vo);
	
	// 아이디와 이메일을 사용하여 회원정보 있는지 확인
	public MemberVO checkMember(MemberVO vo);
	
	// 아이디와 이메일을 체크후 비밀번호 변경
		public void updatePwd(MemberVO vo);
	
	public String searchAuth(String email);
	
	public ProductVO getProduct(int pno);
	
	public void insertCart(CartVO vo);
	
	public List<CartVO> getCartList(int mno,int offset);
	
	public int getCountCart(int mno);
	
	public String checkCart(int mno, int pno);
	
	public void deleteCartFromMno(int mno, int pno);
	
	public void purchase(PurchaseVO vo);
	
	public void deleteCartAll(int mno);
	
	public List<PurchaseVO> getPurchaseList(@Param("mno")int mno,@Param("offset")int offset);
	
	public int getCountPurchase(int mno);
	
	public List<Map<String,Object>> getCreateRate(); 
	
}
