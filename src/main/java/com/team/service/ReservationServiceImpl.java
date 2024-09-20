package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.domain.PageDTO;
import com.team.domain.ReservationDTO;
import com.team.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired // 의존성 추가
	private ReservationMapper mapper;

	/////////////////// 관리자 //////////////////////
	// 예약페이지 리스트
	@Override
//	@Transactional
//	public List<ReservationDTO> reservationList(PageDTO pDto) {
	public List<ReservationDTO> reservationList() {
//		int totalCnt = mapper.totalCnt(pDto);
//		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
//		return mapper.reservationList(pDto);
		return mapper.reservationList();
	}
	
	// 예약 확정하기
	@Override
	public void reservationConfirmed(int rno) {
		
		mapper.reservationConfirmed(rno);
	}

	
	// 예약 취소하기
	@Override
	public void reservationCancel(int rno) {
		
		mapper.reservationCancel(rno);
		
	}	
	
	// 달력에 예약시간 리스트 표시
	@Override
	public List<ReservationDTO> calendarList() {
		
		return mapper.calendarList();
	}
	
	
	/////////////////// 유저 //////////////////////
	
	// 예약하기
	@Override
	public void reservation(ReservationDTO dto) {
		mapper.reservation(dto);
	}
	
	// 예약정보 확인하기
	@Override
	public List<ReservationDTO> reservationInfo(String rid_fk) {

		return mapper.reservationInfo(rid_fk);
	}

	// 예약시간 중복 체크
	@Override
	public List<String> getReservedTimes(String date) {
		
		return mapper.getReservedTimes(date);
	}

	@Override
	public ReservationDTO getInfo(int rno) {
		
		return mapper.getInfo(rno);
	}



}
