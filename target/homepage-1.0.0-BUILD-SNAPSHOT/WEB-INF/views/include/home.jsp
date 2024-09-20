<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp"%>

<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<style>
div.carousel-item {
   height: 100vh;
    
    > img {
       width: 100vw;
        height: 50%;
    }
}
</style>

<!-- Start carousel -->
<div id="demo" class="carousel slide" data-bs-ride="carousel" style="height: 400px;">
   <!-- Indicators/dots -->
   <div class="carousel-indicators">
     <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
     <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
     <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
     <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
     <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
   </div>
   
   <!-- The slideshow/carousel -->
   <div class="carousel-inner">
      <div class="carousel-item active">
         <img src="resources/imgs/1.jpg" alt="Recycling" class="d-block w-100">
         <div class="carousel-caption">
               <h3></h3>
               <p></p>
         </div>
        </div>
        
      <div class="carousel-item">
           <img src="resources/imgs/2.jpg" alt="Recycle" class="d-block w-100">
         <div class="carousel-caption">
              <h3></h3>
              <p></p>
         </div>
      </div>
      
      <div class="carousel-item">
         <img src="resources/imgs/3.jpg" alt="Nature" class="d-block w-100">
         <div class="carousel-caption">
              <h3></h3>
              <p></p>
         </div>
      </div>
      
      <div class="carousel-item">
         <img src="resources/imgs/4.jpg" alt="recycleDay" class="d-block w-100">
         <div class="carousel-caption">
              <h3></h3>
              <p></p>
         </div>
      </div>
      
      <div class="carousel-item">
         <img src="resources/imgs/5.jpg" alt="recycleDay" class="d-block w-100">
         <div class="carousel-caption">
              <h3></h3>
              <p></p>
         </div>
      </div>
   </div>

   <!-- Left and right controls/icons -->
   <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev" style="margin-bottom: 500px;">
      <span class="carousel-control-prev-icon"></span>
   </button>
   
   <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next" style="margin-bottom: 500px;">
      <span class="carousel-control-next-icon"></span>
   </button>
</div> <!-- End of carousel -->


<div class="home_body w-100">
   <!-- 유효성검사 메인에서 뜨는 상품 인기,추천,신규상품이 없다면, 있다면 -->
   <c:forEach var="key" items="${key}">
      <c:if test="${map[key].size() != 0 }">
         <c:if test="${key eq 'ECO'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>ECO-FRIENDLY</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">친환경 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=ECO">+더보기</a></h6>
            </div>
         </c:if>
         <c:if test="${key eq 'ORGANIC'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>ORGANIC</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">유기농 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=ORGANIC">+더보기</a></h6>
            </div>
         </c:if>
         <c:if test="${key eq 'REFILL'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>REFILL 리필</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">리필 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=REFILL">+더보기</a></h6>
            </div>
         </c:if>
         
         <div class="home_card overflow-hidden" style="max-width: 100%; height: auto;">
               <c:set var="cnt" value="0" />
               <c:set var="doneLoop" value="false" />
                  <c:forEach var="pDto" items="${map[key]}" varStatus="status">
                     <c:if test="${not doneLoop}">
                        <c:set var="cnt" value="${cnt+1}" />
                        <!-- Card -->
                        <%@include file="../product/card.jsp"%>
                        <!-- Card End -->
                        <c:if test="${cnt%5==0}">  
                           <c:set var="doneLoop" value="true"/>
                        </c:if>
                     </c:if>                              
                  </c:forEach>   
             </div>      
         
         <%-- <div class="home_card">
            <c:set var="cnt" value="0" />
            <!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 -->
            <c:forEach var="pDto" items="${map[key]}">
               <c:set var="cnt" value="${cnt+1}" />
               <!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 +1 -->
               <!-- Card -->
               <%@include file="../product/card.jsp"%>
               <!-- Card End -->
               <c:if test="${cnt%4==0}">
         </div>
         <div class="home_card">
            <!-- div테그 종료/재시작, 4배수 일 경우 줄내리고 다음포문 새로시작 -->
               </c:if>
            </c:forEach>

         </div> --%>
      </c:if>
      <c:if test="${map[key].size() == 0 }">
         <br>${key} 상품이 없습니다!!<br>
      </c:if>
      <hr>
   </c:forEach>
   
</div>


<%@ include file="../include/footer.jsp"%>
