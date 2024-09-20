package com.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.domain.ReplyDTO;

public interface ReplyMapper {
	int insert(ReplyDTO rDto);
	
	int delete(int rno);
	
	int update(ReplyDTO rDto);
	
	ReplyDTO select(int rno);
	
	// List<ReplyDTO> getListByBid(int bid, int si, int cp);
	List<ReplyDTO> getListByBid(@Param("bid") int bid, @Param("startIndex") int si, @Param("cntPerPage") int cp);
		
	int replyCnt(int bid);
}
