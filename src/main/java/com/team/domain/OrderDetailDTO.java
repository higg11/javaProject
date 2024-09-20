package com.team.domain;

import lombok.Data;

@Data
public class OrderDetailDTO {
	
	private int orderDetail_num;
	private int order_num;
	private int pnum;
	private int quantity;
	private int unitPrice;
	private int unitPoint;	
	private int totalPrice;
	private int totalPoint;

	// 주문 상세보기
	private String cat_name;
	private String pname;
	private String pimage;
	
	// 관리자 홈 
	private String TOT_PQTY; // 상품 총 판매량 
	
}
