package com.team.domain;

import java.util.List;

import lombok.Data;

@Data
public class OrderRequestDTO {
	
	private OrderDTO order;
	private List<OrderDetailDTO> orderDetails;
	
	
}
