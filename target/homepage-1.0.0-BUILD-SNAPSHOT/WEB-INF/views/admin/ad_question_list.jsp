<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/ad_header.jsp"%>


<div class="question_checkList container mt-3">
	<h4>문의사항 확인</h4>

	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>등록일</th>
				<th>답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${qList}">
				<c:if test="${dto.replyCnt != 0}" >
					<tr>
						<td>${dto.bid}</td>
						<td>${dto.mid_fk}</td>
						<td><a href='<c:url value="questionView.do?bid=${dto.bid}
								&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}
								&cntPerPage=${pDto.cntPerPage}"/>'><c:out value="${dto.subject}"/>[완료]</a></td>
						<td>${dto.writer}</td>
						<td><fmt:formatDate value="${dto.reg_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
						<td>답변완료</td>
					</tr>
				</c:if>
				<c:if test="${dto.replyCnt == 0}" >
					<tr>
						<td>${dto.bid}</td>
						<td>${dto.mid_fk}</td>
						<td><a href='<c:url value="questionView.do?bid=${dto.bid}
								&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}
								&cntPerPage=${pDto.cntPerPage}"/>'><c:out value="${dto.subject}"/>[대기]</a></td>
						<td>${dto.writer}</td>
						<td><fmt:formatDate value="${dto.reg_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
						<td style="color: crimson;">답변대기</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="../include/ad_footer.jsp"%>