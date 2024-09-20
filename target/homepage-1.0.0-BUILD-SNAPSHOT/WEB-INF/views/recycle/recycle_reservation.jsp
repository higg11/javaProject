<%@ page import="com.team.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
/* Overall background and border for the calendar */
.ui-datepicker {
    background-color: #e6ffe6; /* Light green background */
    border: 1px solid #4caf50; /* Dark green border */
}

/* Header (month and year) background and text color */
.ui-datepicker-header {
    background-color: #4caf50; /* Dark green background */
    color: white; /* White text */
}

/* Days of the week */
.ui-datepicker .ui-datepicker-calendar th {
    background-color: #66bb6a; /* Lighter green background for day headers */
    color: white;
}

/* Days */
.ui-state-default {
    background-color: #a5d6a7; /* Light green for days */
    color: #2e7d32; /* Dark green text */
}

/* Hover and focus state for days */
.ui-state-hover, .ui-state-focus {
    background-color: #81c784 !important; /* Slightly darker green on hover */
    color: white !important;
}

/* Selected day */
.ui-state-active {
    background-color: #388e3c !important; /* Dark green for selected day */
    color: white !important;
}

.btn-reservation{
	background: #00a600;
	color: white;
}

.time-select{
	font-size: 14px;
	text-align: center;
}

</style>

<div class="container w-50 mt-5 p-5">
	
	<form action="reservation.do" method="post">
		<h3 class="text-center">픽업 서비스 예약하기</h3>
		<div class="mt-3">
			<p class="m-0" for="rid">아이디</p> 
			<input type="text" class="form-control" id="id" name="rid_fk" value="${sessionScope.loginDTO.id}" />
		</div>
		<div class="mt-3">
			<p class="m-0" for="date">예약날짜</p> 
			<input type="text" id="datepicker" name="date" style="width: 150px;" placeholder="예약일 선택" />
		</div>

		<div class="mt-3">
			<p class="m-0" for="time">예약시간</p>
			<table>
				<tr>
					<td><input type="text" class="form-control time-select"
						id="time1" value="10:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time2" value="11:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time3" value="12:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time4" value="13:00" readonly /></td>
				</tr>
				<tr>
					<td><input type="text" class="form-control time-select"
						id="time5" value="14:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time6" value="15:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time7" value="16:00" readonly /></td>
					<td><input type="text" class="form-control time-select"
						id="time8" value="17:00" readonly /></td>
				</tr>
			</table>
			
		</div>
		
		<div class="mt-3">	
			<!-- 선택된 시간이 여기에 표시됩니다. -->
			<p class="m-0" for="time">선택 시간</p>
			<input type="text" class="form-control" id="selectedTime" name="time" style="width:300px;"/>				
		</div>
		
		<div class="mt-3">
			<p class="m-0" for="amount">수거 공병수 (*최소 5개 이상)</p>	
			<div class="d-flex">
				<input type="button" value=" - " onclick="del();">
				<input type="text" class="form-control" id="item-amount" name="amount" value="5" style="width:50px; text-align:center;">
				<input type="button" value=" + " onclick="add();">
			</div>			
		</div>

		<div class="mt-3">
			<p class="m-0" for="contents">요청사항</p>
			<textarea rows="5" cols="60" name="contents"
				placeholder="추가 요청사항을 입력하세요"></textarea>
		</div>

		<div class="text-center mt-3">
			<button type="submit" class="btn-reservation btn btn-sm btn-info"
				onclick="handleSubmit()">예약하기</button>
		</div>
		
	</form>
</div>

<script>

function add() {
    // #를 제거하여 ID에 접근하고, value 값을 숫자로 변환
    let amount = document.getElementById("item-amount").value;
    amount = parseInt(amount) + 1;
    document.getElementById("item-amount").value = amount;
}

function del() {
	 let amount = document.getElementById("item-amount").value;
	    if (amount > 5) { 
	        amount = parseInt(amount) - 1;
	        document.getElementById("item-amount").value = amount;
	    } else if (amount == 5) { // amount가 5일 때 경고 메시지 출력
	        alert("최소 5개 이상 선택해주세요!!!");
	    }
}

function toggleList() {
    let $reservationList = $("#reservationList");
    
    if ($reservationList.is(':visible')) {
        $reservationList.hide(); // Hide the list if it's visible
    } else {
        showList(); // Fetch and show the list if it's hidden
    }
}

