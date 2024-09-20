package com.team.service;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.team.domain.AdminDTO;
import com.team.domain.OrderDTO;
import com.team.domain.PageDTO;
import com.team.mapper.AdminMapper;

public interface SalesService {
	
	//////////// 매출관리 페이지 ////////////////////
	// 전체 매출 리스트
	List<OrderDTO> salesInfo(PageDTO pDto);
	// 일매출(30일 한달기준)
	List<OrderDTO> dailyPurchaseChart();
	// 오늘 매출 디테일
//	List<OrderDTO> todayPurchaseInfo();
	// 오늘 매출 상세보기
	List<OrderDTO> todayAjaxList();
	// 매출관리 페이지 날짜 범위 지정 검색
	List<OrderDTO> salesInfoPeriod(OrderDTO dto);

	// 일매출(30일 한달기준)
	List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth);
	

}
