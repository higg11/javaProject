package com.team.utill;

public enum ReservationStatus {

	DONE("예약확정"),
	PENDING("예약대기"),
	CANCEL("예약취소");
	
	private final String value;
	
	private ReservationStatus(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}