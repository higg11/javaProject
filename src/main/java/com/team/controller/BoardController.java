package com.team.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team.domain.BoardDTO;
import com.team.domain.MemberDTO;
import com.team.domain.PageDTO;
import com.team.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
		
	
	@GetMapping("/registerBoard.do")
	public String register() {
		
		return "board/boardRegister";
	}
	
	@PostMapping("/registerBoard.do")
	public String register(BoardDTO dto, HttpSession session) {

		// 임의 게시글 123개 생성
//		for(int i=1; i<=123; i++) {
//			BoardDTO bDto = new BoardDTO();
//			bDto.setSubject(i + "번째 제목입니다~~~");
//			bDto.setContents(i + "번째 내용입니다~~~");
//			bDto.setWriter("아무개 " + (i%10));
//			service.register(bDto);
//		}
		
		// 게시글 타입 설정 (예: 일반 게시글)
	    dto.setType("GENERAL");
				
		service.register(dto);
		return "redirect:list.do";
	}
	
	// 게시글 가져오기 (일반 게시글과 일대일문의 게시글 구분)
	@RequestMapping("/list.do")
	public String myBoardList(PageDTO pDto, Model model) {
		
        // 일반 게시글 불러오기
        List<BoardDTO> generalPosts = service.getList(pDto);

        // 모델에 데이터 추가
        model.addAttribute("generalPosts", generalPosts);
        
        // serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);

        return "board/boardList";
    }
		
	// 글상세보기
	@GetMapping("/view.do")
	public String view(int bid, PageDTO pDto, Model model, HttpSession session) {
		 // 세션에서 로그인 ID를 가져옴 (본인 조회 시 조회수 카운트 방지)
	    MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
	    if (loginDTO == null) {
	        return "redirect:login.do"; // 로그인되지 않은 경우 리디렉션
	    }
	    String loginId = loginDTO.getId();
		
		BoardDTO dto = service.view(bid, "v", loginId);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		
		return "board/boardView";
	}
	
	// 수정페이지 이동
	@GetMapping("/modify.do")
	public String modifyForm(PageDTO pDto, int bid, Model model) {
		System.out.println("vp : " + pDto.getViewPage());
		BoardDTO dto = service.view(bid, "m", "x");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		System.out.println("vp2 : " + pDto.getViewPage());
		
		return "board/boardModify";
	}
	
	// 게시글 수정하기
	@PostMapping("/modify.do")
	public String modify(PageDTO pDto, BoardDTO dto, Model model) {
		service.modify(dto);
		
		int viewPage = pDto.getViewPage();
		System.out.println("vp ======> " +viewPage);
		model.addAttribute("viewPage", viewPage);
		model.addAttribute("searchType", pDto.getSearchType());
		model.addAttribute("keyword", pDto.getKeyword());
		model.addAttribute("cntPerPage", pDto.getCntPerPage());
		
		return "redirect:list.do";
	}
	
	// 게시글 삭제
	@GetMapping("/remove.do")
	public String remove(PageDTO pDto, int bid, Model model) {
		service.remove(bid);		
		model.addAttribute("viewPage", pDto.getViewPage());
		 
		// redirect 시 model에 바인딩된 값은 queryString으로 전달된다.
		// PageDTO 객체는 queryString으로 전달될 수 없음(int, String은 가능)
		return "redirect:list.do";
	}
	
	
	
	//////////////////////  1:1 문의하기  //////////////////////////////
	// 일대일문의하기 페이지 이동
	@GetMapping("/myQuestion.do")	
	public String question() {		
		
		return "board/myQuestion";		
	}	
	
	// 일대일 문의하기
	@PostMapping("/myQuestion.do")
	public String myQuestion(BoardDTO dto, HttpSession session) {
		
		 // 세션에서 사용자 정보를 가져올 때, loginDTO 객체에서 id를 가져옵니다.
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");

	    // loginDTO가 null인지 확인
	    if (loginDTO != null) {
	        String mid_fk = loginDTO.getId();
	        dto.setMid_fk(mid_fk);

	        System.out.println("bbs_mid_fk : " + mid_fk);
	    } else {
	        // 로그인이 되어있지 않으면 로그인 페이지로 리디렉션
	        return "redirect:login.do";
	    }
	    
		// 게시글 타입 설정 (예: 일반 게시글)
	    dto.setType("QUESTION");
		
		service.myQuestion(dto);
		
		
		return "redirect:myQuestionList.do";
	}	
	
	// 일대일 문의내용 게시글 불러오기
	@RequestMapping("/myQuestionList.do")	
	public String myQuestionList(PageDTO pDto, String mid_fk, Model model, HttpSession session) {	

        // 세션에서 로그인 ID를 가져옴
        if (mid_fk == null || mid_fk.isEmpty()) {
            MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
            if (loginDTO != null) {
                mid_fk = loginDTO.getId();
            } else {
                return "redirect:login.do"; // 로그인이 되어 있지 않으면 로그인 페이지로 리디렉션
            }
        }
        
		List<BoardDTO> questionPosts = service.getQuestionPosts(pDto, mid_fk);
		
		model.addAttribute("questionPosts", questionPosts);
		
		// serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);
	
		return "board/myQuestionList";
	}
	
	// 관리자 문의관리 페이지 게시글 불러오기
	@RequestMapping("/adQuestionList.do")
	public String listQT(PageDTO pDto, Model model) {		
		List<BoardDTO> qList = service.getListQT(pDto);
		model.addAttribute("qList", qList);
						
		// serviceImpl에서 셋팅된 pDto
		model.addAttribute("pDto", pDto);
		
		return "admin/ad_question_list";
	}
	
	// 관리자 일대일문의 상세페이지
	@GetMapping("/questionView.do")
	public String questionView(int bid, PageDTO pDto, Model model) {
		 // 세션에서 로그인 ID를 가져옴
//	    MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
//	    if (loginDTO == null) {
//	        return "redirect:login.do"; // 로그인되지 않은 경우 리디렉션
//	    }
//	    String loginId = loginDTO.getId();
		
		
		BoardDTO dto = service.questionView(bid);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);
		
		return "admin/ad_questionView";
	}
	
}
