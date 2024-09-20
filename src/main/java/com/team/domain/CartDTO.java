package com.team.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartDTO {
	
	// 카트 dto
	private int cart_num;
	private String cid_fk;
	private int pnum_fk;
	private int pqty;
	private Date indate;
	private String type;
	
	// 상품 dto
	private String pname;
	private String pimage;
	private int price;
	private int point;
	private String pspec;
	
	// total 가격 및 포인트
	private int totPrice;
	private int totPoint;
	
	private int tot_pqty;
	
	public void setTotal() {
		this.totPrice = this.pqty*price;
		this.totPoint = this.pqty*point;
	}


	public CartDTO() {}	
	
	@Override
	public String toString() {
		return "CartDTO [cart_num=" + cart_num + ", cid_fk=" + cid_fk + ", pnum_fk=" + pnum_fk + ", pqty=" + pqty + ", indate="
				+ indate + ", pname=" + pname + ", pimage=" + pimage + ", price=" + price + ", point=" + point
				+ ", pspec=" + pspec + ", totPrice=" + totPrice + ", totPoint=" + totPoint + ", type=" + type +"]";
	}
	
}
