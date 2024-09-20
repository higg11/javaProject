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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.AdminDTO;
import com.team.domain.ChartDTO;
import com.team.domain.PointDTO;
import com.team.domain.OrderDTO;
import com.team.domain.OrderDetailDTO;
import com.team.domain.PageDTO;
import com.team.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adMapper;
	
	/*
	 * @Autowired private BCryptPasswordEncoder pwEncoder;
	 */
	
	// 관리자 로그인
	@Override
	public boolean adminLogin(AdminDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		HttpSession session = req.getSession();
		
		AdminDTO adLoginDTO = adMapper.adminLogin(dto);
		
		System.out.println(adLoginDTO);
		System.out.println(dto);
				
		if(adLoginDTO != null) {
			String inputPw = dto.getAd_password();
			String dbPw = adLoginDTO.getAd_password();
						
			if(inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("adLoginDTO", adLoginDTO);
				session.setAttribute("mode", "admin");
				return true;
			}else{ // 비번 불일치
				redirectAttributes.addFlashAttribute("loginErr", "pwdErr");
				return false;
			}			
		}
		redirectAttributes.addFlashAttribute("loginErr", "idErr");
		return false;
	}
	
	// 로그아웃
	@GetMapping("adminLogout.do")
	public String adminLogout(HttpSession session) {
		session.invalidate(); // 세션 초기화

		return "redirect:/";
	}
	
	///////////// 관리자 홈화면 ///////////////////	
	// 관리자홈 총매출
	@Override
	public String totalPurchase() {
		
		return adMapper.totalPurchase();
	}
	// 관리자홈 오늘매출
	@Override
	public String todayPurchase() {
		
		return adMapper.todayPurchase();
	}	
	
	// 관리자홈 일매출(최근7일)
	@Override
	public List<OrderDTO> dailyPurchase() {
		
		return adMapper.dailyPurchase();
	}
	// 관리자홈 월매출
	@Override
	public List<OrderDTO> monthlyPurchase() {
		
		return adMapper.monthlyPurchase();
	}
	// 관리자홈 상품 판매량
	@Override
	public List<OrderDetailDTO> prod_purchase() {
		
		return adMapper.prod_purchase();
	}
	
	// 관리자홈 기부금 내역
	@Override
	public List<PointDTO> monthlyDonation() {
		
		return adMapper.monthlyDonation();
	}
	
	// 관리자홈 차트저장
	@Override
	public void saveChartData(ChartDTO dto) {
		
		adMapper.saveChartData(dto);
	}
	
	// 관리자홈 차트 불러오기
	@Override
	public List<ChartDTO> getChartConfigsById(String id) {
		
		return adMapper.findById(id);
	}

	// 관리자홈 차트 삭제하기
	@Override
	public void deleteChartByCanvasId(String canvasId) {
		
		adMapper.deleteChart(canvasId);
	}		
	
	
	
//	////////////매출관리 페이지 ////////////////////
//	// 매출관리페이지 매출정보 가져오기
//	@Override
//	public List<OrderDTO> salesInfo(PageDTO pDto) {
//		int totalCnt = adMapper.totalCnt(pDto);
//		// setValue호출시 startIndex 셋팅됨 		
//		pDto.setValue(totalCnt, pDto.getCntPerPage());
//				
//		return adMapper.salesInfo(pDto);
//	}
//	// 매출관리페이지 오늘매출상세보기
//	@Override
//	public List<OrderDTO> todayAjaxList() {
//		
//		return adMapper.todayAjaxList();
//	}		
//	// 매출관리페이지 일일매출(30일 한달단위)
//	@Override
//	public List<OrderDTO> dailyPurchaseChart() {
//		
//		return adMapper.dailyPurchaseChart();
//	}
//	@Override
//	public List<OrderDTO> getSalesDataForMonth(YearMonth yearMonth) {
//		String startDate = yearMonth.atDay(1).toString(); // e.g., "2024-08-01"
//        String endDate = yearMonth.atEndOfMonth().toString(); // e.g., "2024-08-31"
//
//        return adMapper.getSalesDataForPeriod(startDate, endDate);
//	}
//	
//	
//	// 매출관리 페이지 날짜 범위 지정 검색
//	@Override
//	public List<OrderDTO> salesInfoPeriod(OrderDTO dto) {
//		
//		return adMapper.salesInfoPeriod(dto);
//	}
//
////	@Override
////	public List<OrderDTO> salesInfoPeriod(OrderDTO dto, PageDTO pDto) {
////		int totalCnt = adMapper.totalCnt(pDto);
////		// setValue호출시 startIndex 셋팅됨 		
////		pDto.setValue(totalCnt, pDto.getCntPerPage());
////		
////		return adMapper.salesInfoPeriod(dto, pDto);
////	}
//


}
