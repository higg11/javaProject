<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>
<div class="container mt-5 border shadow p-5">
   <h3>상품 등록</h3>
   <form action="prodRegisterOk.do" method="post" enctype="multipart/form-data">
      <table class="table table-borderless">
         <tbody>
            <tr>
               <td>카테고리</td>
               <td>
                  <select class="form-select form-select-sm" name="pcategory_fk">
                  	<c:if test="${categoryList == null}">
                    	<option value="">카테고리 없음</option>
                    </c:if>
                  	<c:if test="${categoryList != null}">
                  		<c:forEach var="dto" items="${categoryList}">
                    		<option value="${dto.cat_code}">${dto.cat_name}[${dto.cat_code}]</option>
                    	</c:forEach>
                    </c:if>
                                        
                  </select>
               </td>
            </tr>
            <tr>
               <td>상품명</td>
               <td><input type="text" class="form-control form-control-sm" name="pname"/></td>
            </tr>
            <tr>
               <td>제조사</td>
               <td><input type="text" class="form-control form-control-sm" name="pcompany"/></td>
            </tr>
            <tr>
               <td>상품이미지</td>
               <td><input type="file" class="form-control form-control-sm" name="pimage"/></td>
            </tr>
            <tr>
               <td>상품수량</td>
               <td><input type="text" class="form-control form-control-sm" name="pqty"/></td>
            </tr>
            <tr>
               <td>상품가격</td>
               <td><input type="text" class="form-control form-control-sm" name="price"/></td>
            </tr>
            <tr>
               <td>상품사양</td>
               <td>
                  <select class="form-select form-select-sm" name="pspec">
                     <!-- 
                     <option value="none" selected>일반</option>
                     <option value="RECOMMEND">추천</option>                        
                     <option value="NEW">신규</option>                        
                     <option value="BEST">인기</option> 
                      -->     
                     <c:forEach var="spec" items="${requestScope.pdSpecs}">
                                   <!-- ${spec.getValue()} 아래코드와 동일 -->
                     	<option value="${spec.name()}">${spec.value}</option>
                     </c:forEach>                  
                  </select>
               </td>
            </tr>
            <tr>
               <td>상품소개</td>
               <td>
                  <textarea class="form-control" name="pcontent" rows="3"></textarea>
               </td>
            </tr>
            <tr>
               <td>상품포인트</td>
               <td><input type="text" class="form-control form-control-sm" name="point"/></td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="submit" class="btn btn-sm btn-primary" value="상품등록"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>
<%@include file="../include/ad_footer.jsp" %>







