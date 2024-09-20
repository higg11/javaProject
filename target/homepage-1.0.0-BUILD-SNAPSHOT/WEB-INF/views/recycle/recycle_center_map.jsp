<%@page import="com.team.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

 
<section class="container w-100 m-5 d-flex flex-column align-items-center">
	<h4 class="m-5" style="color:#00a600;"><i class="fa-solid fa-recycle" style="color:#00a600;"></i> 재활용 지구센터 위치 안내 </h4>
	<p class="mb-5">가까운 지역에 위치한 센터를 검색한 후 방문해주세요</p>
    <div id="map" style="width: 600px; height: 400px; margin-left: auto; margin-right: auto;"></div>
    <div class="search-container" style="text-align: center; margin-top: 20px;">
        <input type="text" id="searchInput" placeholder="검색어를 입력하세요" class="map-search" style="width: 300px;">
        <button id="searchButton" class="btn btn-primary">검색</button>
        <a class="btn btn-primary" href="getMap.do">초기화</a>
    </div>
</section>

   
   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=58c21ce40be173922766ee1db1c9962c"></script>
   <script>

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
      mapOption = {
         center : new kakao.maps.LatLng(37.5665, 126.9780), 
         level : 10
      // 지도의 확대 레벨
      };
		
      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
     
      // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
      var positions = [ {
         content : '<div style="font-size: 12px;">구로자원순환센터</div>'+'<div style="font-size: 12px;">서울 구로구 항동 55-1</div>',
         latlng : new kakao.maps.LatLng(37.4833788, 126.8268809)
      }, {
         content : '<div style="font-size: 12px;">마포자원회수시설</div>'+'<div style="font-size: 12px;">서울 마포구 하늘공원로 86</div>',
         latlng : new kakao.maps.LatLng(37.5703381, 126.8802012)
      }, {
         content : '<div style="font-size: 12px;">은평광역자원순환센터</div>'+'<div style="font-size: 12px;">서울 은평구 진관동 37</div>',
         latlng : new kakao.maps.LatLng(37.6471187, 126.9076469)
      }, {
         content : '<div style="font-size: 12px;">양천자원회수시설</div>'+'<div style="font-size: 12px;">서울 양천구 안양천로 1121</div>',
         latlng : new kakao.maps.LatLng(37.5416442, 126.8839835)
      }, {
         content : '<div style="font-size: 12px;">부천시자원순환센터</div>'+'<div style="font-size: 12px;">경기 부천시 오정구 벌말로 122</div>',
         latlng : new kakao.maps.LatLng(37.5421197, 126.7662934)
      }, {
         content : '<div style="font-size: 12px;">성남재활용센터</div>'+'<div style="font-size: 12px;">경기 성남시 중원구 둔촌대로 146</div>',
         latlng : new kakao.maps.LatLng(37.5450906, 126.8440943)
      }, {
         content : '<div style="font-size: 12px;">노원자원회수시설</div>'+'<div style="font-size: 12px;">서울 노원구 덕릉로70길 99</div>',
         latlng : new kakao.maps.LatLng(37.640547, 127.0586972)
      }, {
         content : '<div style="font-size: 12px;">수도권매립지관리공사</div>'+'<div style="font-size: 12px;">인천 서구 자원순환로 170</div>',
         latlng : new kakao.maps.LatLng(37.5578549, 126.6561702)
      }, {
         content : '<div style="font-size: 12px;">강남자원회수시설</div>'+'<div style="font-size: 12px;">서울 강남구 남부순환로 3318</div>',
         latlng : new kakao.maps.LatLng(37.4942219, 127.0938061)
      }, {
         content : '<div style="font-size: 12px;">수도권자원순환센터</div>'+'<div style="font-size: 12px;">경기 용인시 처인구</div>',
         latlng : new kakao.maps.LatLng(37.1691902, 127.2128767)
      }, {
         content : '<div style="font-size: 12px;">강서재활용</div>'+'<div style="font-size: 12px;">서울 강서구 곰달래로</div>',
         latlng : new kakao.maps.LatLng(37.5410342, 126.839192)
      }, {
         content : '<div style="font-size: 12px;">양천구재활용센터</div>'+'<div style="font-size: 12px;">서울 양천구 목동동로</div>',
         latlng : new kakao.maps.LatLng(37.5373982, 126.8270465)
      }, {
         content : '<div style="font-size: 12px;">우리재활용센터</div>'+'<div style="font-size: 12px;">서울 양천구 곰달래로 40</div>',
         latlng : new kakao.maps.LatLng(37.5298138, 126.8371835)
      }, {
         content : '<div style="font-size: 12px;">영등포구재활용센터</div>'+'<div style="font-size: 12px;">서울 영등포구 노들로 11</div>',
         latlng : new kakao.maps.LatLng(37.5202312, 126.8920933)
      }, {
         content : '<div style="font-size: 12px;">서부재활용센타</div>'+'<div style="font-size: 12px;">전북 전주시 완산구</div>',
         latlng : new kakao.maps.LatLng(37.5165271, 126.8388286)
      }, {
         content : '<div style="font-size: 12px;">서대문구재활용센터</div>'+'<div style="font-size: 12px;">서울 서대문구 연희로</div>',
         latlng : new kakao.maps.LatLng(37.5831916, 126.9362963)
      }, {
         content : '<div style="font-size: 12px;">창일재활용센터</div>'+'<div style="font-size: 12px;">서울 구로구 디지털로</div>',
         latlng : new kakao.maps.LatLng(37.4847338, 126.8881537)
      }, {
         content : '<div style="font-size: 12px;">(주)서울재활용</div>'+'<div style="font-size: 12px;">서울 강남구 세곡동 31-3</div>',
         latlng : new kakao.maps.LatLng(37.5856367, 126.8133598)
      }, {
         content : '<div style="font-size: 12px;">광명재활용센타</div>',
         latlng : new kakao.maps.LatLng(37.4676844, 126.8672002)
      }, {
         content : '<div style="font-size: 12px;">안성시재활용센타</div>',
         latlng : new kakao.maps.LatLng(37.0228847, 127.2660403)
      }, {
         content : '<div style="font-size: 12px;">발안재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.1546413, 126.9261025)
      }, {
         content : '<div style="font-size: 12px;">남동구재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.3986988, 126.7211155)
      }, {
         content : '<div style="font-size: 12px;">아주대학교재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.2843467, 127.0479267)
      }, {
         content : '<div style="font-size: 12px;">안양재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.3929437, 126.9296146)
      }, {
         content : '<div style="font-size: 12px;">안산시재활용센타</div>',
         latlng : new kakao.maps.LatLng(37.3079296, 126.8463354)
      }, {
         content : '<div style="font-size: 12px;">분당재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.3760179, 127.1345923)
      }, {
         content : '<div style="font-size: 12px;">청주재활용센타</div>',
         latlng : new kakao.maps.LatLng(36.6238328, 127.4891406)
      }, {
         content : '<div style="font-size: 12px;">문암재활용센터</div>',
         latlng : new kakao.maps.LatLng(36.6741613, 127.4512318)
      }, {
         content : '<div style="font-size: 12px;">천안시재활용센터</div>',
         latlng : new kakao.maps.LatLng(36.820039, 127.1507342)
      }, {
         content : '<div style="font-size: 12px;">중구재활용센터</div>',
         latlng : new kakao.maps.LatLng(36.3110001, 127.3920753)
      }, {
         content : '<div style="font-size: 12px;">중고재활용백화점</div>',
         latlng : new kakao.maps.LatLng(36.3275261, 127.4023517)
      }, {
         content : '<div style="font-size: 12px;">대덕구재활용센타</div>',
         latlng : new kakao.maps.LatLng(36.3367428, 127.4390912)
      }, {
         content : '<div style="font-size: 12px;">동구재활용센타</div>',
         latlng : new kakao.maps.LatLng(36.3425803, 127.4248213)
      }, {
         content : '<div style="font-size: 12px;">강릉시재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.7443342, 128.9119446)
      }, {
         content : '<div style="font-size: 12px;">춘천시재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.8754209, 127.7127974)
      }, {
         content : '<div style="font-size: 12px;">양양재활용</div>',
         latlng : new kakao.maps.LatLng(38.0711343, 128.6154423)
      }, {
         content : '<div style="font-size: 12px;">원주시재활용센터</div>',
         latlng : new kakao.maps.LatLng(37.3559924, 127.9454652)
      }, {
         content : '<div style="font-size: 12px;">대구종합재활용</div>',
         latlng : new kakao.maps.LatLng(35.8131075, 128.4933731)
      }, {
         content : '<div style="font-size: 12px;">울산재활용</div>',
         latlng : new kakao.maps.LatLng(35.543683, 129.3298017)
      }, {
         content : '<div style="font-size: 12px;">서구재활용센터</div>',
         latlng : new kakao.maps.LatLng(35.8784073, 128.5440612)
      }, {
         content : '<div style="font-size: 12px;">북구재활용센타</div>',
         latlng : new kakao.maps.LatLng(35.206911, 128.9974814)
      }, {
         content : '<div style="font-size: 12px;">여수재활용센타</div>',
         latlng : new kakao.maps.LatLng(34.7639124, 127.7066695)
      }, {
         content : '<div style="font-size: 12px;">금정구남산재활용센터</div>',
         latlng : new kakao.maps.LatLng(35.2612096, 129.0917769)
      }, {
         content : '<div style="font-size: 12px;">덕천재활용</div>',
         latlng : new kakao.maps.LatLng(35.1994798, 129.0058582)
      }, {
         content : '<div style="font-size: 12px;">칠곡재활용센터</div>',
         latlng : new kakao.maps.LatLng(35.9216233, 128.5462818)
      } ];
	
       
    // 마커 및 인포윈도우 생성
    var markers = []; // 마커를 저장할 배열
      for (var i = 0; i < positions.length; i++) {
          var marker = new kakao.maps.Marker({
              map: map,
              position: positions[i].latlng
          });

          var infowindow = new kakao.maps.InfoWindow({
              content: positions[i].content
          });

          kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
          kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

          markers.push({
              marker: marker,
              infowindow: infowindow,
              content: positions[i].content
          });
      }

      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다
      function makeOverListener(map, marker, infowindow) {
          return function() {
              infowindow.open(map, marker);
          };
      }

      // 인포윈도우를 닫는 클로저를 만드는 함수입니다
      function makeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      }

      // 검색 기능 구현
      document.getElementById('searchButton').addEventListener('click', function() {
          var keyword = document.getElementById('searchInput').value.toLowerCase();

          markers.forEach(function(item) {
              var marker = item.marker;
              var infowindow = item.infowindow;
              var content = item.content.toLowerCase();

              if (content.includes(keyword)) {
                  marker.setMap(map); // 마커를 지도에 표시
                  infowindow.open(map, marker); // 검색된 마커에 인포윈도우 표시
              } else {
                  marker.setMap(null); // 마커를 지도에서 제거
                  infowindow.close(); // 인포윈도우 닫기
              }
          });
      });
      
   </script>



<%@ include file="../include/footer.jsp"%>