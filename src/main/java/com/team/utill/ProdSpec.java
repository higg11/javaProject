package com.team.utill;

public enum ProdSpec {

	ECO("친환경"), ORGANIC("유기농"), REFILL("리필");
	
	private final String value;
	
	private ProdSpec(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}
