<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file="../include/ad_header.jsp" %>

<style>
.popup {
    display: none; /* 기본적으로는 보이지 않게 설정 */
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    border: 2px solid #ccc;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;
}
</style>
     
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container mt-5 border shadow p-5">
	<h3><i class="fa-solid fa-triangle-exclamation" style="color: red;">재고 부족 상품</i></h3>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>					
				<th>카테고리 코드</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>제조사</th>
				<th>수량</th>
				<th>입고</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${stock == null}">
				<tr>
					<td>모든 상품의 재고가 충분합니다!!</td>
				</tr>
			</c:if>
			<c:if test="${stock != null}">
				<c:forEach var="item" items="${stock}">
				<tr>
					<td>${item.pnum}</td>
					<td>${item.pcategory_fk}</td>
					<td>
					<!-- c:url은 context path를 자동으로 붙여줌  -->
						<img src="<c:url value="/resources/fileRepo/${item.pimage}"/>" width="60px"/>
					</td>
					<td>${item.pname}</td>
					<td>${item.price}</td>
					<td>${item.pcompany}</td>
					<td style="color: red;">${item.pqty}</td>
					<td>
						<a href="#" class="btn btn-sm btn-info">신청</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table> 	
</div>
<div class="container mt-5 border shadow p-5">
	<h3>상품 리스트</h3>
	<!-- 검색 -->
		<div class="d-flex justify-content-between align-items-center">
			<form action="prodList.do" id="searchForm" method="get">
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
		<thead>
			<tr>
				<th>번호</th>					
				<th>카테고리 코드</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>제조사</th>
				<th>수량</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list==null}">
				<tr>
					<td>상품이 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<c:if test="${list != null}">
				<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.pnum}</td>
					<td>${dto.pcategory_fk}</td>
					<td>
					<!-- c:url은 context path를 자동으로 붙여줌  -->
						<img src="<c:url value="/resources/fileRepo/${dto.pimage}"/>" width="60px"/>
					</td>
					<td>${dto.pname}</td>
					<td>${dto.price}</td>
					<td>${dto.pcompany}</td>
					<td>${dto.pqty}</td>
					<td>
						<a href="prodUpdate.do?pnum=${dto.pnum}" class="btn btn-sm btn-info">수정</a>
						<a href="javascript:prodDel('${dto.pnum}', '${dto.pimage}')" class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<!-- ----------------------페이지 네이션------------------------- -->
		<ul class="pagination justify-content-center">
		  <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
		  	<a class="page-link" href="prodList.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">이전</a>
		  </li>
		  
		  <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
			  <li class="page-item ${pDto.viewPage == i ? 'active':''}">
			  	<a class="page-link" href="prodList.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
			  </li>
		  </c:forEach>
		  
		  <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
		  	<a class="page-link" href="prodList.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음</a>
		  </li>
		</ul> 	
</div>
<script type="text/javascript">
	function prodDel(pnum, pimage){
		let isDel = confirm("삭제 하시겠습니까?")
		if(isDel) location.href="prodDelete.do?pnum="+pnum+"&pimage="+pimage;
	}
	
	// 현재페이지 설정
	$("#cntPerPage").change(()=>{
		var cntVal = $("#cntPerPage").val();
		/* alert(cntVal); */
		
		location.href="prodList.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage="+cntVal;
	});	
	
</script>
<%@include file="../include/ad_footer.jsp" %>







