package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int bid;
	private String subject;
	private String contents;
	private int hit;
	private String writer;
	private Date reg_date;
	private String mid_fk;
	
	// 일반 게시글과 일대일문의 게시글 구분
	private String type; // 일반 게시글: "GENERAL", 일대일 문의: "QUESTION"
	
	private int replyCnt; // 댓글 카운트
	
	

}
