package com.team.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.MemberDTO;

public interface MemberService {
	
	////////////// 관리자 모드 ////////////////////
	List<MemberDTO> memberList(String id);
	
	MemberDTO memberInfo(String id);
	
	void memberModify(MemberDTO dto);
	
	void memberRemove(String id);
	
	/////////////////// 유저 모드 /////////////////////
	void memberRegister(MemberDTO dto);
	
	// 회원가입시 ID 중복체크
	MemberDTO memberIdCheck(String uid);

	// 회원가입시 인증메일 발송 --> controller에서 다 해줌
	MemberDTO memberEmailCheck(String uEmail);
	
	// 멤버 로그인
	boolean memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes);
	
	String findId(MemberDTO dto);
	
	int findPw(String uid, String uEmail);
	
	MemberDTO myProfile(String id);
		
	MemberDTO idCheck(String uid);
	
	int modifyPw(MemberDTO dto);

	void addPoint(String id, int point);

	void updatePoint(String memberId, int newPoints);

	MemberDTO memberTelCheck(String utel);

	String memberLevelAjax(String id);


}
