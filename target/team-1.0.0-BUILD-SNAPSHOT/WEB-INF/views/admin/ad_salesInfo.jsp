<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/ad_header.jsp" %>

<%
    // 현재 날짜를 가져옴
    LocalDate now = LocalDate.now();
    
    // 날짜를 "yy-MM" 형식으로 포맷팅
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM");
    String cur_month = now.format(formatter);
    
 	// request scope에 cur_month 저장
    request.setAttribute("cur_month", cur_month);
%>


 <style>
 body {
	background: #F3F5F7;
}
 
 
main {
	width: 90%;
	max-width: 1200px;
	margin: 20px auto 100px;
}
 
section {
	background: #fff;	
	padding: 10px 5px;
	border: 1px solid #E0E5EE;
	margin-bottom: 20px;
}
 
 
.today {
	display: flex;
	justify-content: space-between;	
	align-items: center;
}
 
.today #today {
	font-weight: bold;
	margin-left: 10px;
}
 
section.graph_section {
	overflow-x: auto;	
}
 
section.graph_section::-webkit-scrollbar {
    display: none;
}
 
 
.box {
	min-width: 650px;
}
 
 
main button {
	padding: 5px 10px;
	border-radius: 5px;
	background: #fff;
	border: 1px solid #ccc;
	font-size: 1.2rem;
}
 
main #date {
	padding: 5px 10px;
	border-radius: 5px;
	font-weight: bold;
	border: 1px solid #ccc;
	font-size: 1.2rem;
}
 
main h1 {
	margin: 20px 0;
}
 
main .graph_box {
	position: relative;
	height: 55vh;
}
 
main .graph_box .graph_background {
	position: absolute;
	top: 0;
	width: 100%;
	height: 100%;
	
	display: none; 
	
}
 
main .graph_box .graph_background div {
	height: 20%;
	width: 100%;
	border: 1px solid #ddd;
	border-top: none;
}
 
main .graph_box ul {
	display: flex;
	height: 100%;
}
 
main .graph_box ul li {
	flex: 1;
	margin-right: 5px;
	display: flex;
	align-items: center;
	justify-content: end;
	flex-direction: column;
}
 
main .graph_box .graph {
	width: 30%;
	min-height: 3px;
	background: green;
	z-index: 1;
	border-radius: 5px 5px 0 0;
	position: relative;
	transition: 0.1s;
	cursor: pointer;
}
 
main .graph_box .graph:hover {
    transform: scaleX(1.2);
    background: red;
}
 
main .graph_box .sales {
	font-size: 1.15rem;
}
 
main .graph_box .graph_date {
	font-size: 1.15rem;
}
 
	
</style> 
    
