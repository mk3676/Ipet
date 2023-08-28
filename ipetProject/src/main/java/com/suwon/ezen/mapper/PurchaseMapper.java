package com.suwon.ezen.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.PurchaseVO;

public interface PurchaseMapper {
	public void purchase(PurchaseVO vo);
	
	public List<PurchaseVO> getPurchaseList(@Param("mno")int mno,@Param("offset")int offset);
	
	public int getCountPurchase(int mno);
	
	public List<PurchaseVO> getAllPurchaseList(PurchaseVO vo);
	
	public int getAllCountPurchase(PurchaseVO vo);
	
	public void changeDelivery(@Param("purchaseNo")int purchaseNo,@Param("delivery")String delivery);
	
	public int getCountCategory(String category);
	
	public List<Map<String,Object>> getTop5();
	
	public List<Map<String,Object>> getSalesRate();
}
