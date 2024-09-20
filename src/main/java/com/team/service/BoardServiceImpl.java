package com.team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.domain.BoardDTO;
import com.team.domain.PageDTO;
import com.team.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	

	////////////////////// 전체게시판  //////////////////////////////
	
	// 게시글 등록
	@Override
	public void register(BoardDTO dto) {
		mapper.insert(dto);		
	}
		
	// 일반 게시글 불러오기(GENERAL)
	@Override
	public List<BoardDTO> getList(PageDTO pDto) {
		
		int totalCnt = mapper.totalCnt(pDto);
		
		// setValue호출시 startIndex 셋팅됨 		
		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
		return mapper.getList(pDto);
	}
	
	// 게시글 상세보기
	@Override
	public BoardDTO view(int bid, String mode, String loginId) {
		
		BoardDTO dto = mapper.view(bid);
		
		if(mode.equals("v") && !loginId.equals(dto.getMid_fk())) {
			// 조회수 추가
			mapper.hitAdd(bid);
		}
		
		return mapper.view(bid);
	}
	
	// 게시글 수정
	@Override
	public void modify(BoardDTO dto) {		
		mapper.update(dto);
	}
	
	// 게시글 삭제
	@Override
	public void remove(int bid) {
		mapper.delete(bid);
		
	}

	
	//////////////////////1:1 문의하기  //////////////////////////////
	@Override
	public void myQuestion(BoardDTO dto) {
		mapper.myQuestion(dto);		
	}

//	@Override
//	public List<BoardDTO> myQuestionList(String mid_fk) {
//		
//		return mapper.myQuestionList(mid_fk);
//	}
	
	// 일대일 게시글 불러오기(QUESTION)
	@Override
	public List<BoardDTO> getQuestionPosts(PageDTO pDto, String mid_fk) {
		
		return mapper.getPostsByType(pDto, mid_fk, "QUESTION");
	}
	
	// 관리자 문의관리페이지 게시글 불러오기(QUESTION)
	@Override
	public List<BoardDTO> getListQT(PageDTO pDto) {
		
		return mapper.getListQT(pDto);
	}
	
	// 관리자 문의관리페이지 문의사항 상세보기
	@Override
	public BoardDTO questionView(int bid) {
		
		return mapper.questionView(bid);
	}







	
}
