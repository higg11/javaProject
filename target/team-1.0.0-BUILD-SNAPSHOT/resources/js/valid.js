/**
 *  유효성 검사 javascript file -> *.js
 */

// 아이디 중복체크
function idCheck(){
	let uid = $("#id").val();
	
	if(uid.length<4){
		$("#chkMsg").text("아이디 길이는 4자 이상이어야 합니다!!");
		$("#chkMsg").css({"color":"red", "font-size":"13px"})
		$("#isIdCheck").val("no");		// submitChk()에서 사용
		$("uid").select();
		return;
	}

	$.ajax({
		url : "memberIdCheck.do", 
		type : "get", 
		data : {"uid":uid}, 
		success : function(responseData){
			//console.log(responseData);
			if(responseData == "yes"){
				$("#chkMsg").text("사용 가능한 아이디 입니다!!");
				$("#chkMsg").css({"color":"blue", "font-size":"13px"})
				$("#isIdCheck").val("yes");		
			} else {
				$("#chkMsg").text("사용할 수 없는 아이디 입니다!!");
				$("#chkMsg").css({"color":"red", "font-size":"13px"})
				$("#isIdCheck").val("no");		
				$("id").select();
			}
		}, 
		error : function(){alert("Server Error")} 
	});
}

// 비밀번호 길이 체크 (onkeyup)
function pwKeyupCheck(){
	let upw = $("#pw").val();
	let pwText = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*?])[a-z\d!@#$%^&*?]{9,}$/;
	
	if(upw.length < 9){
		$("#chkMsg2").text("비밀번호 길이는 9자리 이상이어야 합니다!!");
		$("#chkMsg2").css({"color":"red", "font-size":"13px"})
		$("#isPwCheck").val("no");		

		return;
	}else if(!pwText.test(upw)){
		$("#chkMsg2").text("비밀번호는 반드시 소문자, 숫자, 특수키가 하나 이상 조합되어야 합니다!!");
		$("#chkMsg2").css({"color":"red", "font-size":"13px"})
		$("#isPwCheck").val("no");	
		$("#pw").focus();
		return;
	} else if(pwText.test(upw)){
		$("#chkMsg2").text("사용 가능한 비밀번호 입니다!!");
		$("#chkMsg2").css({"color":"blue", "font-size":"13px"})

	} else{
		$("#chkMsg2").text("소문자, 숫자, 특스키를 조합하여 생성하세요!!");
		return;
	}	
}

// 비밀번호 9자리 이상 조합 확인(삭제)///////////////////////////////////////////////////
function pwBlurCheck(){
	let upw = $("#pw").val();
	let pwText = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{9,}$/ 
	
	if(!pwText.test(upw)){
		$("#chkMsg2").text("비밀번호는 반드시 소문자, 숫자, 특수키가 하나 이상 조합되어야 합니다!!");
		$("#chkMsg2").css({"color":"red", "font-size":"13px"})
		$("#isPwCheck").val("no");	
		$("#pw").focus();
		return;
	} else if(pwText.test(upw)){
		$("#chkMsg2").text("사용 가능한 비밀번호 입니다!!");
		$("#chkMsg2").css({"color":"blue", "font-size":"13px"})
	} else{
		$("#chkMsg2").text("소문자, 숫자, 특스키를 조합하여 생성하세요!!");
	}	
}

// 비밀번호 재확인
function pwConfirmCheck(){
	let upw = $("#pw").val();
	let upw2 = $("#pwConfirm").val();
	
	if(upw != upw2){
			$("#chkMsg3").text("다시 한번 비밀번호를 일치하게 입력해주세요!!");
			$("#chkMsg3").css({"color":"red", "font-size":"13px"})
			$("#isPwCheck").val("no");		
			$("#pwConfirm").focus();
			return;
		} else {
			$("#chkMsg3").text("비밀번호 재확인 완료입니다!!");
			$("#chkMsg3").css({"color":"blue", "font-size":"13px"})
			$("#isPwCheck").val("yes");		
		}
}
	
