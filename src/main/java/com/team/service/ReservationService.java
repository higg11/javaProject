package com.team.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.team.domain.MemberDTO;
import com.team.domain.PageDTO;
import com.team.domain.ReservationDTO;

@Service
public interface ReservationService {

	/////////////////// 관리자 //////////////////////	
//	List<ReservationDTO> reservationList(PageDTO pDto);
	List<ReservationDTO> reservationList();
	
	void reservationConfirmed(int rno);
	
	void reservationCancel(int rno);
	
	List<ReservationDTO> calendarList();
	
	
	
	/////////////////// 유저 //////////////////////	
	
	void reservation(ReservationDTO dto);
	
	List<ReservationDTO> reservationInfo(String rid_fk);

	List<String> getReservedTimes(String date);

	ReservationDTO getInfo(int rno);

}
