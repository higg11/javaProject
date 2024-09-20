<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 천단위로 변경 -->

<%@ include file="../include/header.jsp" %>	

<style>
/* 세로정렬 */
td {vertical-align:middle;}

.sidebar {
    float: right; /* Positions the sidebar to the right of the main content */
    width: 20%; /* Adjust width as needed */
    margin-left: 20px; /* Space between the main content and the sidebar */
    background-color: #f8f9fa; /* Optional: background color for the sidebar */
    padding: 10px; /* Optional: padding for the sidebar */
    box-sizing: border-box; /* Ensures padding and borders are included in the width */
}

.favorite-item {
    margin-bottom: 15px; /* Space between each favorite item */
    display: flex; /* Aligns the items horizontally */
    align-items: center; /* Vertically centers the items */
    overflow: hidden; /* Ensures content doesn't overflow the container */
}

.favorite-item img {
    max-width: 100px; /* Set a maximum width for the images */
    height: auto; /* Maintains the image's aspect ratio */
    object-fit: cover; /* Ensures the image covers the container without distortion */
    margin-right: 10px; /* Space between image and text */
}

.favorite-item p {
    margin: 0; /* Removes default margin from paragraph */
    overflow: hidden; /* Ensures text does not overflow the container */
}
</style> 


<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<section class="d-flex">
	<div class="container ps-5 w-75 mt-3">
		<h3>장바구니 리스트</h3><br>
		
		<table class="table" id="myTable">
			<thead>
				<tr>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>수량</th>
					<th>판매가</th>
					<th>합계</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="tableBody" ondrop="drop(event)" ondragover="allowDrop(event)"
			 ondragenter="highlight(event)" ondragleave="removeHighlight(event)">
				<!-- '장바구니 담기'가 아닌, '장바구니 확인'하기를 하였을때 장바구니가 없을경우 확인 -->
				<c:if test="${dtos.size() == 0}">
					<tr>
						<td colspan="6">장바구니가 비었습니다!!</td>
					</tr>
				</c:if>
				<c:if test="${dtos.size() != 0}">
					<!-- 총액 합계초기화 -->
					<c:set var="cartTotPrice" value="0"/>
					<c:set var="cartTotPoint" value="0"/>
					<%-- <c:set var="tot_pqty" value="0"/> --%>
					
					<!-- 카트리스트 커맨드에서 바인딩된 dtos를 dto-var변수에 넣는다  -->
					<c:forEach var="dto" items="${dtos}">
						<c:if test="${dto.type != 'Favorite'}">
							<tr>
								<td>
									<a href="UprodView.do?pnum=${dto.pnum_fk}&pSpec=${dto.pspec}"> <!-- 클릭시 접속링크 -->
									<img src="<c:url value="/resources/fileRepo/${dto.pimage}"/>"
											width="60px"/>
									</a>
								</td>
								<td>${dto.pname}</td>
								<td><br>
									<form action="modifyCart.do" method="post">
										<input type="hidden" name="cart_num" value="${dto.cart_num}"/>
										<input type="text" size="3" name="pqty" value="${dto.pqty}"/>개<br/>
										<input type="submit" value="수정" class="btn btn-sm btn-secondary mt-3"/>
									</form>
								</td>
								<td>
									<fmt:formatNumber value="${dto.price}"/>원<br/>
									<fmt:formatNumber value="${dto.point}"/>포인트
								</td>
								<td>
									<fmt:formatNumber value="${dto.totPrice}"/>원<br/>
									<fmt:formatNumber value="${dto.totPoint}"/>포인트
								</td>
						    	<td>
						    		<form action="deleteCart.do" method="post">
										<input type="hidden" name="cart_num" value="${dto.cart_num}"/>
										<input type="submit" value="삭제" class="btn btn-sm btn-danger"/>
									</form>
									<!-- <a href="cartDelete.do" class="btn btn-sm btn-danger">삭제</a> -->
								</td>
								
								<!-- 총액 합계 계산 -->
								<c:set var="cartTotPrice" value="${cartTotPrice + dto.totPrice}"/>
								<c:set var="cartTotPoint" value="${cartTotPoint + dto.totPoint}"/>
								<%-- <c:set var="tot_pqty" value="${tot_pqty + dto.pqty}"/> --%>						
							</tr>
						</c:if>
					</c:forEach>				
				</c:if>
			</tbody>
			
		</table><br/>
		<!-- 장바구니 총액표시 -->
		<div class="text-end">
			장바구니 합계 :  <fmt:formatNumber value="${cartTotPrice}"/> 원 <br>
			포인트 합계 : <fmt:formatNumber value="${cartTotPoint}"/> 포인트 <br>
			
		</div><br/>
		<div class="text-center mb-5">
			<c:if test="${dtos.size() != 0}">	<!-- 장바구니 비어있지 않을때 구매하기 버튼 활성화 -->
				<a href="checkout.do" class="btn btn-primary me-2">구매하기</a>
			</c:if>
			<a href="<c:url value="userMainForm.do"/>" class="btn btn-outline-primary me-2">계속 쇼핑하기</a>
		</div>
	</div>
	<aside class="sidebar">
	    <h6 class="mb-2"><i class="fa-solid fa-heart" style="color:crimson;"></i> 찜하기 리스트</h6>
	    <c:set var="cnt" value="0" />
	    <c:set var="doneLoop" value="false" />
	    <c:forEach var="favorite" items="${sessionScope.favorites}">
	        <c:if test="${not doneLoop}">
	            <c:set var="cnt" value="${cnt+1}" />
	            <div class="favorite-item">
	            	<div>
		                <!-- Add draggable attribute and set data attributes for dragging -->
		                <img src="<c:url value='/resources/fileRepo/${favorite.pimage}'/>" 
		                     alt="${favorite.pname}" 
		                     draggable="true"
		                     ondragstart="drag(event)" 
		                     data-pnum="${favorite.pnum_fk}"
		                     data-pname="${favorite.pname}"
		                     data-pimage="${favorite.pimage}"
		                     data-pspec="${favorite.pspec}"
		                     data-price="${favorite.price}"
		                     data-cart_num="${favorite.cart_num}" />
	                </div>
	                <div>
		                <p>${favorite.pname}</p>
		                <input type="text" class="btn btn-primary btn-sm mt-1 w-75" type="button" 
						value="장바구니이동" onclick="moveToCart(${favorite.cart_num})" style="font-size:10px;"/>
					</div>
	            </div>
	            
	            <c:if test="${cnt%8==0}">  
	                <c:set var="doneLoop" value="true"/>
	            </c:if>
	        </c:if> 
	    </c:forEach>
	</aside>


