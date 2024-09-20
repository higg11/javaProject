package com.team.mapper;

import java.util.List;

import com.team.domain.MemberDTO;


public interface MemberMapper {

	List<MemberDTO> memberList(String id);
	
	void memberInsert(MemberDTO dto);
	
	// 회원가입시 ID 중복체크
	MemberDTO memberIdCheck(String uid);

	// 회원가입시 인증메일 발송 --> controller에서 다 해줌
	MemberDTO memberEmailCheck(String uEmail);
	
	MemberDTO memberInfo(String id);
	
	MemberDTO myProfile(String id);

	void deleteMember(String id);
	
	void memberUpdate(MemberDTO dto);
	
	MemberDTO idCheck(String uid);
	
	// 멤버 로그인
	MemberDTO memberLogin(MemberDTO dto);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail, String tempPw);

	int updatePw(MemberDTO dto);

	void addPoint(String id, int point);

	void updatePoint(String id, int point);
	
	// 등급
	void upgradeLevel(MemberDTO mDto);
	
	int getTotalPaid(String id);

	String memberLevelAjax(String id);

}
