<%@ page import="com.team.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../include/header.jsp"%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 주문 완료 메시지 알림 -->
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<style>
.orderInfo li {
    display: inline; /* Aligns list items in a row */
    margin-right: 30px; /* Adds space between list items */
}

/* .orderList{
	 background:#eaf4ea;
} */

.table {
	font-size: 14px;
}

</style>

<div class="container w-75 p-5">
	<div class="orderInfo">
		<ul>
			<li><a href='<c:url value="myProfile.do"/>'><b>내 정보</b></a></li>
			<li><a href='<c:url value="myOrderInfo.do"/>'><b>주문 정보</b></a></li>
			<li><a href='<c:url value="reservationInfo.do"/>'><b>예약 정보</b></a></li>
			<li><a href='<c:url value="myDonationInfo.do"/>'><b>포인트</b></a></li>
			<li><a href='<c:url value="myQuestion.do"/>'><b>문의하기</b></a></li>
		</ul>
	</div><hr>
	
	<div class="orderList container w-75 p-5">
		<h3 class="text-center mb-3" style="color : #30622f;"><i class="fa-solid fa-list-check"></i> 주문 정보</h3>
		<div>
			<table class="table">
				<thead class="table" style="color:#00a600;">
					<tr>
						<th>주문번호</th>
						<th>주문일</th>
						<th>주문상품</th>				
						<th>결제금액</th>
					</tr>			
				</thead>
				<tbody>
					<c:if test="${list.size() == 0}">
						<tr>
							<td colspan="6">구매 내역이 없습니다!!</td>
						</tr>
					</c:if>
					<c:if test="${list.size() != 0}">
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.order_num}</td>
								<td><fmt:formatDate value="${dto.order_date}" pattern="yyyy-MM-dd HH:MM"/></td>
								<td><a href="myOrderDetail.do?order_num=${dto.order_num}">주문상세보기</a></td> 
								<td><fmt:formatNumber value="${dto.total_amount}" type="currency"/></td>								
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>	
	</div>
</div>
<%@ include file="../include/footer.jsp"%>