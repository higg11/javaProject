<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 천단위로 변경 -->

<%@ include file="../include/header.jsp" %>	

<style>/* 세로정렬 */
	td {vertical-align:middle;}
</style> 

<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

  <!-- 자바스크립트 불러오기 --> 
  <!-- url "userJoinOk.do" 위치가 root에 있기때문에 "js/valid.js" -->
  <%--	주소  src="js/checkout.js"  == src="<c:url value="/js/checkout.js"/>" 같은내용
  
<script type="text/javascript" src="<c:url value="/js/checkout.js"/>" charset="utf-8"></script> --%>
<script type="text/javascript" src="resources/js/checkout.js" charset="utf-8"></script>


<div class="container w-75 mt-3">
	<h3>주문 / 결제</h3><br>
	<table class="table">
		<thead>
			<tr>								<!-- 체크박스.js 함수 확인해야함 -->
				<th><input type="checkbox" id="checkAll" onclick="checkAll()"/></th>
				<th>상품이미지</th>
				<th>상품명</th>
				<th>수량</th>
				<th>판매가</th>
				<th>합계</th>
				<!-- <th>삭제</th> -->
			</tr>
		</thead>
		<tbody> <!-- 장바구니 상품 출력 // 구매하기 진행시 보일부분 -->
				<!-- 총액 합계초기화 -->
			<c:set var="cartTotPrice" value="0"/>
			<c:set var="cartTotPoint" value="0"/>
			
			<c:forEach var="dto" items="${sessionScope.dtos}">
				<tr>
					<td>
						<input type="checkbox" name="chk" value="${dto.pnum_fk}"/> <!-- 아래 체크박스들 -->
					</td>
					<td>
						<a href="UprodView.do?pnum=${dto.pnum_fk}&pSpec=${dto.pspec}"> <!-- 클릭시 접속링크 -->
						<img src="<c:url value="/resources/fileRepo/${dto.pimage}"/>"
								width="60px"/>
						</a>
					</td>
					<td>${dto.pname}</td>
					<td>${dto.pqty}개</td>
					<td>
						<fmt:formatNumber value="${dto.price}"/>원<br/>
						<fmt:formatNumber value="${dto.point}"/>포인트
					</td>
					<td>
						<fmt:formatNumber value="${dto.totPrice}"/>원<br/>
						<fmt:formatNumber value="${dto.totPoint}"/>포인트
					</td>
					<td>
			    		<form action="deleteCheckout.do" method="post">
							<input type="hidden" name="pnum_fk" value="${dto.pnum_fk}"/>
							<!-- <input type="submit" value="삭제" class="btn btn-sm btn-danger"/> -->
						</form>
					</td>
					
					<!-- 총액 합계 계산 -->
					<c:set var="cartTotPrice" value="${cartTotPrice + dto.totPrice}"/>
					<c:set var="cartTotPoint" value="${cartTotPoint + dto.totPoint}"/>
				</tr>
			</c:forEach>
			<tr>							<!-- name="checkForm"은 checkout.js파일에서 사용됌 -->
				<form action="deleteCheckout.do" name="checkForm" method="post">
					<input type="hidden" name="delPnums"/> <!-- name="delPnums"은 checkout.js파일에서 사용하고 받음 -->
					<td colspan="7">	
						<a href="javascript:prodDel()" class="btn btn-sm btn-outline-secondary">선택삭제</a>
					</td>
				</form>
			</tr>
		</tbody>
	</table><br/>
	<!-- 장바구니 총액표시 -->
	<div class="text-end">
		장바구니 합계 : <fmt:formatNumber value="${cartTotPrice}"/> 원 <br>
		포인트 합계 : <fmt:formatNumber value="${cartTotPoint}"/> 포인트 <br>
	</div><br/>
	
	<!-------------------------- 구매자 정보 -------------------------->
		<table class="table">
            <thead>
               <tr>
                  <th>구매자 정보</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td>이름</td>
                  <td>${mDto.name}</td>
               </tr>
               <tr>
                  <td>이메일</td>
                  <td>${mDto.email}</td>
               </tr>
               <tr>
                  <td>전화번호</td>
                  <td>${mDto.tel}</td>
               </tr>
               <tr>
                  <td><b>받는사람 정보</b></td>
               </tr>
               <tr>
                  <td>이름</td>
                  <td>${mDto.name}</td>
               </tr>
               <tr>
                  <td>우편번호</td>
                  <td>${mDto.zipcode}</td>
               </tr>
                <tr>
                  <td>주소</td>
                  <td>${mDto.road_addr}</td>
               </tr>
               <tr>
                  <td>상세주소</td>
                  <td>${mDto.detail_addr}</td>
               </tr>
               <tr>
                  <td>전화번호</td>
                  <td>${mDto.tel}</td>
               </tr>
               <tr>
                  <td><b>결제정보</b></td>
               </tr>
               <tr>
                  <td>총 주문금액</td>
                  <td><fmt:formatNumber value="${cartTotPrice}"/> 원 </td>
               </tr>
               <tr>
                  <td>포인트</td>
                  <td>   
                  	<!-- 전액사용 체크되는 순간 : obj=체크박스, 토탈포인트, 총결제값이 넘어감 -->               
                     <input type="text" id="point" size="10" oninput="removeChar(event)"/>
                     <input type="checkbox" id="use" onclick="usePoint(this, ${cartTotPoint}, ${cartTotPrice})"/>
                     <label for="use">
                        전액사용 [<fmt:formatNumber value="${cartTotPoint}"/>원]
                     </label>
                  </td>
               </tr>

               <tr>
                  <td>결제금액</td>
                  <td id="cartTotPrice">
                      <fmt:formatNumber value="${cartTotPrice}"/> 원
                  </td>
               </tr>
               
               <tr>
                  <td>결제방법</td>
                  <td>													<!-- "selPayment()" *.js 함수사용 -->
                     <label><input type="radio" name="payment" value="card" onclick="selPayment()" checked/> 신용카드</label>&nbsp;
                     <label><input type="radio" name="payment" value="rTransfer" onclick="selPayment()"/> 실시간 계좌이체</label>&nbsp;
                     <label><input type="radio" name="payment" value="deposit" onclick="selPayment()"/> 무통장 입금</label>&nbsp;
                     <label><input type="radio" name="payment" value="hp" onclick="selPayment()"/> 휴대폰 결제</label>&nbsp;
                  </td>
               </tr>
            </tbody>
         </table>
	<!--------------------------------------------------------------->
		
		<div id="card">
            카드선택 : <select>
               <option value="" selected>카드사 선택</option>
               <option value="samsung">삼성카드</option>
               <option value="shinhancard">신한카드</option>
               <option value="lotte">롯데카드</option>
               <option value="bc">비씨카드</option>
               <option value="hyundai">현대카드</option>
            </select><br/><br/>			<!-- 포인트 사용으로 50000원 밑으로 내려가는 경우의 수도 생각해봐야 함 -->
            할부기간 : <select <c:if test="${cartTotPrice < 50000}">disabled</c:if> >
               <option value="1" selected>일시불</option>
               <option value="2">2개월 무이자할부</option>
               <option value="3">3개월 무이자할부</option>
               <option value="4">4개월 무이자할부</option>
               <option value="5">5개월 무이자할부</option>
               <option value="6">6개월 무이자할부</option>
            </select><br/><br/>
         </div>
         <div id="rTransfer" style="display:none">
            은행선택 : <select>
               <option value="" selected>은행선택</option>
               <option value="kakao">카카오뱅크</option>
               <option value="woori">우리은행</option>
               <option value="kookmin">국민은행</option>
               <option value="shinhan">신한은행</option>
            </select>
         </div>
         <div id="deposit" style="display:none" >
            입금은행 : <select>
               <option value="" selected>은행선택</option>
               <option value="kakao">카카오뱅크</option>
               <option value="woori">우리은행</option>
               <option value="kookmin">국민은행</option>
               <option value="shinhan">신한은행</option>
            </select>
            <ul style="font-size:12px"><br>
               무통장 입금시 유의사항
               <li>입금완료 후 상품 품절로 인해 자동취소된 상품은 환불 처리해 드립니다.</li>
               <li>무통장입금 결제 시 부분취소가 불가하며 전체취소 후 다시 주문하시기 바랍니다.</li>
               <li>은행 이체 수수료가 발생될 수 있습니다. 입금시 수수료를 확인해주세요.</li>
            </ul>
         </div>
         <div id="hp" style="display:none" >
            통신사 : <select>
                  <option value="" selected>선택</option>
                  <option value="skt">SK</option>
                  <option value="lg">LG U+</option>
                  <option value="kt">KT</option>
            </select>
         </div>
         
	<!--------------------------------------------------------------->
	<input type="hidden" id="userId" value="${sessionScope.loginDTO.id}">
	<div class="text-center mb-5"><br>
		<!-- <a href="orderInsert.do" class="btn btn-primary me-2">결제하기</a> -->
		<button id="submitOrder" class="btn btn-primary me-2">결제하기</button>
		<a href="<c:url value="/"/>" class="btn btn-outline-primary me-2">계속 쇼핑하기</a>
	</div>
	
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('#submitOrder').click(function(event) {
        event.preventDefault(); // Prevent default button behavior

        var userId = $('#userId').val();
        
        // Fetch cart data from the server
        $.ajax({
            url: 'getCartList.do',
            type: 'GET',
            success: function(cartList) {
                // Build the order and orderDetails from the cart data
                var order = {
                    // Do not include order_num here; it's auto-incremented by the database
                    id: userId, // Replace with actual user ID from session
                    total_amount: calculateTotalAmount(cartList),
                    total_point: calculateTotalPoint(cartList),
                    order_date: new Date().toISOString() // Set current date
                };

                var orderDetails = cartList.map(function(cartItem) {
                    return {
                        // The server will assign the order_num after the order is created
                        pnum: cartItem.pnum_fk,
                        quantity: cartItem.pqty,
                        unitPrice: cartItem.price,
                        unitPoint: cartItem.point
                    };
                });

                // Send the order and orderDetails to the server
                $.ajax({
                    url: 'orderInsert.do',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        order: order,
                        orderDetails: orderDetails
                    }),
                    success: function(response) {
                    	alert('주문이 완료되었습니다.');                
                        window.location.href = "myOrderInfo.do";   // Redirect on success
                    },
                    error: function(xhr, status, error) {
                        // Handle any errors
                        alert('주문 처리 중 오류가 발생했습니다.');
                        console.error('Error:', error);
                    }
                });
            },
            error: function(xhr, status, error) {
                alert('장바구니 데이터를 가져오는 중 오류가 발생했습니다.');
                console.error('Error:', error);
            }
        });
    });

    // Helper functions
    function calculateTotalAmount(cartList) {
        return cartList.reduce(function(total, item) {
            return total + (item.pqty * item.price);
        }, 0);
    }

    function calculateTotalPoint(cartList) {
        return cartList.reduce(function(total, item) {
            return total + (item.pqty * item.point);
        }, 0);
    }
});
</script>

<%@ include file="../include/footer.jsp" %>