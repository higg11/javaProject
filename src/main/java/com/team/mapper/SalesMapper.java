package com.team.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.team.domain.AdminDTO;
import com.team.domain.OrderDTO;
import com.team.domain.PageDTO;

public interface SalesMapper {

	////////////매출관리 페이지 ////////////////////
	List<OrderDTO> salesInfo(PageDTO pDto);

	List<OrderDTO> dailyPurchaseChart();

	List<OrderDTO> todayAjaxList();

	int totalCnt(PageDTO pDto);

	List<OrderDTO> salesInfoPeriod(OrderDTO dto);

	List<OrderDTO> getSalesDataForPeriod(String startDate, String endDate);



//	List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto);

	

}
