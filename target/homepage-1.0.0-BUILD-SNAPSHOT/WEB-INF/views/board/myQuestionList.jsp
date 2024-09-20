<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.myQuestionInfo li {
    display: inline; /* Aligns list items in a row */
    margin-right: 20px; /* Adds space between list items */
}

/* .myprofile li:hover{
	color: white;
	background: #30622f;
}
 */
</style>

<div class="container w-75 p-5">
	<h3 class="text-center mb-3" style="color : #30622f;"><i class="fa-solid fa-list-check"></i> 문의사항 확인</h3>

	<table class="table">
		<thead class="table" style="color:#00a600;">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<!-- <th>조회수</th> -->
				<th>글쓴이</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${questionPosts.size() == 0}">
					<tr>
						<td colspan="6">문의 내역이 없습니다!!</td>
					</tr>
				</c:if>
				<c:if test="${questionPosts.size() != 0}">
					<c:forEach var="dto" items="${questionPosts}">
						<tr>
							<td>${dto.bid}</td>
							<c:if test="${dto.replyCnt != 0}" >
								<td><a href='<c:url value="view.do?bid=${dto.bid}
								&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}
								&cntPerPage=${pDto.cntPerPage}"/>'><c:out value="${dto.subject}"/> <b>[답변완료]</b> </a></td>
							</c:if>
							<c:if test="${dto.replyCnt == 0}" >
								<td><a href='<c:url value="view.do?bid=${dto.bid}
								&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}
								&cntPerPage=${pDto.cntPerPage}"/>'><c:out value="${dto.subject}"/> [답변대기]</a></td>
							</c:if>
							<%-- <td>${dto.hit}</td> --%>
							<td>${dto.writer}</td>
							<td><fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</c:if>
		</tbody>
	</table>
	<div>
		<button id="reset" class="btn" style="background:#00a600;">돌아가기</button>
	</div>
</div>

<script>

	$("#reset").click(()=>{
		location.href='<c:url value="myQuestion.do?mid_fk=${sessionScope.loginDTO.id}"/>';
	});
</script>

<%@ include file="../include/footer.jsp"%>