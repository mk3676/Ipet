package com.suwon.ezen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.CartVO;

public interface CartMapper {
	
	public void insertCart(CartVO vo);
	
	public List<CartVO> getCartList(@Param("mno")int mno,@Param("offset")int offset);
	
	public int getCountCart(int mno);
	
	public void deleteCart(int pno);
	
	public String checkCart(@Param("mno") int mno, @Param("pno") int pno);
	
	public void deleteCartFromMno(@Param("mno") int mno, @Param("pno") int pno);
	
	public void deleteCartAll(int mno);

}
