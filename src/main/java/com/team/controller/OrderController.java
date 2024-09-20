package com.team.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.domain.MemberDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;
import com.team.domain.OrderRequestDTO;
import com.team.service.CartService;
import com.team.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	
	@Autowired
	private CartService cartService;
	
	// 주문하기
//	@GetMapping("orderInsert.do")
//	public String orderComplete(HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
//		
//		 // 세션에서 장바구니 목록을 가져옵니다.
//	    List<CartDTO> cartList = (List<CartDTO>)session.getAttribute("dtos");
//	    
//	    if (cartList == null || cartList.isEmpty()) {
//	        // 장바구니에 상품이 없을 경우 처리
//	        return "redirect:/cartList.do"; // 장바구니가 비어있으면 장바구니 페이지로 리디렉션
//	    }
//
//	    // 각 장바구니 항목을 OrderDTO로 변환하여 DB에 저장
//	    for (CartDTO cartItem : cartList) {
//	        OrderDTO dto = new OrderDTO();
//
//	        // OrderDTO에 필요한 값 설정
////	        dto.setPnum(cartItem.getPnum_fk()); // 상품 번호 설정
////	        dto.setId(cartItem.getCid_fk()); // 주문자 아이디 설정
////	        dto.setQty_ordered(cartItem.getPqty()); // 주문 수량 설정
////	        dto.setPrice_each(cartItem.getPrice()); // 개별 가격 설정
////	        dto.setPoint(cartItem.getPoint()); // 포인트 설정
//	        	        
//	        
//	        // 주문 정보를 OrderDTO로 DB에 저장
//	        service.orderInsert(dto);
//	        
//	        // 포인트는 별도로 memberDTO에 저장
//			MemberDTO mdto = new MemberDTO();
//	        
//	        mdto.setId(cartItem.getCid_fk()); // 아이디 저장
//	        mdto.setPoint(cartItem.getPoint()*cartItem.getPqty()); // 포인트 설정
//	        
//	        // 포인트는 MemberDTO로 저장
//	        service.pointInsert(mdto);
//	    }
//	    
//	    // 주문이 완료된 후 장바구니에서 dtos 제거
//	    for (CartDTO cart : cartList) {	    	
//	    	cartService.deleteCart(cart.getCart_num());
//	    }
//	    
//	    // 주문 완료 후 세션에서 'dtos' 속성을 제거
//	    // session.removeAttribute("dtos");	   --> NullPointerException 에러 발생 (
//	    
//	    redirectAttributes.addFlashAttribute("msg", "주문이 완료되었습니다!!");
//	    // 모든 주문 정보가 저장된 후 메인 페이지로 리디렉션
//	    
//	    return "redirect:myOrderInfo.do";
//	}
	
	// 주문하기
	@PostMapping("orderInsert.do")
	@ResponseBody
	public String placeOrder(@RequestBody OrderRequestDTO request, HttpSession session) {
	
//        OrderDTO order = request.getOrder();
//        List<OrderDetailDTO> orderDetails = request.getOrderDetails();
//        service.placeOrder(order, orderDetails, session);

        boolean isOrderSuccessful = service.placeOrder(request.getOrder(), request.getOrderDetails(), session);
        
//        Map<String, String> response = new HashMap<>();
//        response.put("status", "success");
//        response.put("redirectUrl", "/myOrderInfo.do");

        if (isOrderSuccessful) {
            // 주문 성공 시 리다이렉트
            return "성공";
        } else {
            // 주문 실패 시 장바구니 페이지로 리다이렉트
            return "실패";
        }	   
	}
	
	// 내 구매정보 불러오기
	@GetMapping("myOrderInfo.do")
	public String orderInfo(Model model, HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		
		// 로그인하지 않은 경우 또는 로그인 DTO가 없는 경우 처리
	    if (dto == null) {
	        // 예: 로그인 페이지로 리다이렉트
	        return "redirect:/login";
	    }
	    
	    // 세션에서 로그인 ID를 가져온다
	    String id = dto.getId();
//	    System.out.println("idddddddddddddd : " + id);
	    
	    // 서비스 메서드를 호출하여 주문 정보를 조회한다
	    List<OrderDTO> list = service.myOrderList(id);
	    
	    // 조회된 정보를 모델에 추가
	    model.addAttribute("list", list);
//	    System.out.println("listtttttttttttttt : " + list);
	    
	    // 뷰 이름을 반환
	    return "member/member_orderInfo";
	}
	
	// 내 주문정보 상세보기
	@GetMapping("myOrderDetail.do")
	public String myOrderDetail(int order_num, Model model) {
		
		List<OrderDetailDTO> list = service.myOrderDetail(order_num);
		model.addAttribute("list", list);
		
		return "member/member_orderView";
	}
	
	
}
