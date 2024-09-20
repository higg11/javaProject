package com.team.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.team.domain.MemberDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;

@Service
public interface OrderService {

	// void orderInsert(OrderDTO dto);
	
	boolean placeOrder(OrderDTO order, List<OrderDetailDTO> orderDetails, HttpSession session);

//	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	List<OrderDetailDTO> myOrderDetail(int order_num);


}
