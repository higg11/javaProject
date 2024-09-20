<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<%@include file="../include/header.jsp" %>

<div class="container mt-5 ms-5 p-5">
	<h3><b>상품 검색 결과</b></h3>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>					
				<th>카테고리 코드</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>출판사</th>
				<th>작가</th>
				<th></th>
				<!-- <th>수량</th> -->
				<!-- <th>장바구니</th> -->
			</tr>
		</thead>
		<tbody>
			<c:if test="${list==null}">
				<tr>
					<td>상품이 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<c:if test="${list != null}">
				<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.pnum}</td>
					<td>${dto.pcategory_fk}</td>
					<td>
					<!-- c:url은 context path를 자동으로 붙여줌  -->
						<img src="<c:url value="/resources/fileRepo/${dto.pimage}"/>" width="60px"/>
					</td>
					<td>${dto.pname}</td>
					<td>${dto.price}</td>
					<td>${dto.pcompany}</td>
					<td>
						<!-- 로그인이 되어있을경우 -->
					    <c:if test="${sessionScope.loginDTO.id != null}">
				    		<a href="addCart.do?pnum_fk=${dto.pnum}&pqty=1&pspec=${dto.pspec}" 
				    		class="btn btn-primary">장바구니 담기</a>
					    </c:if>
					    <!-- 로그인이 안되어있을경우 -->
					    <c:if test="${sessionScope.loginDTO.id == null}">
					    	<a href="javascript:alert('로그인이 필요합니다')"
					    		 class="btn btn-primary">장바구니</a>
					    </c:if>
						<%-- <a href="prodUpdate.do?pnum=${dto.pnum}" class="btn btn-sm btn-info">장바구니</a> --%>
						<%-- <a href="javascript:prodDel('${dto.pnum}', '${dto.pimage}')" class="btn btn-sm btn-danger">돌아가기</a> --%>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table> 
</div>

<%@include file="../include/footer.jsp" %>







