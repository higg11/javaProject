package com.team.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.domain.CartDTO;
import com.team.domain.MemberDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;
import com.team.domain.PointDTO;
import com.team.domain.ProductDTO;
import com.team.mapper.CartMapper;
import com.team.mapper.MemberMapper;
import com.team.mapper.OrderMapper;
import com.team.mapper.ProductMapper;
import com.team.utill.PointType;


@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private ProductMapper pMapper;
	
	@Autowired
	private MemberMapper mMapper;
		
	@Override
	@Transactional
	public boolean placeOrder(OrderDTO order, List<OrderDetailDTO> orderDetails, HttpSession session) {
	    // 세션에서 장바구니 목록을 가져오기
	    List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("dtos");

	    if (cartList == null || cartList.isEmpty()) {
	        // 장바구니에 상품이 없을 경우 처리
	        return false; // 장바구니가 비어있으면 장바구니 페이지로 리디렉션
	    }

	    // OrderDTO에 필요한 값 설정
	    MemberDTO mDto = (MemberDTO) session.getAttribute("loginDTO");
	    String id = mDto.getId();

	    int total_amount = 0;
	    int total_point = 0;

	    for (CartDTO cartItem : cartList) {
	        total_amount += (cartItem.getPqty() * cartItem.getPrice());
	        total_point += (cartItem.getPqty() * cartItem.getPoint());
	    }

	    // 1. tbl_order 저장
	    order.setId(id);   // 주문자 아이디 설정
	    String level = mDto.getLevel();
	    int new_total_amount;
	    
	    if (level == null) {
	        // level이 null인 경우 처리
	        new_total_amount = total_amount;  // 할인 없이 원래 금액 사용
	    } else {
	        switch(level) {
	            case "Seed":
	                new_total_amount = (int)(total_amount * 0.97);
	                break;
	            case "Sprout":
	                new_total_amount = (int)(total_amount * 0.95);
	                break;
	            case "Tree":
	                new_total_amount = (int)(total_amount * 0.93);
	                break;
	            case "Earth":
	                new_total_amount = (int)(total_amount * 0.90);
	                break;
	            default:
	                new_total_amount = total_amount;  // 기본적으로 할인 없이 원래 금액
	                break;
	        }
	    }
	    
	    order.setTotal_amount(new_total_amount);   // 주문 합계
	    order.setTotal_point(total_point);   // 포인트 합계
	    mapper.insertOrder(order);

	    // Get the generated order_num (assumes your mapper returns it)
	    int orderNum = order.getOrder_num();

	    // 2. tbl_orderDetail 저장
	    for (CartDTO cartItem : cartList) {
	        OrderDetailDTO detail = new OrderDetailDTO();
	        detail.setOrder_num(orderNum); // Use the generated order_num
	        detail.setPnum(cartItem.getPnum_fk());
	        detail.setQuantity(cartItem.getPqty());
	        detail.setUnitPrice(cartItem.getPrice());
	        detail.setUnitPoint(cartItem.getPoint());

	        mapper.insertOrderDetail(detail);
	    }
	    
	    // 3. 주문이 완료된 후 장바구니(tbl_cart)에서 dtos 제거
	    for (CartDTO cart : cartList) {	    	
	    	cartMapper.deleteCart(cart.getCart_num());
	    }
	    
	    // 4. tbl_member 포인트 적립
		MemberDTO mdto = new MemberDTO();
        
        mdto.setId(id); // 아이디 저장
        mdto.setPoint(total_point); // 포인트 설정
        
        mapper.pointInsert(mdto);
	    
        // 5. tbl_point 포인트 적립
        PointDTO pDto = new PointDTO();
        
        pDto.setId(id);
        pDto.setPoint(total_point);
        pDto.setPointType(PointType.OBTAINED);
        
        mapper.pointObtained(pDto);
        
        // 6. tbl_product 재고 수정
        for (CartDTO cart : cartList) {
        	int pnum = cart.getPnum_fk();
        	ProductDTO prodDto = pMapper.getProduct(pnum);
        	int cur_pqty = prodDto.getPqty();
        	int update_pqty = cur_pqty - cart.getPqty();
        	
        	Map<String, Object> map = new HashMap<>();
        	map.put("pnum", pnum);
        	map.put("pqty", update_pqty);
        	
        	pMapper.updateStock(map);	
        }
        
        // 5. tbl_member 등급 
        mDto = mMapper.memberInfo(id);
        if (mDto.getLevel() == null) {
        	// 첫구매시 insert
        	level = "Seed";
        	mDto.setLevel(level);
        	mMapper.upgradeLevel(mDto);       	
        }else{
        	// 이후 update
        	int totalPaid = mMapper.getTotalPaid(id);
        	if(totalPaid >= 100000) {
        		level = "Sprout";
        		mDto.setLevel(level);
            	mMapper.upgradeLevel(mDto);
        	} else if(totalPaid >= 500000) {
        		level = "Tree";
        		mDto.setLevel(level);
            	mMapper.upgradeLevel(mDto);
        	}else if(totalPaid >= 1000000) {
        		level = "Earth";
        		mDto.setLevel(level);
            	mMapper.upgradeLevel(mDto);
        	}
        }
        
	    return true;
	}
	
	
	// 포인트 적립(회원용) 
//	@Override
//	public void pointInsert(MemberDTO mdto) {
//		
//		mapper.pointInsert(mdto);
//	}

	// 내 주문정보 불러오기(회원용)
	@Override
	public List<OrderDTO> myOrderList(String id) {
		
		return mapper.myOrderList(id);
	}
	
	// 내 주문 상세정보 불러오기(회원용)
	@Override
	public List<OrderDetailDTO> myOrderDetail(int order_num) {
		
		
		return mapper.orderDetailList(order_num);
	}

}
