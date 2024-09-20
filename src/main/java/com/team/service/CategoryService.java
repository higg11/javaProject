package com.team.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.team.domain.AdminDTO;
import com.team.domain.CategoryDTO;
import com.team.domain.ProductDTO;
import com.team.mapper.AdminMapper;

public interface CategoryService {
	
	// 카테고리 등록 OK
	void categoryRegister(CategoryDTO dto);
	
	// 카테고리 리스트
	List<CategoryDTO> categoryList();
	
	// 카테고리 삭제
	void categoryDelete(Integer cat_num);
	
	
	
}
