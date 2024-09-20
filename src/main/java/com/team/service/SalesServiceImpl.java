package com.team.service;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.team.domain.AdminDTO;
import com.team.domain.OrderDTO;
import com.team.domain.PageDTO;
import com.team.mapper.AdminMapper;
import com.team.mapper.SalesMapper;

@Service
public class SalesServiceImpl implements SalesService {

	@Autowired
	private SalesMapper mapper;
	
	////////////매출관리 페이지 ////////////////////
	// 매출관리페이지 매출정보 가져오기
	@Override
	public List<OrderDTO> salesInfo(PageDTO pDto) {
		int totalCnt = mapper.totalCnt(pDto);
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
				
		return mapper.salesInfo(pDto);
	}
	// 매출관리페이지 오늘매출상세보기
	@Override
	public List<OrderDTO> todayAjaxList() {
		
		return mapper.todayAjaxList();
	}		
	// 매출관리페이지 일일매출(30일 한달단위)
	@Override
	public List<OrderDTO> dailyPurchaseChart() {
		
		return mapper.dailyPurchaseChart();
	}
	@Override
	public List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth) {
		String startDate = yearMonth.atDay(1).toString(); // e.g., "2024-08-01"
        String endDate = yearMonth.atEndOfMonth().toString(); // e.g., "2024-08-31"

        return mapper.getSalesDataForPeriod(startDate, endDate);
	}
	
	
	// 매출관리 페이지 날짜 범위 지정 검색
	@Override
	public List<OrderDTO> salesInfoPeriod(OrderDTO dto) {
		
		return mapper.salesInfoPeriod(dto);
	}

//	@Override
//	public List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto) {
//		int totalCnt = adMapper.totalCnt(pDto);
//		// setValue호출시 startIndex 셋팅됨 		
//		pDto.setValue(totalCnt, pDto.getCntPerPage());
//		
//		return adMapper.salesInfoPeriod(dto, pDto);
//	}



}
