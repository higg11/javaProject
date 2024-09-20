package com.team.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String birth_date;
	private String tel;
	private String email;
	private String zipcode;
	private String road_addr;
	private String detail_addr;
	private Timestamp rdate;
	private int point;
	private String level;
	
	private String npw;

	private String cartPqty;

	// 기본 생성자
	public MemberDTO() {

	}

}
