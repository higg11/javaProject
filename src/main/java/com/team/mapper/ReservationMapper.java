package com.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team.domain.PageDTO;
import com.team.domain.ReservationDTO;

@Mapper
public interface ReservationMapper {

	/////////////////// 관리자 //////////////////////
//	List<ReservationDTO> reservationList(PageDTO pDto);
	List<ReservationDTO> reservationList();
	
	int totalCnt(PageDTO pDto);
	
	void reservationConfirmed(int rno);
	
	void reservationCancel(int rno);
	
	List<ReservationDTO> calendarList();
	
	
	
	
	/////////////////// 유저 //////////////////////

	List<ReservationDTO> reservationInfo(String rid);
	
	void reservation(ReservationDTO dto);

	List<String> getReservedTimes(String date);

	ReservationDTO getInfo(int rno);

	
}
