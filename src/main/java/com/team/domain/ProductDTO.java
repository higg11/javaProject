package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDTO {
	
	private int pnum;
	private String pname;
	private String pcategory_fk;
	private String pcompany;
	private String pimage;
	private int pqty;
	private int price;
	private String pspec;
	private String pcontent;
	private int point;
	private Date pinput_date;
	
	private String keyword;
	private String searchType;
	
	
	
	public ProductDTO() {}

	public ProductDTO(int pnum, String pname, String pcategory_fk, String pcompany, String pimage, int pqty, int price,
			String pspec, String pcontent, int point, Date pinput_date, String keyword, String searchType) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.pcategory_fk = pcategory_fk;
		this.pcompany = pcompany;
		this.pimage = pimage;
		this.pqty = pqty;
		this.price = price;
		this.pspec = pspec;
		this.pcontent = pcontent;
		this.point = point;
		this.pinput_date = pinput_date;
		this.keyword = keyword;
		this.searchType = searchType;
	}
	
}
