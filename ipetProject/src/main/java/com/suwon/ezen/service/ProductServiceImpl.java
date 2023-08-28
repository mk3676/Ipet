package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.ProductMapper;
import com.suwon.ezen.vo.ProductVO;

import lombok.Setter;

@Service
public class ProductServiceImpl implements ProductService {
	@Setter(onMethod_ =@Autowired )
	private ProductMapper mapper;
	
	@Override
	public void productInsert(ProductVO vo) {
		
		 mapper.productInsert(vo);
	}

	@Override
	public void imageInsert(ProductVO vo) {
		mapper.imageInsert(vo);
		
	}

	@Override
	public int productCount() {
		
		return mapper.productCount();
	}

	@Override
	public List<ProductVO> productList(int offset) {
		
		return mapper.productList(offset);
	}

	@Override
	public ProductVO getProduct(int pno) {
		
		return mapper.getProduct(pno);
	}

	@Override
	public void productUpdate(ProductVO vo) {
		mapper.productUpdate(vo);
		
	}

	@Override
	public void deleteProduct(int pno) {
		mapper.deleteProduct(pno);
		
	}

	@Override
	public List<ProductVO> getProductsbyCategory(String category, int offset) {
		 
		return mapper.getProductsbyCategory(category, offset);
	}

	@Override
	public int getCountbyCategory(String category) {
		 
		return mapper.getCountbyCategory(category);
	}

	// Top6
	@Override
	public List<ProductVO> findTop6Product() {
		return mapper.findTop6Product();
	}
	
}
