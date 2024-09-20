package com.team.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.team.domain.CartDTO;
import com.team.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired // root-context에서 생성된 Bean class 를 주입받기 // servlet에서 생성된건 받지 못함
	JavaMailSender mailSender;
	
	@Autowired	// 암호화를위해서 root 추가한 pwEncoder에서 주입받음
	private BCryptPasswordEncoder pwEncoder;

	
	////////////////////// 장바구니 ////////////////////////
	// 카트 전체 리스트 가져오기
	@Override
	public ArrayList<CartDTO> cartList(String cid_fk) {
		
		return cartMapper.cartList(cid_fk);
	}
	
	//// 카트 리스트 체크(상품이 있는지 없는지)
	@Override
	public CartDTO checkCart(CartDTO dto) {
		
		return cartMapper.checkCart(dto);
	}
	// 카트 등록 (상품이 없으면)
	@Override
	public void addCart(CartDTO dto) {
	    System.out.println("Adding cart to DB: " + dto); 
		cartMapper.addCart(dto);
		
	}
	// 카트 수정 (상품이 있으면)
	@Override
	public void modifyCart(CartDTO dto) {
		cartMapper.modifyCart(dto);		
	}

	// 카트 삭제
	@Override
	public void deleteCart(int cart_num) {
		cartMapper.deleteCart(cart_num);		
	}
	
	// 장바구니 총수량(실시간)
	@Override
	public String shoppingCartCount(String cid_fk) {
		
		return cartMapper.shoppingCartCount(cid_fk);
	}

	// 찜하기 리스트 중복확인
	@Override
	public CartDTO checkFavorite(CartDTO dto) {
		
		return cartMapper.checkFavorite(dto);
	}
	
	// 찜하기 추가
	@Override
	public void addFavorite(CartDTO dto) {
		
		cartMapper.addFavorite(dto);
	}
	
	// 찜 리스트 불러오기
	@Override
	public List<CartDTO> favoriteList(String id) {
		
		return cartMapper.favoriteList(id);
	}
	
	// 찜하기 상품를 장바구니로 이동
	@Override
	public void favoriteToCart(int cart_num) {
		
		cartMapper.favoriteToCart(cart_num);
	}
	
	// 찜상품과 일치하는 상품이 장바구니에 있는지 체크
	@Override
	public CartDTO cartDtoByPnum(int cart_num) {
		
		return cartMapper.cartDtoByPnum(cart_num);
	}

	
	
	
	////////////////////// 구매페이지 ////////////////////////	
	@Override
	public void deleteCheckout(int pnum, String id) {
		cartMapper.deleteCheckout(pnum, id);
		
	}


	
	@Override 
	public List<CartDTO> getCartList(HttpSession session) {
	  
		return (List<CartDTO>) session.getAttribute("dtos"); 
	}
	 
	
	
	
	
	
}
