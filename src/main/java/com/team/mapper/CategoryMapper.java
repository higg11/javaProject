package com.team.mapper;

import java.util.List;

import com.team.domain.AdminDTO;
import com.team.domain.CategoryDTO;

public interface CategoryMapper {

	AdminDTO adminLogin(AdminDTO dto);

	void categoryInsert(CategoryDTO dto);

	List<CategoryDTO> categoryList();

	void categoryDelete(Integer cat_num);

	

}
