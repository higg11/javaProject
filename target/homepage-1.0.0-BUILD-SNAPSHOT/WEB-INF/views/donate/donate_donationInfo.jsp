<%-- <%@ page import="com.mbc.domain.ReservationDTO"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->

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

.fa-caret-down{color: crimson;}

.fa-caret-up{color: blue;}

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
		<h3 class="text-center mb-3" style="color : #30622f;"><i class="fa-solid fa-list-check"></i> 포인트 내역</h3>
		<div class="m-2">
			보유포인트 : <b><span id="myPoint"></span></b>
		</div>
		<div>
			<table class="table">
				<thead class="table" style="color:#00a600;">
					<tr>
						<th>아이디</th>
						<th>기부날짜</th>
						<th>항목</th>
						<th>기부금액</th>			
					</tr>			
				</thead>
				<tbody>
					<c:if test="${list.size() == 0}">
						<tr>
							<td colspan="6">포인트 내역이 없습니다!!</td>
						</tr>
					</c:if>
					<c:if test="${list.size() != 0}">						
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.id}</td>
								<td><fmt:formatDate value="${dto.date}" pattern="yyyy-MM-dd HH:MM"/></td>
								<td>${dto.pointType}</td>
								<td>
									<c:choose>
						                <c:when test="${dto.pointType.getValue() == '기부'}">
						                    <i class="fa-solid fa-caret-down"></i> <fmt:formatNumber value="${dto.point}" />
						                </c:when>
						                <c:when test="${dto.pointType.getValue() == '포인트사용'}">
						                    <i class="fa-solid fa-caret-down"></i> <fmt:formatNumber value="${dto.point}" />
						                </c:when>
						                <c:when test="${dto.pointType.getValue() == '리사이클'}">
						                    <i class="fa-solid fa-caret-up"></i> <fmt:formatNumber value="${dto.point}" />
						                </c:when>
						                 <c:when test="${dto.pointType.getValue() == '포인트적립'}">
						                    <i class="fa-solid fa-caret-up"></i> <fmt:formatNumber value="${dto.point}" />
						                </c:when>
						            </c:choose>
								</td>								
							</tr>	
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>	
	</div>
</div>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    // 보유포인트
    $.ajax({
        url: "myPointAmount.do",
        type: "GET",
        success: function(data){
            $("#myPoint").text(data + " points");
        },
        error: function(xhr, status, error){
            console.error("AJAX 요청 에러:", error);
        }
    });
});


</script>
<%@ include file="../include/footer.jsp"%>