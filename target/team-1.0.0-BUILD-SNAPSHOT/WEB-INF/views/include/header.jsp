<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>NatureCycle</title>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.6.0/css/all.css">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- main.css -->
<link href="<c:url value="/resources/css/main.css"/>" rel="stylesheet" />

</head>

<style>
	body {
		margin: 50px 100px 50px 100px; /* top right bottom left */
	}
	
	ul {
		list-style: none; /* - 삭제 */
	}
	
	li>a {
		text-decoration: none; /* 밑줄 삭제 */
	}
	
 	.fa-seedling {
	    color: yellowgreen;	    
	}
</style>

<body>
	<nav style="z-index:2">
		<div class="container">
			<ul class="navbar-nav w-100">
				<c:if test="${sessionScope.loginDTO.id == null}">
					<li class="nav-item ms-auto d-flex ">
						<a class="nav-link register" href="<c:url value="memberRegister.do"/>">회원가입</a>&nbsp;&nbsp;&nbsp;
						<a class="nav-link login" href="<c:url value="login.do"/>">로그인</a>&nbsp;&nbsp;&nbsp;
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">회원안내</button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="#">신규가입 혜택</a></li>
   							<li><a class="dropdown-item" href="#">멤버쉽 혜택</a></li>
						    <li><a class="dropdown-item" href="#">제휴상품권 결제</a></li>
						  </ul>
						</div>&nbsp;&nbsp;&nbsp; 						
						<a class="nav-link cs"	href="<c:url value="list.do"/>">공지사항</a>
					</li>
				</c:if>

				<c:if test="${sessionScope.loginDTO.id != null}">
					<li class="nav-item ms-auto my-auto d-flex">
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" style="background:#d8f5de;">
						  <i class="fa-solid fa-seedling"><span id=member_level> 등급</span></i></button>
						  <ul class="dropdown-menu" style="width: 250px;">
						  	<li class="ms-2">[회원등급 정보]</li>
						    <li class="ms-3">Seed 등급 : 구매 시 3% 할인</li>
   							<li class="ms-3">Sprout 등급 : 구매 시 5% 할인</li>
						    <li class="ms-3">Tree 등급 : 구매 시 7% 할인</li>
						    <li class="ms-3">Earth 등급 : 구매 시 10% 할인</li>
						  </ul>
						</div>&nbsp;&nbsp;&nbsp; 
						<p class="me-3 welcome my-auto"><i class="fa fa-user-circle">&nbsp;</i>${sessionScope.loginDTO.id}님 환영합니다!!</p>&nbsp;&nbsp;&nbsp; 
						<%-- <a class="nav-link"	href="<c:url value="myProfile.do?no=${sessionScope.loginDTO.no}"/>">내정보관리</a>&nbsp;&nbsp;&nbsp; --%> 
						<a class="nav-link login" href="<c:url value="javascript:logout()"/>">로그아웃</a>&nbsp;&nbsp;&nbsp; 
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" >회원안내</button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="#">신규가입 혜택</a></li>
   							<li><a class="dropdown-item" href="#">멤버쉽 혜택</a></li>
						    <li><a class="dropdown-item" href="#">제휴상품권 결제</a></li>
						  </ul>
						</div>&nbsp;&nbsp;&nbsp; 						
						<a class="nav-link cs"	href="<c:url value="list.do"/>">공지사항</a>					
					</li>
				</c:if>				
			</ul>
		</div>
	</nav>
	<nav class="navbar navbar-expand-sm sticky-top" style="z-index:2">
	    <div class="container">
	        <ul class="navbar-nav w-100">
	            <!-- Logo and Home Link -->
	            <!-- <i class="fa fa-seedling"></i> -->
	            <li class="nav-item w-25">
	                <a class="nav-link" href="<c:url value='/userMainForm.do'/>">
	                    <span><b><h2 style="color:green">NATURE CYCLE</h2></b></span>
	                </a>
	            </li>
	
	            <!-- Cart and User Profile -->
	            <li class="nav-item d-flex justify-content-end align-items-center" style="position: relative">
	                <!-- 장바구니 수량 -->
	                <c:choose>
	                    <c:when test="${sessionScope.loginDTO.id == null}">
	                        <p class="shoppingcart_count">0</p>
	                        <a class="nav-link shoppingcart" href="javascript:alert('로그인이 필요합니다!!')">
	                            <i class="fas fa-shopping-cart ps-1"></i>
	                        </a>
	                    </c:when>
	                    <c:otherwise>
	                        <p class="shoppingcart_count"><span id=tot_pqty></span></p>
	                        <a class="nav-link shoppingcart" href="<c:url value='/cartList.do'/>">
	                            <i class="fas fa-shopping-cart ps-1"></i>
	                        </a>
	                    </c:otherwise>
	                </c:choose>
	                
	                <!-- 마이프로필 -->
                    <a class="nav-link myinfo" href="<c:url value='/myProfile.do'/>">
	                    <i class="fas fa-user-edit ps-2"></i>
	                </a>
	            </li>
	        </ul>
	    </div>
	</nav>

	<nav class="navbar navbar-expand-sm">

	 	<div class="container">
		    <ul class="navbar-nav w-100">	   	
				<div class="dropdown">
				  	<button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown">
				  	<img src="resources/imgs/menu.png"></button>
					<ul class="dropdown-menu">					
						<c:if test="${categoryList.size() != 0}">
						<div class="ms-3 mt-1 mb-3">
							<p6><b>SHOPPING</b></p6>
						</div>
							<div class="d-flex">
								<div class="mb-2">		
									<c:set var="cnt" value="0" />								   
									<!-- <h class="mt-1 mb-2 ms-2"><b>도서</b></h> -->								
									<c:forEach var="dto" items="${categoryList}">									
										<c:set var="cnt" value="${cnt+1}" />
										<li><a class="dropdown-item" href="UcatList.do?cat_num=${dto.cat_num}&code=${dto.cat_code}
										&cat_name=${dto.cat_name}">${dto.cat_name}</a></li>							   		
										<c:if test="${cnt%9==0}">
									</div>
								<div class="mb-2">
										</c:if>	
									</c:forEach>						   	
								   	
								</div>	
							</div>
						</c:if>
						<c:if test="${categoryList.size() == 0}">
							<li>카테고리 없음</li>
						</c:if>			
					</ul>										    	
				</div>&nbsp;&nbsp;&nbsp; 	  
			  
			    <li class="nav-item">
			      <a class="nav-link" href="UprodList.do"><i class="fa fa-store"></i><b> 제품</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			   <li class="nav-item">
			      <a class="nav-link" href="recycle.do"><i class="fa fa-recycle"></i><b> 리사이클</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			    <li class="nav-item">
			      <a class="nav-link" href="campaign.do"><i class="fa fa-tree"></i><b> 캠페인</b></a>
			    </li>
		  </ul>
	  </div>	
	</nav><hr>
	
	
<!--  자바스크립트  -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 부트스트랩 js -->
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js'></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 장바구니 카운트
        $.ajax({
            url: "shoppingCartCount.do",
            type: "GET",
            success: function(data) {
                if (data) {
                    $("#tot_pqty").text(data);
                    console.log("요청값@@@@ : ", data);
                } else {
                    $("#tot_pqty").text("Error");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 에러:", error);
            }
        });
        
     // 회원등급
        $.ajax({
            url: "memberLevel.do",
            type: "GET",
            dataType: "text",
            success: function(data) {
                if (data) {
                    $("#member_level").text(data);
                    console.log("요청값@@@@ : ", data);
                } else {
                    $("#member_level").text("Error");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 에러:", error);
            }
        });
    }); 
    
    function logout() {
        location.href = "<c:url value='logout.do'/>";
    }
    
</script>



<main>
	<!-- 스티키 메뉴바 사용 -->
	<div class="container" >
