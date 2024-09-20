package com.team.utill;

public enum MemberLevel {

	LEVEL1("씨앗등급"),
	LEVEL2("새싹등급"),
	LEVEL3("잎새등급"),
	LEVEL4("열매등급"),
	LEVEL5("나무등급");
	
	private final String value;
	
	private MemberLevel(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}