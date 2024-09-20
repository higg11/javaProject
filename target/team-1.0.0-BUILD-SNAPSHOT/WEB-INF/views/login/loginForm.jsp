<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
.input-container {
	position: relative;
}

.input-container i {
	position: absolute;
	left: 470px;
	top: 10px;
}



</style>
<div class="container w-50 mt-5 p-5 shadow rounded"
	style="height: 400px">
	<form action="<c:url value="login.do"/>" method="post">
		<input type="hidden" name="moveUrl" value="${moveUrl}" size="80" />
		<h3 class="text-center mb-4">로그인</h3>
		<input class="form-control mb-3" type="text" id="id" name="id" placeholder="아이디" autofocus /> 
		<div class="input-container">
			<i class="fa-solid fa-eye" id="togglePassword" style="cursor: pointer;"></i>
			<input class="form-control password mb-2" type="password" id="pw" name="pw" placeholder="비밀번호" />
				<c:if test="${requestScope.loginErr == 'idErr' || requestScope.loginErr == 'pwdErr'}">
					<p class="text-danger text-center mt-3 mb-0" style="font-size: 15px">아이디
						또는 비밀번호 불일치!!</p>
				</c:if>
		</div>	
		<div class="text-center pt-4">
			<input type="submit" class="btn btn-primary w-100" value="로그인" />
		</div>


	</form>

	<div class="mt-3 w-100 findIdPw">
		<div class="d-flex justify-content-between">
			<div>
				<i class="fa fa-lock"></i> <a
					href="<c:url value="idPwFind.do?find=id"/>"> 아이디</a> <a
					href="<c:url value="idPwFind.do?find=pw"/>"> 비밀번호 찾기</a>
			</div>
			<div>
				<i class="fa fa-user-plus"></i><a href="memberRegister.do"> 회원가입</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

 $(document).ready(function() {
            $('#togglePassword').on('click', function() {
                const passwordField = $('#pw');
                const type = passwordField.attr('type') === 'password' ? 'text' : 'password';
                passwordField.attr('type', type);

                // 아이콘 변경
                $(this).toggleClass('fa-eye fa-eye-slash');
            });
        });

 </script>
 
<%@ include file="../include/footer.jsp"%>