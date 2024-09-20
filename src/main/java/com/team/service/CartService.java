package com.team.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.team.domain.CartDTO;

public interface CartService {
	
	// 카트 전체 리스트 가져오기
	ArrayList<CartDTO> cartList(String cid_fk);
	
	//////  카트 추가  ///////
	// 카트 리스트 체크(상품이 있는지 없는지)
	CartDTO checkCart(CartDTO dto);
	// 카트 등록 (상품이 없으면)
	void addCart(CartDTO dto);
	// 카트 수정 (상품이 있으면)
	void modifyCart(CartDTO dto);
	// 카트 삭제
	void deleteCart(int cart_num);

	void deleteCheckout(int pnum, String id);

	String shoppingCartCount(String cid_fk);

	List<CartDTO> getCartList(HttpSession session);
	
	
	// 찜하기
	CartDTO checkFavorite(CartDTO dto);

	void addFavorite(CartDTO dto);

	List<CartDTO> favoriteList(String id);

	void favoriteToCart(int cart_num);

	CartDTO cartDtoByPnum(int cart_num);
}
