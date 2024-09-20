package com.team.domain;

import java.util.Date;

import com.team.utill.PointType;

import lombok.Data;

@Data
public class PointDTO {

	private int point_num;
	private String id;
	private int point;
	private Date date;
	private PointType pointType;
	

	// 기부금 그래프 (관리자홈페이지)
	private String donation_month;
	private String monthlyAmount;
	
	// 포인트 정보 페이지(유저)
	private String myPoint;
	
}
