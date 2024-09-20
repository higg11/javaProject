package com.team.service;

import java.util.List;

import com.team.domain.BoardDTO;
import com.team.domain.PageDTO;

public interface BoardService {
	
	///////////////////// 전체 게시판 ////////////////////////////
	void register(BoardDTO dto);
	
	List<BoardDTO> getList(PageDTO pDto);
	
//	List<BoardDTO> getGeneralPosts();
	
	BoardDTO view(int bid, String mode, String loginId);
	
	void modify(BoardDTO dto);

	void remove(int bid);

	
	
	//////////////////////  1:1 문의하기 //////////////////////////////
	void myQuestion(BoardDTO dto);

//	List<BoardDTO> myQuestionList(String mid_fk);
	
	List<BoardDTO> getQuestionPosts(PageDTO pDto, String mid_fk);

//	List<BoardDTO> getQuestionPosts(PageDTO pDto);

	List<BoardDTO> getListQT(PageDTO pDto);

	BoardDTO questionView(int bid);


	
}
