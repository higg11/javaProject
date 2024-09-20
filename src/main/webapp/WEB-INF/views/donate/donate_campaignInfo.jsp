<%@ page import="com.team.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
.campaignList {
	margin: 0;
}

.campaignCard-item {
	padding: 0 0.8rem;
	margin-bottom: 1.6rem;
}

.campaign {
	overflow: hidden;
	background-color: #ffffff;
	border-radius: 2rem;
	-webkit-transition: 0.15s ease-in-out;
	transition: 0.15s ease-in-out;
	-webkit-box-shadow: 0 0.5rem 1.5rem 0 rgba(0, 0, 0, 0.1);
	box-shadow: 0 0.5rem 1.5rem 0 rgba(0, 0, 0, 0.1);
	-webkit-box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.17);
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.17);
}

.campaignCard-wrapper {
	text-align: center;
	background-color: #ffffff;
	position: relative;
}

.campaignCard-topLabel {
	color: #1b8158;
	font-weight: 700;
	font-size: 1.6rem;
}

.campaignCard-media {
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
	max-width: 100%;
	margin-top: -1px;
	padding: 0 0.5rem;
	-webkit-box-align: center;
	-webkit-box-pack: center;
}

.collectionCard_img {
	max-height: 100%;
	max-width: 100%;
	height: auto;
}

.campaignCard-bottomLabel {
	color: #13220f;
	font-weight: 500;
	font-size: 1rem;
}

.campaignCard-content {
	position: relative;
	z-index: 1;
	padding: 1rem 1rem 0rem 1rem;
	font-size: 0;
	background-color: #f7f7f7;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	will-change: background-color;
}

.campaignCard-title {
	display: -webkit-box !important;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	height: 2.4rem;
	margin-bottom: 0;
	font-size: 12px;
	font-family: fantasy;
	line-height: 1.3;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	will-change: color;
}
</style>

<div class="campaign-container m-5 p-5">
	<div class="campaignList ms-5 ml-5 mb-5" style="position: relative; display: flex;">
		<!-- 1 -->
		<div class="campaignCard-item">
			<!--       <div class="campaignCard-item col-6 col-sm-4 col-md-3 col-xxl-2"> -->
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/12563/thumbnail/220302_배너(인트로이미지)_768x634.jpg">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">쓰쓰챌린지</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 2 -->
		<div class="campaignCard-item">
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/9345/thumbnail/ShinsegyeInternational-Thumbnail.jpg">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">화장품 공병 수거 캠페인</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 3 -->
		<div class="campaignCard-item">
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/7855/thumbnail/L_Occitane-Thumbnail.jpg">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">Rethink Beauty 캠페인</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="campaignList ms-5 ml-5 mb-5" style="position: relative; display: flex;">
		<!-- 4 -->
		<div class="campaignCard-item">
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/7933/thumbnail/TBSKMainImage.jpg">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">플라스틱 공병수거 캠페인</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 5 -->
		<div class="campaignCard-item">
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/12566/thumbnail/yk_768X634.png">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">네이처메이드 쓰담쓰담 캠페인</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 6 -->
		<div class="campaignCard-item">
			<div class="campaign">
				<div class="campaignCard-wrapper">
					<div class="campaignCard-topLabel"></div>
					<div class="campaignCard-media"></div>
					<img class="collectionCard_img lazyload" data-sizes="auto"
						src="https://dva1blx501zrw.cloudfront.net/uploaded_images/kr/images/8490/thumbnail/CocaCola-Thumbnail.jpg">
					<div class="campaignCard-bottomLabel"></div>
					<div class="campaignCard-content">
						<div class="campaignCard-text">
							<h4 class="campaignCard-title">코카-콜라 원더플 캠페인</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End of campaignList -->
</div>
<!-- End of campaign-container -->

<%@ include file="../include/footer.jsp"%>