<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.6.0/css/all.css">
<!-- 자바스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<header>	
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav mx-5 w-75">
      <li class="nav-item">
        <a class="nav-link active" href="<c:url value="/"/>">ShopHOME</a>
      </li>	
      <li class="nav-item">
        <a class="nav-link active" href="<c:url value="adminMain.do"/>">관리자HOME</a>
      </li>
    
      <li class="nav-item ms-auto my-auto">

      	<c:if test="${sessionScope.adLoginDTO.ad_name != null}">        	
        	<sapn class="text-white">관리자님 환영합니다!!</span>
        </c:if>
      	<c:if test="${sessionScope.adLoginDTO.ad_name == null}">
        	<a class="text-white" href="adminLogin.do">로그인</a>
        </c:if>
      	<c:if test="${sessionScope.adLoginDTO.ad_name != null}">
        	<a class="text-white" href="adminLogout.do">로그아웃</a>
        </c:if>
      </li> 
           
    </ul>
  </div>
</nav>
</header>








