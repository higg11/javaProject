package com.team.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team.domain.PointDTO;
import com.team.domain.MemberDTO;
import com.team.service.DonateService;
import com.team.service.MemberService;
import com.team.utill.PointType;


@Controller
public class DonateController {

	@Autowired
	private DonateService service;
	
	@Autowired
	private MemberService mService;
	
	
	// 캠페인 페이지 이동
	@GetMapping("campaign.do")
	public String campaignForm() {

		return "donate/donate_campaign";
	}
	
	// 캠페인 리스트 페이지 이동
	   @GetMapping("campaignInfo.do")
	   public String campaignInfo() {
	      
	      return "donate/donate_campaignInfo";
	   }
	
	// 기부페이지 이동
	@GetMapping("donation.do")
	public String donateInfo(String id, Model model) {
		
		List<PointDTO> dDto = service.donationList();
		model.addAttribute("dDto", dDto);
		
		MemberDTO dto = service.donateInfo(id);
		model.addAttribute("dto", dto);
//		System.out.println("dto = " + dto);
		return "donate/donate_donation";
	}


	// 기부하기 
	@PostMapping("donation.do")
	public String donation(int point, MemberDTO dto, Model model) {
		
//		// 기부하기 (현재포인트에서 차감 로직)
//		// Get the current points from the database
//		MemberDTO currentDto = service.donateInfo(dto.getId());
////		System.out.println("###dto.getId()" + dto.getId());
//		int currentPoints = currentDto.getPoint();
//
//		// Get the donation points from the form
//		int donatedPoints = point;
//		
//		// 이 point와 날짜를 DB에 저장시켜야 함 (donation_point, donation_date) --> dto 추가를 oderDTO에 해줌
//
//		// Calculate the remaining points after donation
//		int remainingPoints = currentPoints - donatedPoints;
//
//		// Set the new point value in the dto
//		dto.setPoint(remainingPoints);
//
//		// Update the points in the database
//		service.donation(dto);
//		
//		
//		// 기부금 내역 (관리자페이지)
//		DonationDTO dDto = new DonationDTO();
//		
//		dDto.setDid_fk(currentDto.getId());
//		dDto.setDonation_amount(donatedPoints);
//		
//		System.out.println("dDto : " + dDto);
//		
//		service.donationAmount(dDto);
		
	    // 1. member 테이블에서 포인트 차감

	      String id = dto.getId();
	      MemberDTO mdto = mService.memberIdCheck(id);
	       
	      String memberId = mdto.getId();
	      int curPoints = mdto.getPoint();
	      int newPoints = curPoints - point;

	      mService.updatePoint(memberId, newPoints);
	      
	      // 2. 기부금 내역
	      PointDTO pDto = new PointDTO();
	      
	      pDto.setId(mdto.getId());
	      pDto.setPoint(point);
	      pDto.setPointType(PointType.DONATION);

//	      System.out.println("dDto : " + dDto);

	      service.donationAmount(pDto);	
		
		
		// Redirect to the donation page with updated points
		return "redirect:myDonationInfo.do";
	}
	
	// 포인트 내역 확인 페이지 이동
	@GetMapping("myDonationInfo.do")
	public String mydonationInfo(String id, HttpSession session, Model model) {
		
		MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
		id = dto.getId();
		
		List<PointDTO> list = service.myDonationList(id);
		model.addAttribute("list", list);
//		System.out.println("list" + list);
		
		return "donate/donate_donationInfo";
	}
	
	// 보유포인트 불러오기(ajax)
	@GetMapping("myPointAmount.do")
	@ResponseBody
	public String getMyPoint(HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		String id = dto.getId();
		
		Integer myPoint = service.getMyPoint(id);
		System.out.println("mypoint값..... : " + myPoint);
		
		return myPoint != null ? String.valueOf(myPoint) : "0";
	}
	

}