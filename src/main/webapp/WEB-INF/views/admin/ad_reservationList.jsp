
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>
 
<%
	LocalDate now = LocalDate.now();
%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약을 원하시는 날짜를 선택해 주세요</title>
<style>

    .reservation-list a {
        text-decoration: none;
        color: black;
    }
    
    /* Styling for reservation list */
	.reservation-list {
	    font-size: 10px;
	    display: flex;
	    justify-content: space-between; /* Space between the two columns */
	    margin-top: 1px;
	}
	
	.reservation-column {
	    width: 48%; /* Each column takes up about half of the container */
	}
	
	/* 예약대기인 날 배경색 오렌지색 */
	.reservation-item {
	    margin-bottom: 3px; /* Optional: Add space between items */
	    background-color: orange;
	    border-radius: 5px; /* Optional: Add rounded corners */
	    padding: 2px;
	    text-align: center;
	}
	
	.reservation-item:hover {
		background: yellow;
	}
	
	/* 예약확정된 날 배경색 하늘색 */
	.confirmed-reservation {
	    background-color: skyblue;
	    border-radius: 5px; /* Optional: Add rounded corners */
	    padding: 2px;
	    text-align: center;
	}
	
	/* 지난날 배경색 회색  */
	.past-date {
	    background-color: #e0e0e0; /* Light grey background for past dates */
	}
	
	.reservation-item.past-date {
	    background-color: #aaa; /* Light grey background for past dates */
	}
	
    /* Styling for the year and month header */
    #calendarTitleRow td {
        height: 50px;
        font-size: 24px;
        text-align: center;
    }

    /* Styling for the weekday row */
    .weekday-header td {
        height: 50px;
        text-align: center;
        vertical-align: middle;
    }

    /* Styling for the calendar cells (dates) */
    td.date-cell {
        width: 100px;
        height: 100px;
        text-align: center;
        vertical-align: top;
        cursor: pointer;
        border: 1px solid #ddd; /* Optional: Adds a border to distinguish cells */
        padding-top: 10px; /* Adds some space from the top */
        position: relative;
    }

    /* Styling for reservation detail popup */
    .popup {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 300px;
        padding: 20px;
        background: white;
        border: 1px solid #ddd;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        z-index: 1000;
    }
    .popup h2 {
        margin-top: 0;
    }
    .popup button {
        display: block;
        margin: 10px auto 0;
    }
    
    .popup a {
	    text-decoration: none;
	    color: inherit; /* Keeps the color of the text/button */
	}
    
</style>
</head>
<body>
<section class="d-flex p-5">
	<table id="calendar" style="width:60%;">
	    <!-- Row for year and month header -->
	    <tr id="calendarTitleRow">
	        <td align="center"><button onclick="prevCalendar()"><</button></td>
	        <td colspan="5" id="calendarTitle" class="calendar-header"></td>
	        <td align="center"><button onclick="nextCalendar()">></button></td>
	    </tr>
	    <!-- Row for weekday names -->
	    <tr class="weekday-header">
	        <td><font color="#F79DC2">일</font></td>
	        <td>월</td>
	        <td>화</td>
	        <td>수</td>
	        <td>목</td>
	        <td>금</td>
	        <td><font color="skyblue">토</font></td>
	    </tr>
	</table>
	
	<!-- Popup for reservation details -->
	<div id="reservationPopup" class="popup">
	    <h2>예약 상세 정보</h2>
	    <div id="reservationDetails"></div>
		    <div class="d-flex">
		    	<a href="#">
		            <button id="btn-confirmed" class="btn btn-outline-primary btn-sm me-1">예약확정</button>
		        </a>
		        <a href="#">
		    		<button id="btn-canceled" class="btn btn-outline-danger btn-sm me-1">예약취소</button>
		    	 </a>
		    </div>
	    	
	</div>

	<div class="container ms-5" style="width:40%;">
		<h3> <%=now%> 예약 리스트</h3>
		<table class="table">
			<thead>
				<tr>
					<th>예약번호</th>					
					<th>아이디</th>
					<!-- <th>예약내용</th> -->
					<th>날짜</th>
					<th>시간</th>	
					<th>상태</th>				
				</tr>
			</thead>
			<tbody>
				<c:if test="${list.size() == 0}">
					<tr>
						<td colspan="5">당일 예약이 존재하지 않습니다!!</td>
					</tr>				
				</c:if>
				<c:if test="${list != null}">
				    <c:forEach var="dto" items="${list}">
				        <tr>
				            <td>${dto.rno}</td>
				            <td>${dto.rid_fk}</td>
				            <%-- <td>${dto.contents}</td>  --%>               
				            <td>${dto.date}</td>
				            <td>${dto.time}</td>
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
				        </tr>
				    </c:forEach>
				</c:if>
			</tbody>
		</table> 
	</div>
</section>

<div>
	<a href="calendarList.do">달력리스트</a>
	<a href="calendar2.do">달력old</a>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
var today = new Date();
var reservations = {};

$(document).ready(function() {
    loadReservations(today.getFullYear(), today.getMonth() + 1);
});

var thisMonth = today.getMonth() + 1;

function loadReservations(year, month) {
    $.ajax({
        url: "calendarList.do",
        type: "GET",
        dataType: "json",
        data: { year: year, month: month },
        success: function(data) {
            reservations = {};

            data.forEach(function(item) {
                let date = item.date; // Expected format YYYY-MM-DD
                let monthInData = parseInt(date.split('-')[1], 10);
                let day = parseInt(date.split('-')[2], 10);

                if (monthInData === month) {
                    if (!reservations[day]) {
                        reservations[day] = [];
                    }
                    reservations[day].push({
                    	rno: item.rno,
                        time: item.time,
                        rid: item.rid_fk,
                        details: item.contents,
                        status: item.reservationStatus
                    });
                }
            });

            buildCalendar();
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 에러:", error);
        }
    });
}

