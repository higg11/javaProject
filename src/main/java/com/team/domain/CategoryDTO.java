package com.team.domain;

import lombok.Data;

@Data
public class CategoryDTO {
	
	private Integer cat_num;
	private String cat_code;
	private String cat_name;
	
	public CategoryDTO(Integer cat_num, String cat_code, String cat_name) {
		super();
		this.cat_num = cat_num;
		this.cat_code = cat_code;
		this.cat_name = cat_name;
	}
	
}
