package com.team.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.domain.CartDTO;

public interface CartMapper {
	
	// 장바구니
	ArrayList<CartDTO> cartList(String cid_fk);

	CartDTO checkCart(CartDTO dto);

	void addCart(CartDTO dto);

	void modifyCart(CartDTO dto);

	void deleteCart(int cart_num);

	String shoppingCartCount(String cid_fk);
	
	
	
	// 찜하기
	CartDTO checkFavorite(CartDTO dto);

	void addFavorite(CartDTO dto);

	List<CartDTO> favoriteList(String id);

	void favoriteToCart(int cart_num);

	CartDTO cartDtoByPnum(int cart_num);
	
	
	
	// 구매하기
	void deleteCheckout(@Param("pnum") int pnum, @Param("id") String id);

}
