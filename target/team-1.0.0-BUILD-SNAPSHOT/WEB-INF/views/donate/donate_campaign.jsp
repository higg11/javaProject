<%@ page import="com.team.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<link rel="stylesheet"
   href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>



<section>

   <!-- sectionTitle -->
   <div class="sectionTitle">
      <div class="centered_content">
         <i class="fa fa-feather"></i>
         <h2 class="centered_title">새로운 소식</h2>
         <div class="centered_subline">지속가능성과 관련된 최신 뉴스 및 소식을 확인해 보세요!</div>
      </div>
   </div> <!-- End of sectionTitle -->
   
   <!-- Start recycle_container -->
   <div class="recycle_container">
   
     <div class="recycle_donation">
           <div class="recycle_row recycle_slider slick-initialized slick-slider">
              <div class="slick-list draggable" >
                   <div class="slick-track" style="opacity: 1; width: 760px; transform: translate3d(0px, 0px, 0px); margin-bottom: 50px;">
                       <div class="slick-slide slick-active" data-slick-index="0" aria-hidden="false" style="width: 380px;">
                           <div class="recycle_item">
                               <div class="recycle_block">
                                   <a class="recycle_blockLink" href="<c:url value='reservation.do'/>">
                                       <span class="recycle_img" role="img" aria-label>
                                          <img src="resources/imgs/recycle_donation.jpg" alt="recycle_donation" style="width: 329px; height: 320px;">
                                       </span>
                                       <div class="recycle_content">
                                           <h5 class="recycle_title">우리 함께 나무심기</h5>
                                           <div class="recycle_text">
                                               <p>기부 캠페인을 진행하고 있습니다. NatureCycle과 함께하세요!</p>
                                           </div>
                                       </div>
                                   </a>
                                   <a class="reservation_link" href="donation.do?id=${sessionScope.loginDTO.id}">기부하러 가기</a>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>    
           </div>    
       </div> <!-- End of recycle_donation -->
       
       <!-- Start recycle_donation -->
       <div class="recycle_donation">
           <div class="recycle_row recycle_slider slick-initialized slick-slider">
               <div class="slick-list draggable" style="margin: -178px;">
                   <div class="slick-track" style="opacity: 1; width: 0px; transform: translate3d(0px, 0px, 0px); margin-bottom: 50px;">
                       <div class="slick-slide slick-active" data-slick-index="0" aria-hidden="false" style="width: 380px; margin-top: 146px; margin-left: -208px;">
                           <div class="recycle_item">
                               <div class="recycle_block">
                                   <a class="recycle_blockLink" href="<c:url value='reservation.do'/>">
                                       <span class="recycle_img" role="img" aria-label>
                                          <img src="resources/imgs/coming_soon.png" alt="recycle_donation" style="width: 329px; height: 320px;">
                                       </span>
                                       <div class="recycle_content">
                                           <h5 class="recycle_title">환경 보호 캠페인에 참여해보세요!</h5>
                                           <div class="recycle_text">
                                               <p>Coming Soon!!!</p><br/>
                                           </div>
                                       </div>
                                   </a>
                                  <a class="reservation_link" href="<c:url value='campaignInfo.do'/>">NatureCycle과 함께하는 캠페인</a>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>    
           </div>    
       </div> <!-- End of recycle_donation -->
   </div> <!-- End of container -->
   
   <script>
    $(document).ready(() => {
      $slickSlider('.recycle_slider', {
      slidesToShow: 3,
      responsive: [
      {
        breakpoint: 1201,
        settings: { slidesToShow: 2 }},
      {
        breakpoint: 768,
        settings: `unslick`
        }]
      })
    });
  </script>

</section>

<%@ include file="../include/footer.jsp"%>