package com.team.utill;

public enum PointType {

	DONATION("기부"),
	RECYCLE("리사이클"),
	USED("포인트사용"),
	OBTAINED("포인트적립");
	
	private final String value;
	
	private PointType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}