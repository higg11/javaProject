package com.team.service;

import java.util.List;


import javax.servlet.http.HttpServletRequest;


import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.AdminDTO;
import com.team.domain.ChartDTO;
import com.team.domain.PointDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;


public interface AdminService {
	
	// 관리자 로그인
	boolean adminLogin(AdminDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes);

	
	///////////// 관리자 홈화면 ///////////////////
	// 일매출(최근7일)
	List<OrderDTO> dailyPurchase();
	// 월매출
	List<OrderDTO> monthlyPurchase();
	// 상품 정보
	List<OrderDetailDTO> prod_purchase();
	// 총매출
	String totalPurchase();
	// 오늘 매출
	String todayPurchase();
	// 기부금
	List<PointDTO> monthlyDonation();

	// 차트 저장
	void saveChartData(ChartDTO dto);
	// 차트 불러오기
	List<ChartDTO> getChartConfigsById(String id);
	// 차트 삭제하기
	void deleteChartByCanvasId(String canvasId);
	
	
	
//	//////////// 매출관리 페이지 ////////////////////
//	// 전체 매출 리스트
//	List<OrderDTO> salesInfo(PageDTO pDto);
//	// 일매출(30일 한달기준)
//	List<OrderDTO> dailyPurchaseChart();
//	// 오늘 매출 디테일
////	List<OrderDTO> todayPurchaseInfo();
//	// 오늘 매출 상세보기
//	List<OrderDTO> todayAjaxList();
//	// 매출관리 페이지 날짜 범위 지정 검색
//	List<OrderDTO> salesInfoPeriod(OrderDTO dto);
//
//	// 일매출(30일 한달기준)
//	List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth);


//	List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto);	
	

}
