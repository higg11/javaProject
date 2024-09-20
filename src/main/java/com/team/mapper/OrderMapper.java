package com.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team.domain.MemberDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;
import com.team.domain.PointDTO;

@Mapper
public interface OrderMapper {

	// void orderInsert(OrderDTO dto);

	void insertOrder(OrderDTO order);
	
	boolean insertOrderDetail(OrderDetailDTO orderDetail);

	void pointInsert(MemberDTO mdto);

	List<OrderDTO> myOrderList(String id);

	String myOrderDetail(int order_num);

	List<OrderDetailDTO> orderDetailList(int order_num);

	void pointObtained(PointDTO pDto);


	
}
