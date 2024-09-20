<%@page import="com.team.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ include file="../include/header.jsp" %> 

<style>
.pwChange li {
    display: inline; /* Aligns list items in a row */
    margin-right: 20px; /* Adds space between list items */
}
</style>

<div class="container w-75 p-5">
	<div class="pwChange">
		<ul>
			<li><a href='<c:url value="myProfile.do"/>'><b>내 정보</b></a></li>
			<li><a href='<c:url value="myOrderInfo.do"/>'><b>주문 정보</b></a></li>
			<li><a href='<c:url value="reservationInfo.do"/>'><b>예약 정보</b></a></li>
			<li><a href='<c:url value="myDonationInfo.do"/>'><b>포인트</b></a></li>
			<li><a href='<c:url value="myQuestion.do"/>'><b>문의하기</b></a></li>
		</ul>
	</div><hr>
	
	<div class="container w-75 p-5">
	   <h4>비밀번호 변경</h4>
	   <input type="hidden" id="memberId" value="${sessionScope.loginDTO.id}"/>
	   <input type="hidden" value="${sessionScope.loginDTO.pw}"/>
	   
	   <p id="pwChkMsg" style="color:red; font-size:12px;"></p>
	   <input class="form-control mb-2" type="password" id="pw" name="pw" placeholder="현재비밀번호" onblur="pwBlurCheck()">
	   <input class="form-control mb-2" type="password" id="newPw" name="newPw" placeholder="새비밀번호" onkeyup="npwCheck()">
	   <input class="form-control mb-2" type="password" id="confirmPw" name="confirmPw" placeholder="새비밀번호 확인">
	   
	   <div class="text-center">
	      <button id="pwChangeBtn" class="btn btn-sm btn-success">비밀번호 변경</button>
	   </div>
	</div>  
</div>  

<script type="text/javascript">
/////////////////// 현재 비밀번호 체크 /////////////////////
let current_pw = "";
let cur_pw_chk="";

function pwBlurCheck(){
   current_pw = $("#pw").val();
   console.log("current_pw : " + current_pw);
   
   $.ajax({
      url:"pwCheck.do",
      type: "post",
      data: {"pw":current_pw},
      async:false, // 기본값 true, 동기화처리 설정
      success:function(result){
         if(result == "ok"){
            /* alert("현재 비밀번호 확인 완료!!"); */
            $("#pwChkMsg").text("비밀번호 일치 확인!!").css("color", "blue");
            cur_pw_chk=true;
         } else if (result == "sessionError") {
             alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
             cur_pw_chk = false;
         }else{
            alert("현재 비밀번호 다시 확인 요망!!");
            cur_pw_chk=false;
         }
      },
      error:function(){alert("현재 비밀번호 체크 요청 실패!!")}
   });
}

let npw = "";
let cpw = "";
let npw_chk = "";
let cpw_chk = "";
let pwText = "";
////////////////// 새비밀번호 유효성 검사(실시간 유효성 검사) ///////////////////
/* $("#newPw").on("keyup", function(){ */
function npwCheck(){
   npw = $("#newPw").val();
   cpw = $("#confirmPw").val();
   pwText = /^(?=.*[a-z])(?=.*[!@#$%^&*?])[a-z\d!@#$%^&*?]{9,}$/;

   // 현재 비밀번호 확인 여부 체크
   if(cur_pw_chk == false){
	   $("#pwChkMsg").text("우선 현재 비밀번호를 입력 후 일치여부를 확인하세요!!").css("color", "red");
	   $("#newPw").val(""); // 새 비밀번호 입력란 지우기
	   npw_chk = false;
	   return;
   }

   // 새 비밀번호가 빈 문자열인 경우
   if(npw == ""){
      $("#pwChkMsg").text("새 비밀번호를 입력하세요!!").css("color", "red");
      npw_chk = false;
      return;
   }

   // 비밀번호 길이가 9자리 미만인 경우
   if(npw.length < 9){
      $("#pwChkMsg").text("9자리 이상 입력하세요!!").css("color", "red");
      npw_chk = false;
      return;
   }

   // 비밀번호 형식이 맞지 않는 경우
    if(!pwText.test(npw)){
      $("#pwChkMsg").text("비밀번호는 반드시 소문자, 숫자, 특수키가 하나 이상 조합되어야 합니다!!").css("color", "red");
     /*  console.log("npw:", npw);
      console.log("pwText.test(npw):", pwText.test(npw)); */
      npw_chk = false;
      return;
   }

   // 모든 조건을 만족하는 경우
   $("#pwChkMsg").text("사용 가능한 비밀번호입니다!!").css("color", "blue");
   npw_chk = true;

}


$("#confirmPw").on("keyup", function(){
   cpw = $("#confirmPw").val();
   npw = $("#newPw").val()
   if(cpw == ""){
      $("#pwChkMsg").text("새 비밀번호를 한번 더 입력하세요!!").css("color", "red");
      npw_chk = false;
      cpw_chk = false;
      return;
   }else if(npw !=cpw){
      $("#pwChkMsg").text("비밀번호가 일치하지 않습니다.!!").css("color", "red");
      cpw_chk = false;
      return;
   }else if(npw == cpw){
      $("#pwChkMsg").text("비밀번호가 일치합니다!!!").css("color", "blue");
      npw_chk = true;
      cpw_chk = true;
   }
});


$("#pwChangeBtn").on("click", function(){
 
   ///////// 비밀번호 변경 처리 //////////
   let id = $("#memberId").val();
   // member 객체(자바스크립트 객체)
   let member = {"id":id, "pw":current_pw, "npw":npw}
   
   if(!cur_pw_chk){
      alert("현재 비밀번호를 확인하세요!!");
   }else if(!npw_chk){
      alert("새 비밀번호를 확인하세요!!");      
   }else if(!cpw_chk){
      alert("새 비밀번호가 일치하지 않습니다.. 다시 확인하세요");
   }else if(cur_pw_chk && npw_chk && cpw_chk){      
      $.ajax({
         url:"pwChange.do",
         type:"post",
         // 자바스크립트 객체를 JSON으로 변환해야 네트워크 전송할 수 있음 --> JSON API
         data:JSON.stringify(member),
         contentType:"application/json; charset=utf8",
         success:function(result){
            if(result > 0){
               alert("비밀번호 변경 완료!! 새 비밀번호로 로그인 하세요!!");
               location.href="<c:url value='logout.do'/>"
            }
         },
         error:function(){alert("비밀번호 변경 요청 실패!!")}      
      });
   }
   
});

</script>                                   
                                                   
<%@ include file="../include/footer.jsp" %>










