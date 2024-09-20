package com.team.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team.domain.AdminDTO;
import com.team.domain.CategoryDTO;
import com.team.service.AdminService;
import com.team.service.CategoryService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService catService;
	
	// 카테고리 등록 페이지 이동
	@GetMapping("catInput.do")
	public String categoryForm() {
		return "admin/ad_category_input";	
	}
		
	// 카테고리 등록
	@PostMapping("categoryOk.do")
	public String catInsert(CategoryDTO dto) {
		catService.categoryRegister(dto);
		
		return "redirect:catList.do";
	}
	
	// 카테고리 리스트
	@GetMapping("catList.do")
	public String categoryList(Model model) {
		List<CategoryDTO> categoryList = catService.categoryList();
		model.addAttribute("categoryList", categoryList);
		return "admin/ad_category_list";
	}
	
	// 카테고리 삭제
	@GetMapping("catDelete.do")
	public String categoryDelete(Integer cat_num) {
		catService.categoryDelete(cat_num);
		return "redirect:catList.do";
	}
	
	
}
