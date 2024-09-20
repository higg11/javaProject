package com.team.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.team.domain.MemberDTO;
import com.team.domain.ReplyDTO;
import com.team.domain.ReplyPageDTO;

public interface ReplyService {
	int register(ReplyDTO rDto);
	
	int remove(int rno);
	
	int modify(ReplyDTO rDto);
	
	ReplyDTO read(int rno);
	
//	List<ReplyDTO> getList(int bid, int vp);
	ReplyPageDTO getList(int bid, int vp);
	
}
