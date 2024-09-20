package com.team.service;

import java.util.List;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.MemberDTO;
import com.team.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired // 의존성 추가
	private MemberMapper mapper;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	
	// 멤버 리스트
	@Override
	public List<MemberDTO> memberList(String id) {
		return mapper.memberList(id);
	}
	
	// 멤버 등록
	@Override
	public void memberRegister(MemberDTO dto) {
		String plainPw = dto.getPw(); // 회원가입시 입력된 평문 비번
		String chiperPw = pwEncoder.encode(plainPw);
		dto.setPw(chiperPw); // 암호화된 비번을 dto에 셋팅
		mapper.memberInsert(dto);
	}

	// 멤버 상세정보
	@Override
	public MemberDTO memberInfo(String id) {
		return mapper.memberInfo(id);
	}
	
	@Override
	public MemberDTO myProfile(String id) {
		return mapper.myProfile(id);
	}

	// 멤버 삭제
	@Override
	public void memberRemove(String id) {
		mapper.deleteMember(id);
	}

	// 멤버 수정
	@Override
	public void memberModify(MemberDTO dto) {
		mapper.memberUpdate(dto);
	}

	// 멤버 아이디체크
	@Override
	public MemberDTO idCheck(String uid) {
		return mapper.idCheck(uid);
	}
	
	@Override
	public MemberDTO memberTelCheck(String utel) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public MemberDTO memberIdCheck(String uid) {
		return mapper.memberIdCheck(uid);
	}

	@Override
	public MemberDTO memberEmailCheck(String uEmail) {
		return mapper.memberEmailCheck(uEmail);
	}

	// 멤버 로그인
	@Override
	public boolean memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		HttpSession session = req.getSession();

		// 입력아이디와 일치하는 회원정보를 DTO에 담아서 가져옴
		MemberDTO loginDTO = mapper.memberLogin(dto);

		System.out.println("loginDTO : " + loginDTO);
		System.out.println("dto : " + dto);

		// 암호화 후 -------------------
		if (loginDTO != null) {// 일치하는 아이디가 존재
			String inputPw = dto.getPw(); // 입력 비번
			String dbPw = loginDTO.getPw(); // 암호화된 비번

			if (pwEncoder.matches(inputPw, dbPw) || inputPw.equals(dbPw)) { // 비번 일치
				session.setAttribute("loginDTO", loginDTO);
//				session.setAttribute("mode", "user");
				return true;
			} else { // 비번 불일치
				redirectAttributes.addFlashAttribute("loginErr", "pwdErr"); // 비번 불일치
				return false;
			}
		}
		redirectAttributes.addFlashAttribute("loginErr", "idErr");
		return false; // 아이디 불일치
	}
	
	
	// 아이디 찾기
	@Override
	public String findId(MemberDTO dto) {
		String findId = mapper.findId(dto);
		return findId;
	}
	
	// 비번 찾기(임시비밀번호 발송)
	@Override
	public int findPw(String uid, String uEmail) {
		// 임시 비밀번호 생성
		String tempPw = UUID.randomUUID().toString().substring(0, 8);

		// MimeMessage 객체 생성 : 데이터 전송
		MimeMessage mail = mailSender.createMimeMessage();

		// 메일 내용
		String mailContents = "<h3>임시 비밀번호 발급</h3><br/>" + "<h2>" + tempPw + "</h2>"
				+ "<p>로그인 후 마이페이지에서 비밀번호를 변경하시면 됩니다.</p>";

		try {
			// 메일 제목
			mail.setSubject("jh아카데미 [임시 비밀번호]", "utf-8");
			// 메일 내용 셋팅
			mail.setText(mailContents, "utf-8", "html");

			// 수신자 셋팅, 인터넷 주소체계로 변환
			mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
			mailSender.send(mail);

		} catch (Exception e) {
			e.printStackTrace();
		}
		int n = mapper.findPw(uid, uEmail, tempPw);
		return n;
	}
	
	// 비밀번호 변경
	@Override
	public int modifyPw(MemberDTO dto) {
		MemberDTO mDto = mapper.memberInfo(dto.getId());
	    if (mDto == null) {
	        // 사용자가 존재하지 않음
	        return -1;
	    }

	    String dbPw = mDto.getPw();
	    
	    // 디버깅을 위한 로그 출력
	    System.out.println("입력된 현재 비밀번호 (암호화 전): " + dto.getPw());
	    System.out.println("데이터베이스에 저장된 암호화된 비밀번호: " + dbPw);
	    
	    // 비밀번호가 일치하는지 확인
	    boolean passwordMatches = pwEncoder.matches(dto.getPw(), dbPw);
	    
	    // 디버깅 결과 로그 출력
	    System.out.println("비밀번호 일치 여부: " + passwordMatches);
	    
	    if (pwEncoder.matches(dto.getPw(), dbPw)) {
	        // 비밀번호가 일치하면 새 비밀번호를 암호화하여 업데이트
	        String encodedNpw = pwEncoder.encode(dto.getNpw());
	        dto.setNpw(encodedNpw);

	        // 새 비밀번호로 업데이트
	        int n = mapper.updatePw(dto);
	        System.out.println("업데이트된 레코드 수: " + n);
	        return n;
	    } else {
	        // 비밀번호가 일치하지 않으면 업데이트 실패
	        return -1;
	    }
	}

	
	// 예약확정시 공병수량에 따른 포인트 지급
	@Override
	public void addPoint(String id, int point) {
		
		mapper.addPoint(id, point);
	}

	@Override
	public void updatePoint(@Param("memberId") String id, @Param("newPoints") int point) {
		
		mapper.updatePoint(id, point);
	}
	
	// 회원 등급 표시(ajax)
	@Override
	public String memberLevelAjax(String id) {
		
		return mapper.memberLevelAjax(id);
	}




}
