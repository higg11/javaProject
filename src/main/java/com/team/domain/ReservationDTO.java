package com.team.domain;

import java.util.List;

import com.team.utill.ReservationStatus;

import lombok.Data;

@Data
public class ReservationDTO {
	private int rno;
	private String rid_fk;
	private String date;
	private String time;
	private String contents;
	private ReservationStatus reservationStatus ;
//	private ReservationStatus status = ReservationStatus.PENDING;
	private int amount;
		
	private List<String> reservedTimes; // 예약된 시간 목록	
	private String reservation_month;
	
}
