<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>
<div class="container mt-5 border shadow p-5">
   <h3>상품 수정</h3>
   <form action="prodUpdateOK.do" method="post" enctype="multipart/form-data">
      <table class="table table-borderless">
         <tbody>
         	<tr>
         		<td>상품번호</td>
         		<td>
         			<input type="text" class="form-control form-control-sm" name="pnum" value="${pDto.pnum}" readonly/>
         		</td>
         	</tr>
            <tr>
               <td>카테고리</td>
               <td>
                  <select class="form-select form-select-sm" name="pcategory_fk">
                  	<c:if test="${categoryList == null}">
                    	<option value="">카테고리 없음</option>
                    </c:if>
                  <!--   <option value="a100" selected>도서</option>
                    <option value="a200">주방가전</option> -->
                  	<c:if test="${categoryList != null}">
                  		<c:forEach var="cDto" items="${categoryList}">
                    		<option value="${cDto.cat_code}" ${(cDto.cat_code == dto.pcategory_fk) ? 'selected':''}>${cDto.cat_name}[${cDto.cat_code}]</option>
                    	</c:forEach>
                    </c:if>
                                        
                  </select>
               </td>
            </tr>
            <tr>
               <td>상품명</td>
               <td><input type="text" class="form-control form-control-sm" name="pname" value="${pDto.pname}"/></td>
            </tr>
            <tr>
               <td>출판사</td>
               <td><input type="text" class="form-control form-control-sm" name="pcompany" value="${pDto.pcompany}"/></td>
            </tr>
             <%-- <tr>
               <td>작가</td>
               <td><input type="text" class="form-control form-control-sm" name="pcompany" value="${pDto.pwriter}"/></td>
            </tr> --%>
            <tr>
               <td>상품이미지</td>
               <td>
               <img src="<c:url value="/resources/fileRepo/${pDto.pimage}"/>" width="100px">
               <br><br>
               <!-- 이미지를 수정하는 경우 -->
               <input type="file" class="form-control form-control-sm" name="pimage"/>
                <!-- 이미지를 수정하지 않을 경우 : 현재 이미지를 전송-->
               <input type="hidden" class="form-control form-control-sm" name="pimageOld" value="${pDto.pimage}"/>
               </td>
            </tr>
            <tr>
               <td>상품수량</td>
               <td><input type="text" class="form-control form-control-sm" name="pqty" value="${pDto.pqty}"/></td>
            </tr>
            <tr>
               <td>상품가격</td>
               <td><input type="text" class="form-control form-control-sm" name="price" value="${pDto.price}"/></td>
            </tr>
            <tr>
               <td>상품사양</td>
               <td>
                  <select class="form-select form-select-sm" name="pspec">
             	   	 	<c:forEach var="spec" items="${requestScope.pdSpecs}">
                        		<option value="${spec.name()}"
                        		${spec.name() == pDto.pspec ? 'selected' : ''}>
                        		[${spec.name()}] ${spec.getValue()}</option>                        									
                    	</c:forEach>
	                </select>
               </td>
            </tr>
            <tr>
               <td>상품소개</td>
               <td>
                  <textarea class="form-control" name="pcontent" rows="3">${pDto.pcontent}</textarea>
               </td>
            </tr>
            <tr>
               <td>상품포인트</td>
               <td><input type="text" class="form-control form-control-sm" name="point" value="${pDto.point}"/></td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="submit" class="btn btn-sm btn-primary" value="상품수정"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>
<%@include file="../include/ad_footer.jsp" %>







