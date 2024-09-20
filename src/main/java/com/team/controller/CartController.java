package com.team.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.CartDTO;
import com.team.domain.MemberDTO;
import com.team.service.CartService;
import com.team.service.MemberService;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private MemberService memberService;

	////////////////////// 장바구니 ////////////////////////
	// 장바구니 이동
	@GetMapping("cartList.do")
	public String cartList(HttpSession session) {

		MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
		String cid_kf = dto.getId();

		ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);
		
		for (CartDTO cdto : cartList) {
			cdto.setTotal();
		}

		session.setAttribute("dtos", cartList);	
//		System.out.println("cartList////// : " + cartList);
		
		String id = dto.getId();
		List<CartDTO> favorites = cartService.favoriteList(id);
		session.setAttribute("favorites", favorites);
//		System.out.println("찜하기 확인용"+ favorites);

		return "product/cart_list";
	}

	// 장바구니 담기
	@RequestMapping("addCart.do")
	public String addCart(CartDTO dto, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		dto.setCid_fk(mdto.getId());
		String type = "Cart";
		dto.setType(type);
		
		CartDTO ckDTO = cartService.checkCart(dto);	
		
		if (ckDTO == null) {
			cartService.addCart(dto);
			redirectAttributes.addFlashAttribute("msg", "장바구니 등록 완료");
		} else {
			dto.setPqty(ckDTO.getPqty() + 1);
			dto.setCart_num(ckDTO.getCart_num());
			cartService.modifyCart(dto);
			redirectAttributes.addFlashAttribute("msg", "장바구니 수량추가");
		}

		return "redirect:cartList.do";
	}

	// 카트 정보(인포)폼에서 수정OK 이동
	@RequestMapping("/modifyCart.do")
	public String modifyCart(CartDTO dto, RedirectAttributes redirectAttributes) {
		cartService.modifyCart(dto);
		redirectAttributes.addFlashAttribute("msg", "장바구니 수정완료");
		return "redirect:cartList.do";
	}

	// 장바구니 삭제
	@PostMapping("deleteCart.do")
	public String deleteCart(int cart_num, RedirectAttributes redirectAttributes) {
		cartService.deleteCart(cart_num);
		redirectAttributes.addFlashAttribute("msg", "장바구니 수정완료");
		return "redirect:cartList.do";
	}

	// 장바구니 수량 표시(실시간)
	@GetMapping("shoppingCartCount.do")
	@ResponseBody
	public String shoppingCartCount(Model model, HttpSession session) {
		 // 세션에서 loginDTO 객체를 가져와서 id를 추출
	    MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
	        
	    String cid_fk = dto != null ? dto.getId() : null;

	    if (cid_fk == null) {
	        System.out.println("####로그인된 사용자 정보가 없습니다.");
	        return "0"; // 로그인 정보가 없으면 장바구니 수량을 0으로 설정
	    }

	    try {
	        // 장바구니 수량을 가져오기
	        String tot_pqty = cartService.shoppingCartCount(cid_fk);
	        return tot_pqty != null ? tot_pqty : "0"; // null 체크 후 0 반환
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	        return "0"; // 예외 발생 시 장바구니 수량을 0으로 설정
	    }
	}	
	
	// 찜하기 추가
	@RequestMapping("addFavorite.do")
	public String addFavorite(CartDTO dto, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		String id = mdto.getId();
		dto.setCid_fk(id);
		String type = "Favorite";
		dto.setType(type);
		
		CartDTO cDTO = cartService.checkFavorite(dto);	
		
		if (cDTO == null) {
			cartService.addFavorite(dto);
			redirectAttributes.addFlashAttribute("msg", "찜하기 등록 완료");
		} else {
			redirectAttributes.addFlashAttribute("msg", "이미 찜한 상품입니다!!");
		}
		
		return "redirect:cartList.do";
	}
	
	// 찜하기에서 장바구니 이동
	@RequestMapping("favoriteToCart.do")
	public String favoriteToCart(int cart_num, HttpSession session, RedirectAttributes redirectAttributes) {
		
		// cart_num으로 dto를 불러옴 -> dto.pnum과 cartList의 pnum이 일치하는지 반복문 -> 일치하면 에러, 안 일치하면 오케이
		CartDTO dto = cartService.cartDtoByPnum(cart_num);
		int pnum = dto.getPnum_fk();
		
		MemberDTO mDto = (MemberDTO) session.getAttribute("loginDTO");
		String cid_kf = mDto.getId();

		ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);
		boolean isProductInCart = false;

	    // Check if the product is already in the cart
	    for (CartDTO cdto : cartList) {
	        if (pnum == cdto.getPnum_fk()) {
	            isProductInCart = true;
	            break;  // Product found, exit loop
	        }
	    }

	    if (isProductInCart) {
	        redirectAttributes.addFlashAttribute("msg", "장바구니에 이미 해당상품이 존재합니다!!!");
	    } else {
	        // Product is not in the cart, proceed with adding it
	        cartService.favoriteToCart(cart_num);
	        redirectAttributes.addFlashAttribute("msg", "찜하기에서 장바구니로 이동 완료!!!");
	    }
		
		
