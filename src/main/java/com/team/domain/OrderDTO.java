package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	
	// orderDTO
	private int order_num;
	private String id;
	private Date order_date;
	private int total_amount;
	private int total_point;
//	private Dlv_Status dlv_status; // 만들어야함
	
	
	////////// 관리자홈 ////////
	private String TODAY_PURCHASE_AMOUNT;	// 당일 매출 
	private String TOT_PURCHASE_AMOUNT; // 누적 총매출 
	private String PURCHASE_AMOUNT; // 일일매출(최근7일), 월매출
	private String ORDER_MONTH; // 월매출 	

	
	// left join table
	private String cat_name; // 카테고리명
	private String pname; // 상품명
	
	//////// 매출관리 페이지 //////
	// 매출 정보
	private int quantity;
	private int unitPrice;
	
	// 매출 기간 검색
	private Date startDate;  // 검색 시작일
	private Date endDate;  // 검색 완료일
	
	// 검색 페이지네이션
	private int startIndex;
    private int cntPerPage;

    // 주문 목록확인(고객 마이페이지)
//    private String order_count;
//    private String pimage;
//    private String TotPrice;
//    private String TotPoint;
	
}
