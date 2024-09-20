<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<style>
.myQuestion li {
    display: inline; /* Aligns list items in a row */
    margin-right: 30px; /* Adds space between list items */
    margin-bottom: 0;
}

.readonly {
	background: #eee;
}
</style>


<div class="container w-75 p-5">
	<div class="myQuestion">
		<ul>
			<%-- <li><a href='<c:url value="myProfile.do?id=${sessionScope.loginDTO.id}"/>'><b>내 정보</b></a></li> --%>
			<%-- <li><a href='<c:url value="reservationInfo.do?rid_fk=${sessionScope.loginDTO.id}"/>'><b>예약 정보</b></a></li> --%>
			<%-- <li><a href='<c:url value="myQuestion.do?mid_fk=${sessionScope.loginDTO.id}"/>'><b>문의하기</b></a></li> --%>
			<li><a href='<c:url value="myProfile.do"/>'><b>내 정보</b></a></li>
			<li><a href='<c:url value="myOrderInfo.do"/>'><b>주문 정보</b></a></li>
			<li><a href='<c:url value="reservationInfo.do"/>'><b>예약 정보</b></a></li>
			<li><a href='<c:url value="myDonationInfo.do"/>'><b>포인트</b></a></li>
			<li><a href='<c:url value="myQuestion.do"/>'><b>문의하기</b></a></li>
		</ul>
	</div><hr>
	
	<div class="container w-75 p-5">
		<div class="mb-5">
			<button id="question-ckeck" class="btn" style="background:#00a600;">내 문의내역 확인</button>
		</div>
		<form action="myQuestion.do" method="post" >
			<h4>1:1 문의하기</h4>
			<input type="text" class="form-control" 
				id="subject" name="subject" placeholder="글제목" autofocus />
				
			<textarea class="form-control mt-2" rows="7" cols="50" name="contents" id="contents"
				 placeholder="글내용"></textarea>
				 
			<input type="text" class="form-control mt-2 readonly" 
				id="writer" name="writer" value="${sessionScope.loginDTO.name}" style="width: 150px;"readonly/>	
						
			<input type="text" class="form-control mt-2 readonly" 
				id="id" name="mid_fk" value="${sessionScope.loginDTO.id}" style="width: 150px;" readonly/>		
					
			<div class="text-cener mt-3">
				<button class="btn btn-primary">문의하기</button>			
			</div>		
		</form>
	</div>
</div>

<script type="text/javascript">			
	$("#question-ckeck").click(()=>{
		location.href='<c:url value="myQuestionList.do?mid_fk=${sessionScope.loginDTO.id}"/>';		
	});
</script>

<%@ include file="../include/footer.jsp" %>