function buildCalendar() {
    var row = null;
    var cnt = 0;

    var calendarTable = document.getElementById("calendar");
    var calendarTableTitle = document.getElementById("calendarTitle");
    calendarTableTitle.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";

    var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
    var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);

    // Clear previous rows except headers
    while (calendarTable.rows.length > 2) {
        calendarTable.deleteRow(calendarTable.rows.length - 1);
    }

    row = calendarTable.insertRow();
    for (var i = 0; i < firstDate.getDay(); i++) {
        var cell = row.insertCell();
        cell.className = 'date-cell';
        cnt += 1;
    }

    for (var i = 1; i <= lastDate.getDate(); i++) {
        var cell = row.insertCell();
        cell.className = 'date-cell';
        cnt += 1;

        cell.setAttribute('id', i);
        cell.innerHTML = "<div>" + i + "</div>";
		
        // 이미 지난날 클래스명에 'past-date' 추가해서 css로 배경색 회색으로 변경하기
        /* var cellDate = new Date(today.getFullYear(), today.getMonth(), i);
        if (cellDate < new Date()) {
            cell.className += ' past-date';
        } */
        var cellDate = new Date(today.getFullYear(), today.getMonth(), i);
        var currentDate = new Date();
        var todayDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate());

        if (cellDate < todayDate) {
            cell.className += ' past-date';
        }
        
        // Adding reservation list
        if (reservations[i]) {

	        var reservationListHTML = "<div class='reservation-list'>";
	        var column1 = "<div class='reservation-column'>";
	        var column2 = "<div class='reservation-column'>";
	
	        reservations[i].forEach(function(reservation, index) {

	         	// Determine if the reservation item should have past-date class
                var isPastDate = cellDate < todayDate;

                var reservationClass = '';
                if (reservation.status === 'DONE') {
                    reservationClass = ' confirmed-reservation';
                }
                if (isPastDate) {
                    reservationClass = ' past-date';
                }
                
                var reservationHTML = "<div class='reservation-item" + reservationClass + "'>";
                reservationHTML += "<a href='#' onclick='showDetails(\"" + reservation.rno + "\", \"" + reservation.time + "\", \"" + reservation.rid + "\", \"" + reservation.details + "\", \"" + reservation.status + "\"); return false;'>" 
                + reservation.time + "</a></div>";
	
	            if (index % 2 === 0) {
	                column1 += reservationHTML;
	            } else {
	                column2 += reservationHTML;
	            }
	        });
	
	        column1 += "</div>";
	        column2 += "</div>";
	
	        reservationListHTML += column1 + column2 + "</div>";
	        cell.innerHTML += reservationListHTML;
	    }

       /*  cell.onclick = function() {
            var clickedYear = today.getFullYear();
            var clickedMonth = (1 + today.getMonth());
            var clickedDate = this.getAttribute('id');

            clickedDate = clickedDate >= 10 ? clickedDate : '0' + clickedDate;
            clickedMonth = clickedMonth >= 10 ? clickedMonth : '0' + clickedMonth;
            var clickedYMD = clickedYear + "-" + clickedMonth + "-" + clickedDate;

            opener.document.getElementById("date").value = clickedYMD;
            self.close();
        } */

        if (cnt % 7 == 1) {
            cell.innerHTML = "<div><font color='#F79DC2'>" + i + "</font></div>" + (reservations[i] ? reservationListHTML : "");
        }

        if (cnt % 7 == 0) {
            cell.innerHTML = "<div><font color='skyblue'>" + i + "</font></div>" + (reservations[i] ? reservationListHTML : "");
            row = calendarTable.insertRow();
        }
    }

    if (cnt % 7 != 0) {
        for (var i = 0; i < 7 - (cnt % 7); i++) {
            var cell = row.insertCell();
            cell.className = 'date-cell';
        }
    }
}

// 팝업창 예약상세사항 보기
function showDetails(rno, time, rid, details, status) {
    var popup = document.getElementById('reservationPopup');
    var detailsDiv = document.getElementById('reservationDetails');
    
    detailsDiv.innerHTML = "<p><strong>시간:</strong> " + time + "</p>" +
						    "<p><strong>예약 ID:</strong> " + rid + "</p>" +
						    "<p><strong>상세 정보:</strong> " + details + "</p>" +
						    "<p><strong>상태:</strong> " + status + "</p>";
    
    var confirmButton = document.getElementById('btn-confirmed');
   
    if (status === 'DONE') {
        confirmButton.style.display = 'none';
    } else {
        confirmButton.style.display = 'block';
        confirmButton.parentElement.setAttribute("href", "reservationConfirmed.do?rno=" + rno);
    }
    
    var cancelButton = document.getElementById('btn-canceled');
    cancelButton.parentElement.setAttribute("href", "reservationCancel.do?rno=" + rno);
   
    
    
    popup.style.display = 'block';
}

// 빈곳 클릭하면 팝업창 닫기
$(document).mouseup(function(e) {
    var popup = $("#reservationPopup");

    // If the target of the click isn't the popup or a descendant of the popup
    if (!popup.is(e.target) && popup.has(e.target).length === 0) {
        popup.hide();
    }
});

// 달력 전달 선택
function prevCalendar() {
    today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
    thisMonth = today.getMonth() + 1; // Update thisMonth
    loadReservations(today.getFullYear(), thisMonth);
}

//달력 다음달 선택
function nextCalendar() {
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
    thisMonth = today.getMonth() + 1; // Update thisMonth
    loadReservations(today.getFullYear(), thisMonth);
}

</script>