//		cartService.favoriteToCart(cart_num);
//		redirectAttributes.addFlashAttribute("msg", "찜하기에서 장바구니로 이동 완료!!!");
		
		return "redirect:cartList.do";  // Redirect to cart list page
	}
	
	
	
	
	
	
	
	////////////////////// 구매페이지 ////////////////////////
	// 구매페이지 이동
	@GetMapping("checkout.do")
	public String checkOutFoam(Model model, HttpSession session, HttpServletRequest request,
		RedirectAttributes redirectAttributes) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		String cid_kf = mdto.getId();

		MemberDTO mDto = memberService.memberInfo(cid_kf);
		model.addAttribute("mDto", mDto);
		request.setAttribute("msg", "구매 페이지로 이동합니다.");

		return "product/checkout";
	}

	// 구매리스트에서 삭제
	@RequestMapping("deleteCheckout.do")
	public String deleteCheckout(String pnum, String cid_kf, HttpSession session, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {

		MemberDTO mdto = (MemberDTO) session.getAttribute("loginDTO");
		cid_kf = mdto.getId();

//		pnum = null;

		String pnums = request.getParameter("delPnums");
		System.out.println("pnums : " + pnums);

		// 1. 삭제 버튼
		if (pnums == null) {
			if (request.getMethod().equals("POST")) { // 보안
				pnum = request.getParameter("pnum");
			}
			if (pnum == null || pnum.trim().equals("")) { // 보안
				request.setAttribute("msg", "잘못된 경로 입니다.");
				return "redirect:userMainForm.do";
			}
			// DB에서 리스트 삭제
			cartService.deleteCheckout(Integer.valueOf(pnum), cid_kf); // cartDAO로 리턴
			// id를 세션으로 묵으면 결제하기페이지에서 소환가능
			ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);
			// 토탈 setTotal() 함수 호출하기 (합계구하는 함수)
			for (CartDTO cDto : cartList) {
				cDto.setTotal(); // 수량만큼 totPrice, totPoint 계산
			}
			// 바인딩
			session.setAttribute("dtos", cartList);
			redirectAttributes.addFlashAttribute("msg", "장바구니1 삭제 완료");
			return "redirect:checkout.do"; // '장바구니리스트'로 리턴
		}

		// 2. 선택삭제

		String[] numArr = pnums.split("/"); // 구분자로 값을 꺼내서 배열에 넣기 [5,7,6...]

		for (int i = 0; i < numArr.length; i++) {
			cartService.deleteCheckout(Integer.valueOf(numArr[i]), cid_kf); // cartDAO로 리턴
		}

		// id를 세션으로 묵으면 결제하기페이지에서 소환가능
		ArrayList<CartDTO> cartList = cartService.cartList(cid_kf);

		// 토탈 setTotal() 함수 호출하기 (합계구하는 함수)
		for (CartDTO cDto : cartList) {
			cDto.setTotal(); // 수량만큼 totPrice, totPoint 계산
		}

		// 바인딩
		session.setAttribute("dtos", cartList);
		redirectAttributes.addFlashAttribute("msg", "장바구니2 삭제 완료");
		return "redirect:checkout.do";
	}

	// 결제하기에서 카트리스트 정보 받아오기
	@GetMapping("getCartList.do")
	@ResponseBody
	public List<CartDTO> getCartList(HttpSession session){
		
		return cartService.getCartList(session);
	}

}