<main>
	<section class="w-50">
		<div class="today m-2">
			<span>
				<span>오늘 매출</span>
				<span id="today"></span>
			</span>
			
			<input type="button" value="상세보기" class="btn btn-secondary btn-sm" onclick="toggleList()"/>
			
		</div>
		<div><span id="ajaxList"></span></div>
	</section>

	<section class="graph_section"" > 
		<div class="box">
			<!-- <input type="month" name="date" id="date"> -->
			<!-- <button class="other_month_search" onclick="searchMonth()">검색</button> -->
		
			<h3><b id="month-display">${cur_month}월 매출</b></h3>
			
			<div>(단위 : 원)</div>
			<div class="graph_box">
				<canvas id="graph_box"></canvas>				
			</div>
		
		</div>
	</section>
  		
	<div class="container mt-5">
		<h4>매출 테이블</h4>
		<!-- 검색 -->
		<div class="d-flex justify-content-between align-items-center">
			<form action="salesInfo.do" id="searchForm" method="get">
			    <div class="d-flex">
			        <!-- 게시글 개수를 먼저 선택하고 검색할 경우 선택된 게시글 수 넘겨줌 -->
			        <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
			        <select class="form-select form-select-sm me-2" style="width:100px" name="searchType" id="searchType">
			            <option value="">선택</option>
			            <option value="S" ${pDto.searchType == 'S' ? 'selected': ''}>주문번호</option>
			            <option value="C" ${pDto.searchType == 'C' ? 'selected': ''}>상품명</option>
			            <option value="W" ${pDto.searchType == 'W' ? 'selected': ''}>주문일</option>
			        </select>
			        <input type="text" id="keyword" name="keyword" placeholder="검색어입력"
			               class="form-control rounded-0 rounded-start" style="width:200px"
			               value="${pDto.keyword}">
			        <button class="btn rounded-0 rounded-end" style="background:#1384aa; color:white">
			            <i class="fa fa-search"></i>
			        </button>
			        <button type="button" id="resetButton" class="btn btn-secondary ms-2">리셋</button>
			    </div>
			</form>
			<form action="salesInfoPeriod.do" id="searchForm" method="get">
			   <div>			   		 
			        <input type="text" id="datepicker1" name="startDate" placeholder="시작일" >
			        <input type="text" id="datepicker2" name="endDate" placeholder="종료일" >
			        <button class="btn rounded-0 rounded-end" style="background:#1384aa; color:white"><i class="fa fa-search"></i></button>
			    </div>
			    
		    </form>		
		</div>
	
		<div class="d-flex my-3 justify-content-between">
			<div><b>${pDto.viewPage}</b> / ${pDto.totalPage} pages</div>
			
			<!-- 검색이 없는 경우 게시글 개수 선택 -->
		   <c:if test="${pDto.searchType == null || pDto.searchType ==''}">
			<div>
				<select class="form-select form-select-sm" id="cntPerPage">				
					<option value="5" ${pDto.cntPerPage == 5 ? 'selected': ''}>게시글 5개</option>
					<option value="10" ${pDto.cntPerPage == 10 ? 'selected': ''}>게시글 10개</option>
					<option value="20" ${pDto.cntPerPage == 20 ? 'selected': ''}>게시글 20개</option>
				</select>
			</div>
			</c:if>
			
			<!-- 검색이 있는 경우 게시글 개수 선택 -->
	         <c:if test="${pDto.searchType != null && pDto.searchType !=''}">
	         <div>
	            <select class="form-select form-select-sm" id="cntPerPage">
	               <c:choose>
	                  <c:when test="${pDto.totalCnt <= 5}">
	                     <option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>선택없음</option>
	                  </c:when>
	                  
	                  <c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 10}">
	                     <option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
	                     <option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
	                  </c:when>
	                  
	                  <c:when test="${pDto.totalCnt >=10 && pDto.totalCnt < 20}">
	                     <option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
	                     <option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
	                  </c:when>
	                  
	                  <c:otherwise>
	                     <option value="5" ${pDto.cntPerPage== 5 ? 'selected':''}>게시글 5개</option>
	                     <option value="10" ${pDto.cntPerPage== 10 ? 'selected':''}>게시글 10개</option>
	                     <option value="20" ${pDto.cntPerPage== 20 ? 'selected':''}>게시글 20개</option>
	                  </c:otherwise>
	               </c:choose>
	            </select>
	         </div>
	         </c:if> 
		</div>
		<table class="table">
			<thead class="table-dark">
				<tr>
					<th>주문번호</th>
					<th>회원아이디</th>
					<th>주문일</th>
					<th>상품명</th>
					<th>주문수량</th>
					<th>가격</th>					
				</tr>			
			</thead>
			<tbody>
				<c:forEach var="dto" items="${orderDto}">
					 <tr>
				        <td>${dto.order_num}</td>
				        <td>${dto.id}</td>
				        <%-- <td><fmt:formatDate value="${dto.order_date}" pattern="yyyy-MM-dd"/></td> --%>
				        <td>${dto.order_date}</td>
				        <td>${dto.pname}</td>
				        <td>${dto.quantity}</td>
				        <td><fmt:formatNumber value="${dto.unitPrice}" type="currency"/></td>						
				    </tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- ----------------------페이지 네이션------------------------- -->
		<ul class="pagination justify-content-center">
		  <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
		  	<a class="page-link" href="salesInfo.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">이전</a>
		  </li>
		  
		  <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
			  <li class="page-item ${pDto.viewPage == i ? 'active':''}">
			  	<a class="page-link" href="salesInfo.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
			  </li>
		  </c:forEach>
		  
		  <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
		  	<a class="page-link" href="salesInfo.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음</a>
		  </li>
		</ul>
	</div>
  		
  		
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 주문일(W) 선택 시 datepicker 활성화
        $('#searchType').change(function() {
            if ($(this).val() === 'W') {
                $('#keyword').datepicker({
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    showButtonPanel: true
                }).focus();
            } else {
                $('#keyword').datepicker("destroy"); // 다른 옵션 선택 시 datepicker 해제
            }
        });
    });
