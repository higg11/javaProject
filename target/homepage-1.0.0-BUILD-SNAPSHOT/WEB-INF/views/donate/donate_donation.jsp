<%@page import="com.team.domain.PointDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<%

    // dDto 리스트를 가져온 후, 기부 포인트 총합을 계산
    List<PointDTO> dDto = (List<PointDTO>) request.getAttribute("dDto");
    int totPoints = 0;
    for (int i = 0; i < dDto.size(); i++) {
        totPoints += dDto.get(i).getPoint();
    }
    
    // 목표 포인트를 설정 (예: 1000포인트를 목표로 설정)
    int goalPoints = 100000;
    
    // 달성률을 계산
    int progressPercentage = (int) (((double) totPoints / goalPoints) * 100);
%>

<style>
.donationForm{
	text-align: center;
}

.btn-info{
	background: #00a600;
}

</style>

<div class="container donationForm w-50 mt-5">
	<img src="resources/imgs/spring.png">
	<h3 class="mb-5">오늘, 우리가 심은 작은 묘목은 <br/> 100년 후 울창한 숲이 됩니다.</h3>
	<p class="mb-5">여러분의 이름으로 전국 지자체에 나무를 심어드립니다.<br/>한 그루의 나무가 숲이 되어가는 과정을 함께 지켜봐 주세요.</p>
	
	<div class="p-5" style="background:#ffffdf;">
		<p class="mx-auto">달성률 : <%= progressPercentage %>%</p>
		<div class="progress mx-auto" style="width:300px;">
		    <div class="progress-bar bg-success progress-bar-striped" style="width:<%= progressPercentage %>%">
		        <%= progressPercentage %>%
		    </div>
		</div>
	</div>
	
	<form action="donation.do" method="post" class="d-flex flex-column align-items-center">

		<div class="mb-2">
			<label for="id"></label> 
				<input type="hidden" class="form-control" id="id" name="id" value="${dto.id}"/>
		</div>
		<div class="mb-2" style="width: 300px;">
			<label for="cur_point">보유 포인트</label> 
				<input type="text" class="form-control" id="cur_point" name="cur_point" value="${dto.point}" readonly />
		</div>
		<div class="mb-2" style="width: 300px;">
			<label for="point">기부 포인트</label> 
				<input type="number"class="form-control" id="point" name="point" placeholder="기부하실 포인트를 입력하세요" required />
		</div>
		<div class="text-center mt-3">
			<button type="submit" class="btn btn-sm btn-info">기부하기</button>
		</div>
	</form>
</div>

<%@ include file="../include/footer.jsp"%>