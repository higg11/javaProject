<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp" %>	
<!-- u_left에서 카테고리 인기, 신규, 추천상품 클릭시~~~ 뜨는화면 -->

<div class="w-100 mt-5">
	<h3>[${pSpec}] ${pSpecName} </h3><br>
	<c:if test="${sList.size() == 0 }">
		<br>[${pSpec}] ${pSpecName} 상품이 없습니다!!<br>
	</c:if>
	<c:if test="${sList.size() != 0}">
		<div class="d-flex">
			<c:set var="cnt" value="0"/>	<!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 -->
			<c:forEach var="pDto" items="${sList}">		
				<c:set var="cnt" value="${cnt+1}"/>	<!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 +1 -->
				<!-- Card -->
					<%@include file="card.jsp" %>
				<!-- Card End -->
				<c:if test="${cnt%5==0}">
					</div>
					<div class="d-flex mt-3"> <!-- div테그 종료/재시작, 4배수 일 경우 줄내리고 다음포문 새로시작 -->
				</c:if>
			</c:forEach>
		</div>
	</c:if>
</div>

<%@ include file="../include/footer.jsp" %>