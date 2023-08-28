package com.suwon.ezen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.ProductVO;

public interface ProductMapper {
	
	public void productInsert(ProductVO vo);
	
	public void imageInsert(ProductVO vo);
	
	public List<ProductVO> productList(int offset);
	
	public int productCount();
	
	public ProductVO getProduct(int pno);
	
	public void updateWithImage(ProductVO vo);
	
	public void productUpdate(ProductVO vo);
	
	public void deleteProduct(int pno);
	
	public List<ProductVO> getProductsbyCategory(@Param("category")String category,@Param("offset")int offset);
	
	public int getCountbyCategory (String category);
	
	// Top6
	public List<ProductVO> findTop6Product();
}