</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	function moveToCart(cart_num) {
	    
	    location.href="favoriteToCart.do?cart_num="+cart_num;
	    console.log("카트넘버확인 : " + cart_num)
	}


	function allowDrop(event) {
	    event.preventDefault();
	}
	
	function drop(event) {
	    event.preventDefault();  // Necessary to prevent default behavior on drop
	    removeHighlight(event);  // Remove highlight after drop
	    // You can add further code here to handle what happens when the item is dropped
	}

	function highlight(event) {
	    var tableBody = document.getElementById('tableBody');
	    tableBody.style.border = '2px dashed #4CAF50';  // Example: green dashed border
	    tableBody.style.backgroundColor = '#f0f0f0';    // Example: light background color
	}

	function removeHighlight(event) {
	    var tableBody = document.getElementById('tableBody');
	    tableBody.style.border = '';          // Remove border
	    tableBody.style.backgroundColor = ''; // Remove background color
	}
	
	function drag(event) {
		// Store data attributes in the dataTransfer object
		event.dataTransfer.setData("pnum", event.target.getAttribute("data-pnum"));
		event.dataTransfer.setData("pname", event.target.getAttribute("data-pname"));
		event.dataTransfer.setData("pimage", event.target.getAttribute("data-pimage"));
		event.dataTransfer.setData("pspec", event.target.getAttribute("data-pspec"));
		event.dataTransfer.setData("price", event.target.getAttribute("data-price"));
		event.dataTransfer.setData("cart_num", event.target.getAttribute("data-cart_num"));
	}
	
	function drop(event) {
		event.preventDefault();
		
		// Retrieve the product data from the dragged element
		var pnum = event.dataTransfer.getData("pnum");
		var pname = event.dataTransfer.getData("pname");
		var pimage = event.dataTransfer.getData("pimage");
		var pspec = event.dataTransfer.getData("pspec");
		var price = event.dataTransfer.getData("price");
		var cart_num = event.dataTransfer.getData("cart_num");
		
		// Log the data to the console for verification
		console.log("Product Number:", pnum);
		console.log("Product Name:", pname);
		console.log("Product Image:", pimage);
		console.log("Product Spec:", pspec);
		console.log("Product Price:", price);
		console.log("cart_num:", cart_num);
		
		// Check if data is retrieved
		if (!pname || !pimage || !price) {
		    console.error("Some data was not retrieved correctly!");
		    return;
		}
		
		moveToCart(cart_num); 
	} 
	
	function moveToCart(cart_num) {
	   
	    location.href = "favoriteToCart.do?cart_num=" + cart_num;

	}
	
	function removeRow(button) {
	    // Remove the row when delete button is clicked
	    var row = button.parentNode.parentNode;
	    row.parentNode.removeChild(row);
	}

</script>

<%@ include file="../include/footer.jsp" %>