<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<!-- js 불러오기 --> 
<script type="text/javascript" src="resources/js/valid.js" charset="utf-8"></script>

<div class="container w-50 mt-5 p-5 shadow">
   <form action="memberInsert.do" method="post" name="joinForm" onSubmit="return submitCheck()">
      <h4>회원가입</h4>
      
      <div class="mt-2 mb-2">
         <label for="id">아이디</label>
	       <input class="form-control mb-2" type="text" id="id" name="id" placeholder="아이디" onkeyup="idCheck()">
	     	 	<p id="chkMsg" class="mb-2"></p>
	       <input type="hidden" id="isIdCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
	  </div>
	  
      <div class="mb-2">
         <label for="pw">비밀번호</label>
      	 	<input class="form-control mb-2" type="password" id="pw" name="pw" placeholder="비밀번호" onkeyup="pwKeyupCheck()" onblur="pwBlurCheck()">
      	 	<p id="chkMsg2" class="mb-2"></p>
      </div>
      
      <div class="mb-2">
         <label for="pwConfirm">비밀번호 확인</label>
        	<input class="form-control mb-2" type="password" id="pwConfirm" name="pwConfirm" placeholder="비밀번호 확인" onkeyup="pwConfirmCheck()"/>
         	<p id="chkMsg3" class="mb-2"></p>
         	<input type="hidden" id="isPwCheck" value="no">
      </div>
      
      <div class="mb-2">
         <label for="name">이름</label>
      	 	<input class="form-control mb-2" type="text" id="name" name="name" placeholder="이름" onkeyup="nameCheck()" >
      	 	<p id="chkMsg4" class="mb-2"></p>
      	 	<input type="hidden" id="isNameCheck" value="no">
      </div>
      
      <div class="mb-2">
         <lable for="birth">생년월일</lable>
      		<input class="form-control mb-2" type="text" id="birth" name="birth" placeholder="생년월일 6자 입력(YYMMDD)" onkeyup="birthKeyupCheck()" onblur="birthBlurCheck()">
      		<p id="chkMsg5" class="mb-2"></p>
      	 	<input type="hidden" id="isBirthCheck" value="no">
      </div>
      
      <div class="mb-2">
         <label for="tel">전화번호</label>
      		<input class="form-control mb-2" type="text"id="tel" name="tel" placeholder="하이픈(-) 없이 휴대폰 번호를 입력" onblur="telCheck()">
      			<p id="chkMsg6" class="mb-2"></p>
	        <input type="hidden" id="isTelCheck" value="no"> 
      </div>
      
      <!-- 이메일 인증 -->
         <label for="email">이메일</label>
	      <div class="row">
	      	<div class="col-md-8 pe-0">
	      		<input class="form-control" type="text" id="email" name="email" placeholder="이메일">
	      	</div>
	      	<div class="col-md-4">
	      		<input id="code-send" class="btn btn-outline-secondary w-100" type="button" onclick="emailCheck()" value="인증번호 발송">
	      	</div>
	      		<p class="code-msg0 mt-1 mb-1"></p>
	      </div>
	      
	      <div class="row" id="confirmEmail"> 
		      	<div class="col-md-8 pe-0">
		      		<input class="input-code" type="text" id="confirmUUID" placeholder="인증코드 입력"><input class="time" value="" readonly>
		      	</div>
		        <div class="col-md-4">
		      		<span id="confirm-btn" class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span>
		      	</div>
		      		<p class="code-msg mt-1 mb-2"></p>
	      </div>
      
 		<!----------------------------------- 주소 ----------------------------------->

      	<div class="row mb-1">
      		<label for="addr">주소</label><br>
    		<div class="col-md-6">
    			<input class="form-control mb-1" type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호" readonly>
    		</div>
		    <div class="col-md-6">
				<input class="btn btn-secondary mb-1" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
			</div>
		</div>
		<input class="form-control mb-2" type="text" id="sample6_address" name="road_addr" placeholder="주소" readonly>
		<input class="form-control mb-2" type="text" id="sample6_detailAddress" name="detail_addr" placeholder="상세주소">
		<input class="form-control mb-2" type="text" id="sample6_extraAddress" name="plus_addr" placeholder="참고항목" readonly>
      
		<!-- 위에는 뷰 // 아래는 로직 -->
      	
	    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.  -->> 참고항목을 안넣으면 주석처리
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                	// -->> 참고항목을 안넣으면 주석처리
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
      <!----------------------------------------------------------------------------------------------->
      
      <div class="text-center mt-3"><br>
         <input type="submit" class="btn btn-primary" value="회원가입"> <!--  onclick="inputChk()" 대신 위에서 onSubmit="return submitChk()" 사용(같이 사용불가)-->
         <input type="reset" class="btn btn-warning" value="취소">
      </div>
   </form>
</div>


<%@ include file="../include/footer.jsp" %>