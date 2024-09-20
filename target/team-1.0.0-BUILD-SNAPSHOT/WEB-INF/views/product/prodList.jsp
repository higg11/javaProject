<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp" %>	
<!-- u_left에서 카테고리 클릭시 뜨는화면 -->

<div class="w-100 mt-5">
	<div class="d-flex mb-5">
		<h3>전체 상품</h3><br>
	    <!-- 검색 -->
	   <form action="prodSearch.do" id="searchForm" method="post">
			<div class="d-flex ms-5">
				<!-- 게시글 개수를 먼저 선택하고 검색할 경우 선택된 게시글 수 넘겨줌 -->
				<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
				<select class="form-select form-select-sm me-2" style="width:100px" 
							name="searchType">
					<option value="">선택</option>
					<option value="S" ${pDto.searchType == 'S' ? 'selected': ''}>상품명</option>
					<option value="C" ${pDto.searchType == 'C' ? 'selected': ''}>카테고리</option>
					<option value="W" ${pDto.searchType == 'W' ? 'selected': ''}>제조사</option>
					<%-- <option value="SC" ${pDto.searchType == 'SC' ? 'selected': ''}>상품명 + 제조사</option>
					<option value="SW" ${pDto.searchType == 'SW' ? 'selected': ''}>제목 + 글쓴이</option>
					<option value="SCW" ${pDto.searchType == 'SCW' ? 'selected': ''}>제목 + 내용 + 글쓴이</option> --%>
				</select>
				<input type="text" id="keyword" name="keyword" placeholder="검색어입력"
					class="form-control rounded-0 rounded-start" style="width:300px"
					value="${pDto.keyword}">
				<button class="btn rounded-0 rounded-end" style="background:#1384aa; color:white"><i class="fa fa-search"></i></button>
			</div>
		</form>
	</div>
	<c:if test="${list.size() == 0}">
		<p>${cat_name} 상품이 존재하지 않습니다!!</p>
	</c:if>
	<c:if test="${list.size() != 0}">
		<div class="d-flex">
			<c:set var="cnt" value="0"/>	<!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 -->
			<c:forEach var="pDto" items="${list}">		
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