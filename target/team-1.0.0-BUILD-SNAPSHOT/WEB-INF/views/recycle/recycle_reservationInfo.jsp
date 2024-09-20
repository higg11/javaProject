<%@ page import="com.team.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 예약 완료 메시지 알림 -->
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<style>
.myreservationInfo li {
    display: inline; /* Aligns list items in a row */
    margin-right: 30px; /* Adds space between list items */
    margin-bottom: 0;
}

.table {
	font-size: 14px;
}

</style>

<div class="container w-75 p-5">
	<div class="myreservationInfo">
		<ul>
			<li><a href='<c:url value="myProfile.do"/>'><b>내 정보</b></a></li>
			<li><a href='<c:url value="myOrderInfo.do"/>'><b>주문 정보</b></a></li>
			<li><a href='<c:url value="reservationInfo.do"/>'><b>예약 정보</b></a></li>
			<li><a href='<c:url value="myDonationInfo.do"/>'><b>포인트</b></a></li>
			<li><a href='<c:url value="myQuestion.do"/>'><b>문의하기</b></a></li>
		</ul>
	</div><hr>
	
	<div class="reservationList container w-75 p-5">
		<h3 class="text-center mb-3" style="color : #30622f;"><i class="fa-solid fa-list-check"></i> 예약 정보</h3>
		<div>
			<table class="table">
				<thead class="table" style="color:#00a600;">
					<tr>
						<th>아이디</th>
						<th>예약날짜</th>
						<th>예약시간</th>
						<th>요청사항</th>
						<th>예약상태</th>					
					</tr>			
				</thead>
				<tbody>
					<c:if test="${list.size() == 0}">
						<tr>
							<td colspan="6">예약 내역이 없습니다!!</td>
						</tr>
					</c:if>
					<c:if test="${list.size() != 0}">
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.rid_fk}</td>
								<td>${dto.date}</td>
								<td>${dto.time}</td>
								<td>${dto.contents}</td>
								<td>
					            	<c:choose>
								        <c:when test="${dto.reservationStatus.getValue() == '예약확정'}">
								            <span style="color: blue;">${dto.reservationStatus.getValue()}</span>
								        </c:when>
								        <c:when test="${dto.reservationStatus.getValue() == '예약대기'}">
								            <span style="color: red;">${dto.reservationStatus.getValue()}</span></a>
								        </c:when>
								        <c:otherwise>
								            <span>${dto.reservationStatus.getValue()}</span>
								        </c:otherwise>
								    </c:choose>
					            </td>            
								<%-- <td>${dto.reservationStatus.getValue()}</td> --%>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>	
	</div>
</div>
<%@ include file="../include/footer.jsp"%>