// 이름 체크
function nameCheck(){
	let uname = $("#name").val();
	 console.log("입력값:", uname);
	let nameText = /^[가-힣]+$/;
	if(!nameText.test(uname)){
		$("#chkMsg4").text("이름은 한글로 입력하세요!!");
		$("#chkMsg4").css({"color":"red", "font-size":"13px"})
		$("#isNameCheck").val("no");	
		$("#name").focus();
		return;
	} else{
		$("#chkMsg4").text("");
		$("#isNameCheck").val("yes");
	}	
}

// 생년월일 입력 문자의 수를 체크(onkeyup)
function birthKeyupCheck() {
    let ubirth = $("#birth").val();
    
    if (ubirth.length < 6 || ubirth.length > 6 ) {
        $("#chkMsg5").text("생년월일은 6자리입니다!!");
        $("#chkMsg5").css({"color":"red", "font-size":"13px"});
        $("#isBirthCheck").val("no");
    } else {
        // 6자 이상일 때는 에러 메시지를 제거
        $("#chkMsg5").text("");
        $("#isBirthCheck").val("yes");
    }
}

// 생년월일 형식 체크(onblur)
function birthBlurCheck() {
    let ubirth = $("#birth").val();
    let birthText = /^([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))$/;
    
    if (!birthText.test(ubirth)) {
        $("#chkMsg5").text("생년월일을 정확히 입력하세요!!");
        $("#chkMsg5").css({"color":"red", "font-size":"13px"});
        $("#isBirthCheck").val("no");
        $("#birth").focus();
    } else {
        // 형식이 맞을 때는 에러 메시지를 제거
        $("#chkMsg5").text("");
        $("#isBirthCheck").val("yes");
    }
}

// 전화번호 체크
function telCheck(){
	let utel = $("#tel").val(); 
	let telText = /^\d{10,11}$/;
	
	if(!telText.test(utel)){
		$("#chkMsg6").text("하이픈(-)없이 올바르게 입력해주세요!!");
		$("#chkMsg6").css({"color":"red", "font-size":"13px"})
		$("#isTelCheck").val("no");		

		return;
	} else{
		$("#chkMsg6").text("");
		$("#chkMsg6").css({"color":"blue", "font-size":"13px"})
		$("#isTelCheck").val("yes");	
	}
}

// 이메일 체크
let time_display;
let timer;
// timer 동작 함수
function timer_start(){
	timer_stop();
	
	let count = 180;
	time_display = $('.time');
	time_display.val("03:00");
	
	// 타이머 설정시 사용하는 함수 
	// timer = setInterval(function, 1000) : 1초마다 function을 주기적으로 호출
	// clearInterval(timer) : timer 함수를 종료시켜주는 역할
	timer = setInterval(()=>{
		let minutes = parseInt(count / 60);	// count/60, 10진수로 변경 // 뒤에 , 10은 생략가능
		let seconds = parseInt(count % 60);
		
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		
		time_display.val(minutes + ":" + seconds);
		
		// timer 종료
		if(--count < 0){
			timer_stop();
			time_display.val("시간초과");
			$(".code-msg").css({"display": "block", "color" :"red"});// main.css에서도 사용되기때문에 여러개 중복으로 css가 사용될땐 {} 사용
			$(".code-msg").text("인증코드가 만료되었습니다!!");
			$("#code-send").removeClass("disabled");
			$("#code-send").val("코드 재발송");
			$("#confirm-btn").addClass("disabled");
			$(".input-code").val("");
			$(".input-code").attr("readonly", true);
			$("#email").attr("readonly", false);

		}
	}, 1000)
	
}
// timer 종료
function timer_stop(){
	isEmailCheck = false;
	clearInterval(timer);
}

// 이메일 인증코드 보내기
// 모든함수에서 사용하도록 responseUUID를 전역변수로 설정
let responseUUID = "";
let isEmailCheck = false; // submitChk()에서 사용, 이메일 체크확인, 기본값 false

