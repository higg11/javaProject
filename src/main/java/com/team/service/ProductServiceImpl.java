package com.team.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.domain.PageDTO;
import com.team.domain.ProdPageDTO;
import com.team.domain.ProductDTO;
import com.team.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper mapper;
	
	////////////////////// 관리자 모드 ////////////////////////
	// 상품 등록
	@Override
	public void prodRegister(Map map) {
		mapper.prodInsert(map);
	}
	
	/*
	 * // 상품 리스트
	 * 
	 * @Override public List<ProductDTO> productList() {
	 * 
	 * return mapper.productList(); }
	 */
	
	// 상품 리스트
	@Override
	public List<ProductDTO> productList(PageDTO pDto) {
		int totalCnt = mapper.totalCnt(pDto);
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
		return mapper.productList(pDto);
	}
	
	// 재고 상품
	@Override
	public List<ProductDTO> stockList() {
		
	    return mapper.stockList();
	}
	
	/*
	 * // 홈화면 상품 리스트
	 * 
	 * @Override public List<ProductDTO> homeProductList(ProdPageDTO pDto) {
	 * 
	 * int totalCnt = mapper.totalCnt(pDto); pDto.setValue(totalCnt,
	 * pDto.getCntPerPage());
	 * 
	 * return mapper.homeProductList(pDto); }
	 */
	
	// 상품 삭제
	@Override
	public void deleteProduct(int pnum) {
		mapper.deleteProduct(pnum);		
	}	
	
	// 상품정보 가져오기
	@Override
	public ProductDTO getProduct(int pnum) {
		
		return mapper.getProduct(pnum);
	}

	// 상품 수정하기
	@Override
	public void updateProduct(Map map) {
		mapper.updateProduct(map);
	}

	///////////////////////// 회원 모드 /////////////////////////
	// 카테고리별 상품 리스트 
	@Override
	public ArrayList<ProductDTO> getProdByCategory(String cat_code) {
		
		return mapper.getProdByCategory(cat_code);
	}

	// 스펙별 상품 리스트 
	@Override
	public ArrayList<ProductDTO> getProdBySpec(String pSpec) {
		
		return mapper.getProdBySpec(pSpec);
	}
	
	// 상품 검색
	@Override
	public List<ProductDTO> prodSearch(ProductDTO pDto) {
		
		return mapper.prodSearch(pDto);
	}
	
	// 전체 상품 리스트
	@Override
	public List<ProductDTO> uprodList() {
		
		return mapper.uprodList();
	}

}
