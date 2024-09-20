package com.team.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.CategoryDTO;
import com.team.domain.PageDTO;
import com.team.domain.ProdPageDTO;
import com.team.domain.ProductDTO;
import com.team.service.CategoryService;
import com.team.service.ProductService;
import com.team.utill.ProdSpec;




@Controller
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private CategoryService catService;
	
	//////////////////////관리자 모드 ////////////////////////
	
	// 상품 등록 페이지 이동
	@GetMapping("prodInput.do")
	public String prodInputForm(Model model) {
		
		// 카테고리 리스트 뷰에 넘겨주기
		List<CategoryDTO> categoryList = catService.categoryList();
		model.addAttribute("categoryList", categoryList);
		
		// 상품스펙 리스트 뷰에 넘겨주기
		ProdSpec[] pdSpecs = ProdSpec.values();
		model.addAttribute("pdSpecs", pdSpecs);
		
		return "admin/ad_prod_input";
	}
	
	// 상품 등록
	@PostMapping("prodRegisterOk.do")
	public String insertProduct(MultipartHttpServletRequest mhr, 
		HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException {	
		
		// 파일 저장할 경로
		String repository = "resources/fileRepo";
		
		// 파일을 저장할 실제 서버의 물리경로 얻어오기
		// OS에 따라 \\(윈도우), /(리눅스)
		String savePath = request.getServletContext().getRealPath("")+File.separator+repository;
		System.out.println("savePath : "+ savePath);
		
		////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력
		Map map = new HashMap();
		
		// 1. ***************** 넘길 정보들을 얻어오기 
		// MultipartHttpServletRequest mhr은 일반 텍스트, 바이너리 파일 정보를 모두 얻어 올 수 있는 객체.
		// 뷰딴 인풋의 name 속성의 값인 id와 name = 파라미터값을 가져옴
		Enumeration<String> enu = mhr.getParameterNames();
		// Enumeration 객체 사용
		
		while(enu.hasMoreElements()) {
			// 뷰딴 인풋의 name 속성의 값인 id와 name을 가져오기
			String paramName = enu.nextElement();
			// 해당 파라미터명의 값, input의 value값 (사용자가 입력한 값)
			String paramValue = mhr.getParameter(paramName);
								// id, name : test, 홍길동
			System.out.println(paramName + " : " + paramValue);
		////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력			
		map.put(paramName, paramValue);
		}
		//  *** enu 여기까지가 아래 값들 넘겨줌 ***
		//		pnum : auto_increment
		//		pqty : 2
		//		pcontent : 123
		//		pname : 자바
		//		price : 20000
		//		pcategory_fk : a002
		//		pcompany : 1234
		//		pspec : RECOMMEND
		//		point : 200
		
//		fileParamName : pimage
//		originName : dTree.png
		
		// 2. ***************** 첨부 파일정보 얻어오기 Iterator 객체사용
		Iterator<String> iter = mhr.getFileNames();
////// 불러온 이미지 어레이리스트로 바인딩해서 어레이리스트로 저장 이후 fileUploadResult에 출력
// List<String> fileList = new ArrayList<String>();		// 사진리스트로 안가져오고 pimage만 가져오니까 위 구문 주석

		while(iter.hasNext()) {
			// input의 name값을 가져오기
			String fileParamName = iter.next();
			System.out.println("fileParamName : "+ fileParamName);
			
			// MultipartFile : 파일정보를 갖고 있는 객체
			MultipartFile mFile = mhr.getFile(fileParamName);
			// 첨부된 파일명
			String originName = mFile.getOriginalFilename();
			System.out.println("originName : "+ originName);
			
			// ~ \day05_fileUpDown\\resources/fileRepository/file1
			// 물리경로\\해당파일이름 을 file 주소로 넣어놓기
			File file = new File(savePath+"\\"+fileParamName);
			
			if(mFile.getSize() != 0) { // 사이즈가 0이 아니면 업로드 된경우 (폴더가 존재한 경우)
				if(!file.exists()) { // 폴더가 존재하지만 파일이 존재하지 않으면
					//file.createNewFile();
					if(file.getParentFile().mkdir()) {	// file1의 부모경로로 가서 폴더를 만들고
						file.createNewFile(); // throws 예외처리 진행, 임시파일 생성 // 파일을 만든다
					} // if3
				}	// if2
				
				// 파일이 존재하면
				File uploadFile = new File(savePath+"\\"+originName);
				
				// 중복시 파일명 대체
				if(uploadFile.exists()) {	// 시간을 기준으로 다시 재저장
					originName = System.currentTimeMillis()+"_"+originName;
					uploadFile = new File(savePath+"\\"+originName);
				}
				// 실제 파일 업로드
				mFile.transferTo(uploadFile);
				
				// 파일명을 list에 추가
				//////불러온 이미지 어레이리스트로 바인딩해서 어레이리스트로 저장 이후 fileUploadResult에 출력
				// fileList.add(originName);
			
			}	// if1
			
			// 파일명을 저장한 리스트를 map에 추가
			////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력	
			// map.put("fileList", fileList);
			map.put("pimage", originName);
		} // while
		
		// 서비스로 보냄
		service.prodRegister(map);
		redirectAttributes.addFlashAttribute("msg", "상품 등록 완료!!");
		
		return "redirect:prodList.do";
	} // fileUploadOk
	
	
	/*
	 * // 상품 리스트
	 * 
	 * @GetMapping("prodList.do") public String productList(Model model) {
	 * List<ProductDTO> list = service.productList(); model.addAttribute("list",
	 * list);
	 * 
	 * return "admin/prod_list"; }
	 */
	
	// 상품 리스트
	@GetMapping("prodList.do")
	public String productList(PageDTO pDto, Model model) {
		List<ProductDTO> list = service.productList(pDto);
		model.addAttribute("list", list);		
//		System.out.println("list : " + list);
		model.addAttribute("pDto", pDto);
		
		// 재고 부족 상품
		List<ProductDTO> stock = service.stockList();
		model.addAttribute("stock", stock);
		System.out.println("stockList : " + stock);
		
		return "admin/ad_prod_list";
	}
	

	
	/*
	 * // 홈화면 상품 리스트
	 * 
	 * @GetMapping("homeProdList.do") public String HomeProductList(ProdPageDTO
	 * pDto, Model model) { List<ProductDTO> list = service.homeProductList(pDto);
	 * model.addAttribute("list", list);
	 * 
	 * model.addAttribute("pDto", pDto);
	 * 
	 * return "product/home_card"; }
	 */
	
	// 상품 삭제
	@GetMapping("prodDelete.do")
	public String deleteProduct(int pnum, String pimage, HttpServletRequest request, RedirectAttributes redirectAttributes) {
						
		String repository = "resources/fileRepo";
		String savePath = request.getServletContext().getRealPath("")+File.separator+repository;
		File delFile = null;
		
		 if(pimage != null) {
			  delFile = new File(savePath + "\\" + pimage); //(savePath + "/" + pimage); 경로를 "/" 써줘도 됌
			  if(delFile.exists()) {
				  if(delFile.delete()) {
					  System.out.println("이미지 파일 삭제완료!!");
				  }
			  }
		  }
		
		service.deleteProduct(pnum);  // cnt는 값을가지고 추가로 어떠한 작업을 하고 싶을때 추가(유효성검사 등)
		redirectAttributes.addFlashAttribute("msg", "상품리스트 삭제완료!!");
		
		return "redirect:prodList.do";
	}
	
	// 상품 수정창으로 이동
	@GetMapping("prodUpdate.do")
	public String getProduct(int pnum, Model model) {
		
		// 카테고리 리스트 뷰에 넘겨주기
		List<CategoryDTO> categoryList = catService.categoryList();
		model.addAttribute("categoryList", categoryList);
		
		// 상품스펙 리스트 뷰에 넘겨주기
		ProdSpec[] pdSpecs = ProdSpec.values();
		model.addAttribute("pdSpecs", pdSpecs);
		
		// 상품 dto 뷰에 넘겨주기
		ProductDTO dto = service.getProduct(pnum);
		model.addAttribute("pDto", dto);
		
		return "admin/ad_prod_update";
	}
	
	// 상품 수정
	@PostMapping("prodUpdateOK.do")
	public String updateProduct(MultipartHttpServletRequest mhr,
			HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException {

		String repository = "resources/fileRepo";
				
		String savePath = request.getServletContext().getRealPath("")+File.separator+repository;
		System.out.println("savePath : "+ savePath);
				
		Map map = new HashMap();
				
		Enumeration<String> enu = mhr.getParameterNames();
		while(enu.hasMoreElements()) {
			String paramName = enu.nextElement();
			String paramValue = mhr.getParameter(paramName);								
						
			map.put(paramName, paramValue);
		}
		
		Iterator<String> iter = mhr.getFileNames();

		while(iter.hasNext()) {
			String fileParamName = iter.next();
			System.out.println("fileParamName : "+ fileParamName);
			
			MultipartFile mFile = mhr.getFile(fileParamName);
			String originName = mFile.getOriginalFilename();
						
			if(originName == null || originName.trim().equals("")) {
				originName = mhr.getParameter("pimageOld");
			}
			
			File file = new File(savePath+"\\"+fileParamName);
			
			if(mFile.getSize() != 0) { // 사이즈가 0이 아니면 업로드 된경우 (폴더가 존재한 경우)
				if(!file.exists()) { // 폴더가 존재하지만 파일이 존재하지 않으면
					if(file.getParentFile().mkdir()) {	// file1의 부모경로로 가서 폴더를 만들고
						file.createNewFile(); // throws 예외처리 진행, 임시파일 생성 // 파일을 만든다
					} // if3
				}	// if2
				
				// 파일이 존재하면
				File uploadFile = new File(savePath+"\\"+originName);
				
				// 중복시 파일명 대체
				if(uploadFile.exists()) {	// 시간을 기준으로 다시 재저장
					originName = System.currentTimeMillis()+"_"+originName;
					uploadFile = new File(savePath+"\\"+originName);
				}
				// 실제 파일 업로드
				mFile.transferTo(uploadFile);				
				
			}	// if1
			
			map.put("pimage", originName);
		} // while
		
		// 서비스로 보냄
		service.updateProduct(map);
		redirectAttributes.addFlashAttribute("msg", "상품 수정완료!!");
		return "redirect:prodList.do";		
	}
	
	
	
	///////////////////////// User Product ////////////////////////////////
	// 사진 클릭
	@GetMapping("UprodView.do")
	public String uprodView(int pnum, String pSpec, Model model) {
		
		// 상품스펙
		ProdSpec[] pdSpecs = ProdSpec.values();
		model.addAttribute("pdSpecs", pdSpecs);
		// enum의 값 출력
		String pSpecName = ProdSpec.valueOf(pSpec).getValue();
		model.addAttribute("pSpecName", pSpecName);
		
		
		ProductDTO pDto = service.getProduct(pnum);
		model.addAttribute("pDto", pDto);
			
		return "product/prodView";
	}
	
	// 전체 상품 리스트
	@GetMapping("UprodList.do")
	public String uprodList(Model model) {
		List<ProductDTO> list = service.uprodList();
		model.addAttribute("list", list);
		
		return "product/prodList";
	}
	
	
	// 메뉴 카테고리 리스트 클릭 
	@GetMapping("/UcatList.do")
	public String categoryList(String cat_name, String code, Model model) {
		
		// 카테고리 클릭시 넘어감
		ArrayList<ProductDTO> cList = service.getProdByCategory(code);
		model.addAttribute("cList", cList);
		model.addAttribute("cat_name", cat_name);
		
		return "product/categoryList";
	}	
		
	// 메뉴 스펙 리스트 클릭 
	@GetMapping("UspecList.do")
	public String uspecList(String pSpec, Model model) {
		
		ArrayList<ProductDTO> sList = service.getProdBySpec(pSpec);
		model.addAttribute("sList", sList);
		model.addAttribute("pSpec", pSpec);
		// enum의 값 출력
		String pSpecName = ProdSpec.valueOf(pSpec).getValue();
		model.addAttribute("pSpecName", pSpecName);
		
		
		return "product/specList";
	}
	
	// 상품 검색 리스트
	@RequestMapping("prodSearch.do")
	public String list(ProductDTO pDto, Model model){
		List<ProductDTO> list = service.prodSearch(pDto);
		model.addAttribute("list", list);
		
		// serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);
				
		return "/product/prod_search";
	}
	
	
}