function emailCheck(){
	let uEmail = $("#email").val(); // 사용자가 입력한 이메일 id="email"

	if($("#email").val() == ""){
		$(".code-msg0").css({"color":"red", "font-size":"13px"});
		$(".code-msg0").text("이메일을 정확하게 입력하세요.");
	} else {
		$("#code-send").addClass("disabled");
		$("#confirm-btn").removeClass("disabled");
		$("#email").attr("readonly", true);
		$(".code-msg0").css({"color":"red", "font-size":"13px"});
		$(".code-msg0").text("이메일을 전송 중...");
	}
	
	$.ajax({
		url : "memberEmailCheck.do",
		type : "get",
		data : {"uEmail":uEmail},
		success: function(UUID){	// responseEmail 서버에서 전달된 값(return uuid 또는 return fail)
			responseUUID = UUID
			if(responseUUID != "fail"){
				//console.log("인증코드:"+ responseUUID);
				$(".code-msg0").css({"color":"blue", "font-size":"13px"});     		
				$(".code-msg0").text("이메일 전송 완료!!");      		
				// 인증코드 이메일이 보내지고나서 타이머 시작
				$(".input-code").attr("readonly", false);
				$("#confirmEmail").css({"visibility":"visible", "height":"auto"})
				$(".code-msg").css({"display": "block", "color" :"green"});	
				$(".code-msg").text("인증코드가 발송되었습니다!!");
				timer_start();
				
			} else {
				alert("이메일을 다시 확인하세요!! 처음부터 진행하세요.");
				$(".code-msg0").css({"color":"red", "font-size":"13px"});
				$(".code-msg0").text("이메일 전송 에러 1번!! 처음부터 진행하세요.");
				$("#email").select();
			}
		},
		error : function(){
			alert("메일발송 실패!! 처음부터 진행하세요.");
			$(".code-msg0").css({"color":"red", "font-size":"13px"});
			$(".code-msg0").text("2.이메일 전송 에러 2번!! 처음부터 진행하세요.");
			$("#email").focus(); 
		}
	})
}

// 이메일 인증코드 일치여부 확인
function emailConfirm(){
	let confirmUUID = $("#confirmUUID").val();
	
	if(confirmUUID == null || confirmUUID.trim() == ""){
		alert("이메일 인증코드를 입력하세요");
		$(".code-msg").css({"display": "block", "color" :"red"});
		$(".code-msg").text("이메일 인증코드를 입력하세요");
		$("#confirmUUID").focus(); 
		isEmailCheck = false;	
		return;
	} else if(responseUUID == confirmUUID){ 
		alert("이메일 인증 성공!!");
		timer_stop();
		$("#confirm-btn").addClass("disabled");
		$("#code-send").addClass("disabled");
		time_display.val("인증완료");
		$(".code-msg").css({"display": "block", "color" :"green"});
		$(".code-msg").text("이메일 인증이 완료되었습니다.");
		$(".input-code").attr("readonly", true);
		
		isEmailCheck = true;	
		return;
	} else {	// 인증코드를 잘못 입력
		alert("이메일 인증코드를 다시 확인하세요!!");
		$(".code-msg").css({"display": "block", "color" :"red"});
		$(".code-msg").text("이메일 인증코드를 다시 확인하세요!!");
		$("#confirmUUID").focus(); 
		isEmailCheck = false;	
		return;
	}
}

// 가입버튼 누를시 onSubmit 진행
function submitCheck(){
	let isIdCheck = $("#isIdCheck").val();
	let isPwCheck = $("#isPwCheck").val();
	let isNameCheck = $("#isNameCheck").val();
	let isBirthCheck = $("#isBirthCheck").val();
	let isTelCheck = $("#isTelCheck").val();

	if(isIdCheck == "no" || isPwCheck == "no"){
		alert("아이디 중복체크 또는 비밀번호를 확인해주세요!!")
		$("#id").focus();
		return false;
	}
	
	if(isNameCheck == "no"){
		alert("이름을 정확히 입력해주세요!!");
		$("#name").focus();
		return false;
	}
	
	if(isBirthCheck == "no"){
		alert("생년월일을 정확히 입력해주세요!!");
		$("#birth").focus();
		return false;
	}
	
	if(isTelCheck == "no"){
		alert("전화번호를 정확히 입력해주세요!!")
		$("#tel").select();
		return false;
	}
	
	if(!isEmailCheck){
		alert("이메일 인증을 해주세요!!");
		$("#email").select();
		return false;
	}
	
	alert("회원가입 완료~ 로그인을 진행해주세요!!");
	return true;
}