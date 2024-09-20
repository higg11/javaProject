package com.team.controller;

import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.team.domain.AdminDTO;
import com.team.domain.OrderDTO;
import com.team.domain.PageDTO;
import com.team.service.AdminService;
import com.team.service.SalesService;

@Controller
public class SalesController {
	
	@Autowired
	private SalesService service;

		
	// 매출관리 페이지 이동
	@GetMapping("salesInfo.do")
	public String salesInfo(PageDTO pDto, Model model) {
		List<OrderDTO> orderDto = service.salesInfo(pDto);
		
		model.addAttribute("orderDto", orderDto);
		System.out.println("###orderDto#### : " + orderDto);
		
		// serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);
//			System.out.println("###pDto#### : " + pDto);
		return "admin/ad_salesInfo";
	}		
	
	// 매출관리 페이지 - 오늘매출 상세보기
	@GetMapping("todayAjaxList.do")
	@ResponseBody
	public List<OrderDTO> todayAjaxList(){
		List<OrderDTO> todayList = service.todayAjaxList();
		System.out.println("todayAjsxList : " + todayList);
		
		return todayList;
	}
	
	
	// 매출관리 페이지 - 오늘매출 
//		@RequestMapping("todayPurchaseInfo.do")
//		@ResponseBody
//		public List<OrderDTO> todayPurchaseInfo(Model model) {
//			
//			List<OrderDTO> todayPurchaseAmountInfo = adService.todayPurchaseInfo();
//			System.out.println("####오늘 매출 상세보기"+ todayPurchaseAmountInfo);
//			model.addAttribute("todayPurchaseAmountInfo", todayPurchaseAmountInfo);
//			
//			return todayPurchaseAmountInfo;
//		}
	
	// 매출관리 페이지 - 일일매출 그래프(월단위 30일)
	@RequestMapping("dailyPurchaseChart.do")
	@ResponseBody
	public String dailyPurchaseChart(Model model, HttpServletRequest request) {
		List<OrderDTO> list =service.dailyPurchaseChart();
		
		SimpleDateFormat sd = new SimpleDateFormat("yy-MM-dd");
		Gson gson = new GsonBuilder().create();	
		JsonArray jArray = new JsonArray();				
		
		Iterator<OrderDTO> it = list.iterator();
		while(it.hasNext()) {
			OrderDTO dto = it.next();
			JsonObject object = new JsonObject();
			
			String date = sd.format(dto.getOrder_date());						
			String sum = dto.getPURCHASE_AMOUNT();
//				System.out.println(sum);
			
			object.addProperty("date", date);
			object.addProperty("sum", sum);
			jArray.add(object);			
		}
				
		String json = gson.toJson(jArray);
//		System.out.println("json 일데이터값@@@@@" + json);	
		
		return json;
	}
	
	@GetMapping("/getMonthlySalesData.do")
    @ResponseBody
    public List<OrderDTO> getMonthlySalesData(
            @RequestParam("year") int year,
            @RequestParam("month") int month) {

        // Create a YearMonth object for the given year and month
        YearMonth yearMonth = YearMonth.of(year, month);

        // Fetch the sales data for the month from the service
        return service.getSalesDataForMonth(yearMonth);
    }
	
	// 매출관리 페이지 날짜 범위 지정 검색
	@GetMapping("salesInfoPeriod.do")
	public String salesInfoPeriod(@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam("endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate, Model model) {
		
		OrderDTO dto = new OrderDTO();
		dto.setStartDate(startDate);
		dto.setEndDate(endDate);
       

        List<OrderDTO> orderDto = service.salesInfoPeriod(dto);
//	        List<OrderDTO> orderDto = adService.salesInfoPeriod(dto, pDto);
        model.addAttribute("orderDto", orderDto);
		
//			System.out.println("@@@@orderDTO@@@" + orderDto);
        
		// serviceImpl에서 셋팅된 pDto
//			model.addAttribute("pDto", pDto);
		
		return "admin/ad_salesInfo";
		}			
			
}
		
//	// 매출관리 페이지 이동
//		@GetMapping("incomeState.do")
//		public String incomeStateForm(Model model) {
//			
//			 ArrayList<HashMap<String, Object>> getIncome = adService.getIncome();
//			 String sum = getIncome.get(0).get("sum").toString();
//			 System.out.println("오늘매출 : "+ sum);
//			 
//			    JsonArray jArray = new JsonArray();
//
//			    for (HashMap<String, Object> map : getIncome) {
//			    	
//			        JsonObject json = new JsonObject();
//			        
//			        
//			        for (HashMap.Entry<String, Object> entry : map.entrySet()) {
//			            String key = entry.getKey();
//			            Object value = entry.getValue();
//
//			            // Check the type of value and add it appropriately
//			            if (value instanceof String) {
//			                json.addProperty(key, (String) value);
//			            } else if (value instanceof Number) {
//			                json.addProperty(key, (Number) value);
//			            } else if (value instanceof Boolean) {
//			                json.addProperty(key, (Boolean) value);
//			            } else {
//			                json.addProperty(key, value.toString());
//			            }
//			        }  
//			        jArray.add(json);
//			    }
//			   
//			
//			model.addAttribute("jArray", jArray);
//			System.out.println("############jArray : " + jArray);
//			
//			return "admin/income_state";
//		}
	
//		@GetMapping("incomeState.do")
//		public String incomeStateForm(Model model) {
//			List<OrderDTO> list = adService.getIncome();
//			
////			model.addAttribute("list", list);
//			System.out.println(list);
//			
//			Gson gson = new GsonBuilder().create();	
//			JsonArray jArray = new JsonArray();
//			
//			Iterator<OrderDTO> it = list.iterator();
//			while(it.hasNext()) {
//				OrderDTO dto = it.next();
//				JsonObject object = new JsonObject();
//				
//				int order_num = dto.getOrder_num();
//				String order_date = dto.getOrder_date().toString();
//				
//				
//				object.addProperty("order_num", order_num);
//				object.addProperty("order_date", order_date);
//				
//				
//				jArray.add(object);			
//			}
//					
//			String json = gson.toJson(jArray);
//			model.addAttribute("json", json);
//			System.out.println(json);
//			
//			return "admin/income_state";
//		}
//	