function showList() {
    $.ajax({
        url: "<c:url value='reservationInfo.do'/>",  // 요청주소 (URL for the request)
        type: "get",  // 전송방식 (Request method)
        dataType: "json",  // 서버에서 응답하는 데이터 형식 (Response data format)
        success: function(data) {
            let html = "<table class='table'>";
            html += "   <thead class='table-dark'>";
            html += "     <tr>";
            html += "       <th>아이디</th>";  
            html += "       <th>예약날짜</th>";  
            html += "       <th>예약시간</th>";    
            html += "       <th>에약내용</th>";  
            html += "     </tr>";
            html += "   </thead>";
            html += "   <tbody>";

            $.each(data, function(index, obj) {
                html += "<tr>";
                html += "<td>" + obj.rid + "</td>";
                html += "<td>" + obj.date + "</td>";
                html += "<td>" + obj.time + "</td>";
                html += "<td>" + obj.contents + "</td>";
                html += "</tr>";
            });

            html += "</tbody>";
            html += "</table>";

            $("#reservationList").html(html).show();  
        },
        error: function() {
            alert("에러");  
        }
    });
}


   $(function() {
      //input을 datepicker로 선언
      $("#datepicker").datepicker({
         dateFormat : 'yy-mm-dd' //달력 날짜 형태
         ,
         showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
         ,
         showMonthAfterYear : true // 월- 년 순서가아닌 년도 - 월 순서
         ,
         changeYear : true //option값 년 선택 가능
         ,
         changeMonth : true //option값  월 선택 가능                
         ,
         showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
         ,
         buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
         ,
         buttonImageOnly : true //버튼 이미지만 깔끔하게 보이게함
         ,
         buttonText : "선택" //버튼 호버 텍스트              
         ,
         yearSuffix : "년" //달력의 년도 부분 뒤 텍스트
         ,
         monthNamesShort : [ '1월', '2월', '3월', '4월', '5월',
               '6월', '7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 텍스트
         ,
         monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
               '7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip
         ,
         dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 텍스트
         ,
         dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
               '금요일', '토요일' ] //달력의 요일 Tooltip
         ,
         minDate : "+1d" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
         ,
         maxDate : "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
      });

      //초기값을 오늘 날짜로 설정해줘야 합니다.
      $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
   });


   <!-- 선택 예약시간 표시 -->
   $(document).ready(function() {
       // Add event listeners to all time-select inputs
       document.querySelectorAll('.time-select').forEach(function(element) {
           element.addEventListener('click', function() {
               // 클릭된 요소의 값을 selectedTime 입력 필드에 설정
               document.getElementById('selectedTime').value = this.value;

               // 선택된 시간을 강조하기 위해 모든 .time-select 요소의 배경색을 초기화
               document.querySelectorAll('.time-select').forEach(function(el) {
                   el.style.backgroundColor = ""; // 모든 요소의 배경색 초기화
               });
               // 클릭된 요소의 배경색을 변경하여 강조 표시
               this.style.backgroundColor = "#d0e6ff";
           });
       });
              
       // Datepicker가 변경될 때마다 예약된 시간을 확인하는 함수
       function checkReservedTimes(date) {
          
           var timeInputs = document.querySelectorAll('.time-select');  // 모든 `.time-select` 요소를 가져옴
           
           $.ajax({
               url: "<c:url value='/reservationTimeCheck.do?date='/>" + date,  // 서버에 보낼 URL을 생성
               type: "GET",  // GET 요청
               success: function(data) {  // 서버 응답이 성공적일 경우 실행
                   // 모든 시간 입력 필드를 초기화 (활성화)
                   timeInputs.forEach(function(timeInput) {
                       timeInput.classList.remove('disabled');  // 비활성화 클래스 제거
                       timeInput.style.color = '';  // 예약마감 텍스트 붉은색 제거
                       timeInput.style.textDecoration = '';   // 줄 그음 제거
                       timeInput.disabled = false;  // 비활성화 해제
                   });

                   // 응답 데이터(예약된 시간 목록)를 확인하고 해당 시간을 비활성화
                   data.forEach(function(reservedTime) {
                       timeInputs.forEach(function(timeInput) {
                           if (reservedTime === timeInput.value) {  // 예약된 시간과 일치하는 경우
                        	   timeInput.style.textDecoration = 'line-through'; // 시간에 줄 그음 추가
                        	   timeInput.style.color = 'crimson';   // 예약마감 텍스트를 붉은색으로
                               timeInput.classList.add('disabled');  // 비활성화 시각적 처리
                               timeInput.disabled = true;  // 실제로 입력 필드를 비활성화
                           }
                       });
                   });
               },
               error: function() {
                   alert("에러 발생!!");  // 에러 발생 시 경고창 표시
               }
           });
       }

       // Datepicker의 변경 이벤트를 처리
       $("#datepicker").on("change", function() {
           var date = $(this).val();  // `#datepicker`에서 선택한 날짜의 값을 가져옴
           checkReservedTimes(date);  // 선택된 날짜에 대해 예약된 시간을 확인
       });

       // 페이지 로드 시 기본 날짜에 대해 예약된 시간을 확인 (예: 오늘 날짜)
       var initialDate = $("#datepicker").val();
       if (initialDate) {
           checkReservedTimes(initialDate);
       }
 
   }); 

   
</script>


<%@ include file="../include/footer.jsp"%>