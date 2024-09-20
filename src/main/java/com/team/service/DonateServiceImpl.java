package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.domain.PointDTO;
import com.team.domain.MemberDTO;
import com.team.mapper.DonateMapper;

@Service
public class DonateServiceImpl implements DonateService {

	@Autowired // 의존성 추가
	private DonateMapper mapper;

	@Override
	public MemberDTO donateInfo(String id) {
		return mapper.donateInfo(id);
	}

	@Override
	public void donation(MemberDTO dto) {
		
        mapper.updatePoints(dto);
    }

	@Override
	public void donationAmount(PointDTO pDto) {
		
		mapper.donationAmount(pDto);
	}
	
	// 도네이션 리스트
	@Override
	public List<PointDTO> donationList() {
		
		return mapper.donationList();
	}

	// 나의 도네이션 리스트
	@Override
	public List<PointDTO> myDonationList(String id) {
		
		return mapper.myDonationList(id);
	}
	
	// 내 보유 포인트(ajax)
	@Override
	public Integer getMyPoint(String id) {
		
		return mapper.getMyPoint(id);
	}
	

}
