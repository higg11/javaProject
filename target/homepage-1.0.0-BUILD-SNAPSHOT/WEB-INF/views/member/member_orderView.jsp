<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<%@include file="../include/header.jsp" %>

<div class="container mt-5 p-5 justify-content-center">
	<h3>상품 리스트</h3>
	<table class="table">
		<thead>
			<tr>
				<th>주문번호</th>					
				<th>카테고리명</th>
				<th>상품이미지</th>
				<th>상품명</th>
				<th>수량</th>
				<th>판매가</th>
				<th>합계</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list==null}">
				<tr>
					<td>상품이 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<c:if test="${list != null}">
				<c:set var="TotPrice" value="0"/>
				<c:set var="TotPoint" value="0"/>
				
				<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.order_num}</td>
					<td>${dto.cat_name}</td>
					<td>
					<!-- c:url은 context path를 자동으로 붙여줌  -->
						<img src="<c:url value="/resources/fileRepo/${dto.pimage}"/>" width="60px"/>
					</td>
					<td>${dto.pname}</td>
					<td>${dto.quantity}</td>
					<td>
						<fmt:formatNumber value="${dto.unitPrice}"/>원<br/>
						<fmt:formatNumber value="${dto.unitPoint}"/>포인트
					</td>
					<td>
						<fmt:formatNumber value="${dto.totalPrice}"/>원<br/>
						<fmt:formatNumber value="${dto.totalPoint}"/>포인트
					</td>
					
					<!-- 총액 합계 계산 -->
						<c:set var="TotPrice" value="${TotPrice + dto.totalPrice}"/>
						<c:set var="TotPoint" value="${TotPoint + dto.totalPoint}"/>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table><br/>
	<!-- 장바구니 총액표시 -->
	<div class="text-end">
		장바구니 합계 :  <fmt:formatNumber value="${TotPrice}"/> 원 <br>
		포인트 합계 : <fmt:formatNumber value="${TotPoint}"/> 포인트 <br>
	</div><br/> 
	<div class="text-end"> <!-- 텍스트 끝 정렬 -->
       <button id="goBack" class="btn btn-primary">돌아가기</button>
    </div>
</div>

<script>
	$("#goBack").click(()=>{
		location.href='<c:url value="myOrderInfo.do"/>';
	});
</script>

<%@include file="../include/footer.jsp" %>







