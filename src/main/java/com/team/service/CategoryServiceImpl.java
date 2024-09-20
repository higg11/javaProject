package com.team.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.team.domain.AdminDTO;
import com.team.domain.CategoryDTO;
import com.team.mapper.AdminMapper;
import com.team.mapper.CategoryMapper;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryMapper catMapper;
	
	@Override
	public void categoryRegister(CategoryDTO dto) {
		catMapper.categoryInsert(dto);		
	}

	@Override
	public List<CategoryDTO> categoryList() {
		return catMapper.categoryList(); 
	}

	@Override
	public void categoryDelete(Integer cat_num) {
		catMapper.categoryDelete(cat_num);		
	}

	

}
