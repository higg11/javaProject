<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

</div>
</main>
<!-- footer -->
<footer class="border-top mt-5">
	<nav class="footer_navbar">		
		<ul class="footer_navbar-menu">
			<li><a href="<c:url value="#"/>">회사소개</a><li>
			<li><a href="<c:url value="#"/>">|</a></li> 
			<li><a href="<c:url value="#"/>">이용약관</a></li>
			<li><a href="<c:url value="#"/>">|</a></li> 
			<li><a href="<c:url value="#"/>">개인정보 처리방침</a></li>
			<li><a href="<c:url value="#"/>">|</a></li> 
			<li><a href="<c:url value="#"/>">공지사항</a></li>	<li><a href="<c:url value="#"/>">|</a></li> 
			<li><a href="<c:url value="adminLogin.do"/>">관리자센터</a></li>						
		</ul>
		<ul class="navbar-info">			
			<li><input class="question_btn" type="button" value="1:1 문의하기" onclick="question()"></li>
			<li>평일운영시간</li>
		</ul>
	</nav>
	<hr>
	<nav class="footer_navbar">		
		<ul class="navbar-logo">
			<li><img src=""></li>
		</ul>
		<ul>		
			<li class="footer_navbar-info"><a href="<c:url value="#"/>">회사명 : (주)서울문고</a>&nbsp;&nbsp;
			<a href="<c:url value="#"/>">대표이사 : 김홍구</a>&nbsp;&nbsp;
			<a href="<c:url value="#"/>">개인정보 보호책임자 : 김홍구</a>&nbsp;&nbsp;
			<a href="<c:url value="#"/>">E-mail : bandi_cs@bnl.co.kr</a></li>							
				
			<li class="footer_navbar-info"><a href="<c:url value="#"/>">소재지 : (06168)서울 강남구 삼성로 96길 6</a>&nbsp;&nbsp;
			<a href="<c:url value="#"/>">사업자 등록번호 : 010-81-02543</a>&nbsp;&nbsp;
			<a href="<c:url value="#"/>">통신판매업 신고번호 : 제2023-서울강남-03728호</a></li>						
			
			<li class="footer_navbar-info"><a href="<c:url value="#"/>">물류센터 : (10881) 경기도 파주시 문발로 77 반디앤루니스</a><li>						
			
			<li class="footer_navbar-info"><a href="<c:url value="#"/>">copyright (c) 2016 BANDI&LUNI'S ALL Rights Reserved</a><li>						
		</ul>		
	</nav>
	
	<!-- <div class="d-flex">
		<div class="p-5">
			<img src="resources/imgs/footer_logo.png">
		</div>
		<div class="container ms-5 p-5">
			<span class="d-flex" style="font-size: 11px">
				<p>회사명 : (주)서울문고</p>
				<p>대표이사 : 김홍구</p>
				<p>개인정보 보호책임자 : 김홍구</p>
				<p>E-mail : bandi_cs@bnl.co.kr</p>
			</span> <span class="d-flex" style="font-size: 11px">
				<p>소재지 : (06168)서울 강남구 삼성로 96길 6</p>
				<p>사업자 등록번호 : 010-81-02543</p>
				<p>통신판매업 신고번호 : 제2023-서울강남-03728호</p>
			</span> <span style="font-size: 11px">
				<p>물류센터 : (10881) 경기도 파주시 문발로 77 반디앤루니스</p>
			</span> <span style="font-size: 11px">
				<p>copyright (c) 2016 BANDI&LUNI'S ALL Rights Reserved</p>
			</span>
		</div>
	</div> -->
</footer>
	<script type="text/javascript">
		function question() {
						
				location.href = "<c:url value='myQuestion.do'/>";
		
		}		
		
		
	</script>
</body>
</html>