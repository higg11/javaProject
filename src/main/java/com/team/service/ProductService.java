package com.team.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.team.domain.PageDTO;
import com.team.domain.ProdPageDTO;
import com.team.domain.ProductDTO;

public interface ProductService {
	//////////////////관리자 /////////////////////
	// 상품 등록
	void prodRegister(Map map);

	// 상품 리스트
	List<ProductDTO> productList(PageDTO pDto); 
	
	// 재고 상품
	List<ProductDTO> stockList();
	
	/*
	 * // 홈화면 상품 리스트 List<ProductDTO> homeProductList(ProdPageDTO pDto);
	 */

	// 상품 삭제
	void deleteProduct(int pnum);
	
	// 상품 정보 가져오기
	ProductDTO getProduct(int pnum);
	
	// 상품 수정
	void updateProduct(Map map);
	
	////////////////////////////회원 ///////////////////////////
	// 카테고리별 상품 리스트 (뷰 단에 뿌리기)
	ArrayList<ProductDTO> getProdByCategory(String code);
	
	// 스펙별 상품 리스트 (뷰 단에 뿌리기)
	ArrayList<ProductDTO> getProdBySpec(String pSpec);

	List<ProductDTO> prodSearch(ProductDTO pDto);

	List<ProductDTO> uprodList();



	

}
