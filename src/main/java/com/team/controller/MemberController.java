package com.team.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.domain.CategoryDTO;
import com.team.domain.MemberDTO;
import com.team.domain.ProdPageDTO;
import com.team.domain.ProductDTO;
import com.team.service.CategoryService;
import com.team.service.MemberService;
import com.team.service.ProductService;
import com.team.utill.ProdSpec;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private CategoryService catService;
	
	@Autowired
	private ProductService prodService;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	////////////// 관리자 모드 ////////////////////
	// 회원 리스트
	@RequestMapping("memberList.do")
	public String memberList(Model model, String id) {
		List<MemberDTO> memberList = service.memberList(id);
		model.addAttribute("list", memberList);
		return "admin/ad_memberList";
	}

	// 회원 상세정보
	@RequestMapping("memberInfo.do")
	public String memberInfo(String id, Model model) {
		MemberDTO dto = service.memberInfo(id);
		model.addAttribute("dto", dto);
		return "admin/ad_memberInfo";
	}

	// 회원 수정
	@RequestMapping("memberUpdate.do")
	public String memberUpdate(MemberDTO dto) {
		service.memberModify(dto);

		return "redirect:memberList.do";
	}

	// 회원 삭제
	@RequestMapping("memberDelete.do")
	public String memberDelete(String id) {
		service.memberRemove(id);

		return "redirect:memberList.do";
	}

	// 회원리스트 Ajax요청 처리
	@RequestMapping("memberAjaxList.do")
	public @ResponseBody List<MemberDTO> memberAjaxList(String id) {
		List<MemberDTO> memberList = service.memberList(id);

		return memberList;
	}

	/////////////////// 유저 모드 /////////////////////

	/////////////////// 홈 /////////////////////
	@RequestMapping("/userMainForm.do")
	public String userMainForm(String pSpec, HttpServletRequest request, Model model, ProdPageDTO pDto) {
		ServletContext application = request.getServletContext();
						
		List<CategoryDTO> categoryList = catService.categoryList();
		application.setAttribute("categoryList", categoryList);

		ProdSpec[] pdSpecs = ProdSpec.values();
		application.setAttribute("pdSpecs", pdSpecs);		
		
		Map map = new HashMap();
		for (ProdSpec ps : pdSpecs) {
			pSpec = ps.name();
			List<ProductDTO> dto = prodService.getProdBySpec(pSpec);
			map.put(pSpec, dto);
		}
		
		Set key = map.keySet();
		model.addAttribute("key", key);
		model.addAttribute("map", map);
//		System.out.println("key : " + key);
//		System.out.println("map : " + map);		
		
		return "include/home";

	}

	/////////////////// 회원가입 /////////////////////
	// 회원가입폼
	@RequestMapping("memberRegister.do")
	public String memberRegister() {

		return "member/member_register";
	}

	// 회원 가입
	@RequestMapping("memberInsert.do")
	public String memberInsert(MemberDTO dto) {
		service.memberRegister(dto);		

		return "redirect:userMainForm.do";
	}

	// ID 중복체크
	@RequestMapping("memberIdCheck.do")
	@ResponseBody
	public String memberIdCheck(@RequestParam("uid") String uid) {
		System.out.println("uid : " + uid);

		MemberDTO dto = service.idCheck(uid);
		// 아이디가 DB에 있거나 빈값이 넘어왔을때
		if (dto != null || "".equals(uid.trim())) {
			return "no";
		}

		// 아이디가 없는 경우
		return "yes";
	}

	// 회원 등록폼에서 전화번호 중복체크 ajax
	@RequestMapping("/memberTelCheck.do")
	@ResponseBody
	public String memberTelCheck(@RequestParam("utel") String utel) {
		MemberDTO dto = service.memberTelCheck(utel);

		//아이디가 중복되거나 || 빈값이 넘어왔을때
		if (dto != null || "".equals(utel.trim())) {
			return "no";
		}
		// 아이디 중복이 아닌경우 (dto.uid가 null 인 경우)
		return "yes"; // 바로 View -> 자바스크립트로 yes 데이터가 넘어감
	}
	
	// 이메일 체크
	@RequestMapping("memberEmailCheck.do")
	@ResponseBody
	public String emailCheck(@RequestParam("uEmail") String uEmail) {

//		      String uuid = UUID.randomUUID().toString();
//		      System.out.println(uuid);            

		// 인증코드 생성
		String uuid = UUID.randomUUID().toString().substring(0, 6);
		System.out.println(uuid);

		// MimeMessage 객체 생성 : 데이터 전송
		MimeMessage mail = mailSender.createMimeMessage();

		// 메일 내용
		String mailContents = "<h3>이메일 주소 확인</h3><br/>" + "<span>사용자가 본인임을 확인하려고 합니다. 아래의 코드를 입력하세요!!</span>" + "<h2>"
				+ uuid + "</h2>";

		// 이메일이 유효하면 try블럭은 에러없이 수행되고
		// uuid를 제대로 반환, 이메일이 유효하지 않으면 예외발생

		try {
			// 메일 제목
			mail.setSubject("jh아카데미 [이메일 인증]", "utf-8");
			// 메일 내용 셋팅
			mail.setText(mailContents, "utf-8", "html");

			// 수신자 셋팅, 인터넷 주소체계로 변환
			mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
			mailSender.send(mail);

			return uuid;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "fail";
	}

	/////////////////// 회원 로그인 /////////////////////
	// 로그인 페이지 이동
	@GetMapping("/login.do")
	public String loginForm(String moveUrl, Model model) {
		model.addAttribute("moveUrl", moveUrl);
		return "login/loginForm";
	}

	// 로그인
	@PostMapping("/login.do")
	public String memberLogin(String moveUrl, MemberDTO dto, HttpServletRequest req, Model model, RedirectAttributes redirectAttributes ) {
		boolean result = service.memberLogin(dto, req, redirectAttributes);
		model.addAttribute("moveURL", moveUrl);
		
		if (!result) { // 로그인 실패
			// redirect은 get 방식
			return "redirect:login.do?moveUrl"+moveUrl;
		}

		if (!moveUrl.equals("")) {
			return "redirect:" + moveUrl;
		}
		return "redirect:userMainForm.do";
	}
	
	
	// 로그아웃
	@GetMapping("logout.do")
	public String memberLogout(HttpSession session) {
		session.invalidate(); // 세션 초기화

		return "redirect:/";
	}
	
	
	/////////////////// 회원등급 /////////////////////
	// 회원등급 표시(ajax)
	@GetMapping("memberLevel.do")
	@ResponseBody
	public String memberLevelAjax(Model model, HttpSession session) {
		 // 세션에서 loginDTO 객체를 가져와서 id를 추출
	    MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
	        
	    String id = dto != null ? dto.getId() : null;

	    if (id == null) {
	        System.out.println("####로그인된 사용자 정보가 없습니다.");
	        return "level"; // 로그인 정보가 없으면 장바구니 수량을 0으로 설정
	    }

	    try {
	        // 장바구니 수량을 가져오기
	        String level = service.memberLevelAjax(id);
	        return level != null ? level : "level"; // null 체크 후 0 반환
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	        return "level"; // 예외 발생 시 장바구니 수량을 0으로 설정
	    }
	}	

	
	/////////////////// 아이디/비밀번호 찾기 /////////////////////
	// 아이디 비밀번호 찾기 이동
	@GetMapping("/idPwFind.do")
	public String idPwFind(String find, Model model) {
	model.addAttribute("find", find);
	System.out.println("find: "+ find);
	
	return "login/idPwFind";
	}
	
	// 아이디 찾기
	@PostMapping("/findId.do")
	@ResponseBody
	public String findId(MemberDTO dto) {
	System.out.println(dto);
	String findId = service.findId(dto);
	
	return findId;
	}
	
	// 비밀번호 찾기
	@PostMapping("/findPw.do")
	@ResponseBody
	public int findPw(String uid, String uEmail) {
	int n = service.findPw(uid, uEmail);
	return n;
	}
	

	// @Autowired
	// private ProductDAO pDao;

	// Message Converter API : jackson
	// ==> JSON형식의 데이터를 자바객체로, 반대로 자바객체 JSON형식으로 변환해줌

	// Ajax 전송 데이터는 HTTP Message의 body에 담아서 전송한다.
	// @ResponseBody : 서버 --> 클라이언트
	// @RequestBody : 클라이언트 --> 서버

	/////////////////// 마이 프로필 /////////////////////
	// 마이 프로필 이동
	@GetMapping("/myProfile.do")
	public String myProfile(String id, Model model, HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
		id = dto.getId();
		
		MemberDTO mDto = service.myProfile(id);
		model.addAttribute("mDto", mDto);
		
		return "member/member_myProfile";
	}
	
	
	// 비밀번호 변경페이지 이동
	@GetMapping("/pwChange.do")
	public String pwChange() {
		return "member/member_pwChange";
	}

	// 비밀번호 확인
	@PostMapping("/pwCheck.do")
	@ResponseBody
	public String pwCheck(String pw, HttpSession session) {
		// 로그인 시 session에 저장된 loginDTO를 활용하면 DB에 접근하지 않아도 DB의 비밀번호를 알 수 있다.
		MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
		String dbPw = dto.getPw();
//		System.out.println("pw : @@@@@@@@" + pw);

		String chkResult = "";
		if (pwEncoder.matches(pw, dbPw)) {
			chkResult = "ok";
		} else {
			chkResult = "no";
		}
		return chkResult;
	}
	
	// 비밀번호 변경
	@PostMapping("/pwChange.do")
	@ResponseBody
	public int pwChange(@RequestBody MemberDTO dto) {
//		System.out.println("dto : @@@@@" + dto);
		int n = service.modifyPw(dto);
		System.out.println("n : " + n);
		return n;
	}

}