</script>

<script type="text/javascript">

	// 오늘 매출 상세보기 
	/* function showList(){
		$.ajax({
			url:"<c:url value='todayAjaxList.do'/>",  // 요청주소 
			type:"get",  // 전송방식
			dataType:"json",  // 서서버에서 응답하는 데이터 형식
			success: resultList,  // 서버에서 성공적으로 요청이 수행되었을 경우 호출되는 함수
			error: function(){alert("error")}  // 서버에서 요청처리를 실패했을 때 처리되는 함수
		});
	} */
	
	  // 오늘매출 상세데이터 불러오기(ajax)
	 function toggleList() {
       let $ajaxList = $("#ajaxList");
       
       if ($ajaxList.is(':visible')) {
           $ajaxList.hide(); // Hide the list if it's visible
       } else {
           showList(); // Fetch and show the list if it's hidden
       }
   }

   function showList() {
       $.ajax({
           url: "<c:url value='todayAjaxList.do'/>",  // 요청주소 (URL for the request)
           type: "get",  // 전송방식 (Request method)
           dataType: "json",  // 서버에서 응답하는 데이터 형식 (Response data format)
           success: function(data) {
               let html = "<table class='table'>";
               html += "   <thead class='table-dark'>";
               html += "     <tr>";
               html += "       <th>주문번호</th>";  // Order Number
               html += "       <th>회원 아이디</th>";    // Member id
               html += "       <th>주문 금액</th>";  // Price
               html += "     </tr>";
               html += "   </thead>";
               html += "   <tbody>";

               $.each(data, function(index, obj) {
               	 // 서버에서 'order_date'가 'yyyy-MM-dd' 형식으로 오는 것을 가정
                   /* let orderDate = new Date(obj.order_date);
                   let formattedDate = orderDate.toLocaleDateString('ko-KR'); */ // 한국 날짜 형식으로 변환
                   
                   html += "<tr>";
                   html += "<td>" + obj.order_num + "</td>";
                   html += "<td>" + obj.id + "</td>";
                   html += "<td>" + obj.total_amount.toLocaleString() + "</td>";
                   html += "</tr>";
               });

               html += "</tbody>";
               html += "</table>";

               $("#ajaxList").html(html).show();  // Populate and show the list
           },
           error: function() {
               alert("Error occurred while fetching data.");  // Handle error
           }
       });
   }
  
   $("#resetButton").click(()=>{
	   document.getElementById('searchForm').reset();
	   location.href = "salesInfo.do";
	});
   
   
	// datepicker
	$(function() {
        $("#datepicker1,#datepicker2").datepicker({
        	dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
        }); 
        $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
    
     	
	});

	// 현재페이지 설정
	$("#cntPerPage").change(()=>{
		var cntVal = $("#cntPerPage").val();
		/* alert(cntVal); */
		
		location.href="salesInfo.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage="+cntVal;
	});	
	
	// 월 선택 30일 매출 데이터 불러오기
	function searchMonth() {
	        // Get the selected month
	        const selectedMonth = document.getElementById('date').value;
	        if (!selectedMonth) {
	            alert("날짜를 선택하세요.");
	            return;
	        }

	        // Extract year and month
	        const [year, month] = selectedMonth.split('-');
	        
	        // Update the display title
	        document.getElementById('month-display').innerText = `${month}월 매출`;

	        // AJAX call to fetch sales data for the selected month
	        $.ajax({
	            url: "getMonthlySalesData.do",  // URL to fetch data (to be handled in backend)
	            type: "GET",
	            data: {
	                year: year,
	                month: month
	            },
	            success: function(data) {
	                updateGraph(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX 요청 에러:", error);
	                alert("데이터를 불러오는 중 문제가 발생했습니다.");
	            }
	        });
	    }
		
	    function updateGraph(data) {
	        // Parse and format data as needed for Chart.js
	        const labels = data.map(entry => entry.date); // Assuming data has a 'date' field
	        const sales = data.map(entry => entry.sales); // Assuming data has a 'sales' field

	        // Update the graph with new data
	        const ctx = document.getElementById('graph_box').getContext('2d');
	        new Chart(ctx, {
	            type: 'bar',
	            data: {
	                labels: labels,
	                datasets: [{
	                    label: '일일 매출',
	                    data: sales,
	                    backgroundColor: 'lightblue',
	                    borderColor: 'lightblue',
	                    borderWidth: 1
	                }]
	            },
	            options: {
	                scales: {
	                    x: {
	                        beginAtZero: true
	                    },
	                    y: {
	                        beginAtZero: true,
	                        suggestedMax: Math.max(...sales) * 1.2 // y-axis max value
	                    }
	                }
	            }
	        });
	    }
    
	// 바로 작동
	$(document).ready(function() {
		
	   // 숫자를 천 단위로 구분하여 포맷팅하는 함수
	   function formatNumber(num) {
	       return Number(num).toLocaleString(); // 기본 천 단위 구분
	   }

	   // 오늘매출
	   $.ajax({
	       url: "todayPurchase.do",
	       type: "GET",
	       success: function(data) {
	           if (data) {
	               $("#today").text(formatNumber(data) + " 원");
	           } else {
	               $("#today").text("0 원");
	           }
	       },
	       error: function(xhr, status, error) {
	           console.error("AJAX 요청 에러:", error);
	           $("#today").text("Error");
	       }
	   });  	   
	   
		// 일매출 그래프(30일 해당월기준)
		var order_date = [];
		var daily_purchase = [];
		
		$.ajax({
			url: "dailyPurchaseChart.do",
			async: true,
			type: "GET",
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(data) {
				
				for(let i = 0; i < data.length; i++){
					order_date.push(data[i].date);
					daily_purchase.push(data[i].sum);
					
				}
				console.log(daily_purchase);
				
				
				const ctx1 = document.getElementById('graph_box').getContext('2d');
				new Chart(ctx1, {
				    type: 'bar', // 기본 차트 타입을 bar로 설정
				    data: {
				        labels: order_date,
				        datasets: [
				            {
				                label: '일일 매출', // bar 차트의 레이블
				                data: daily_purchase,
				                backgroundColor: 'lightblue',
				                borderColor: 'lightblue',
				                borderWidth: 1,
				                type: 'bar' // 이 데이터 세트는 bar 차트로 표시
				            }
				        ]
				    },
				    options: {
				        plugins: {
				            legend: {
				                display: false, // 범례를 숨김
				            }
				        },
				        scales: {
				            x: {
				                beginAtZero: true
				            },
				            y: {
				                beginAtZero: true,
				                suggestedMax: Math.max(...daily_purchase) * 1.2 // y축의 최대값을 데이터 최대값의 1.5배로 설정
				            }
				        }
				    }
				});

		    },
		    error: function(xhr, status, error) {
		        console.error("AJAX 요청 에러:", error);
		        alert("데이터를 불러오는 중 문제가 발생했습니다.");
		    }
		});
		
		
	});	
	
</script> 
 
</body>
</html>