package com.suwon.ezen.service;

import java.util.List;

import com.suwon.ezen.vo.ProductVO;

public interface ProductService {
	
	public void productInsert(ProductVO vo);
	
	public void imageInsert(ProductVO vo);
	
	public int productCount();
	
	public List<ProductVO> productList(int offset);
	
	public ProductVO getProduct(int pno);
	
	public void productUpdate(ProductVO vo);
	
	public void deleteProduct(int pno);
	
	public List<ProductVO> getProductsbyCategory(String category, int offset);
	
	public int getCountbyCategory(String category);
	
	// Top6
	public List<ProductVO> findTop6Product();
}
