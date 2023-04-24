<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- ajax 통신을 위한 meta tag -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title><tiles:getAsString name="title" /></title>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="/css/member-main-template.css">
<link rel="stylesheet" type="text/css" href="/css/mypage.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap"
	rel="stylesheet">
</head>
<body>
	<div id="app">
		<div class="common_wrap">
			<!-- header start -->
			<header class="common_header">
				<div class="header_util">
					<tiles:insertAttribute name="header" ignore="true" />
				</div>
				<!-- logo -->
				<div class="header_logo">
					<tiles:insertAttribute name="logo" ignore="true" />
				</div>
			</header>
			<!-- header end -->
			<!-- content start -->
			<main id="content" class="common_container page_main" role="main">
				<div class='content_inner'>
					<div id="mypage_container">
						<div class="mypage_content">
							<div class="mypage_nav">
								<ul>
									<li class="mypage-info">&nbsp;&nbsp;내 정보 수정</li>
									<li class="mypage-scheduleinfo">&nbsp;&nbsp;스케줄 <br>&nbsp;&nbsp;알림
										설정
									</li>
									<li class="mypage-registerUserId">&nbsp;&nbsp;알림 봇<br>&nbsp;&nbsp;아이디<br>&nbsp;&nbsp;입력/수정
									</li>
								</ul>
							</div>
							<div class="mypage_detail">
								<tiles:insertAttribute name="content-detail" ignore="true" />
							</div>
						</div>
					</div>
					<script>
						$(document)
								.ready(
										function() {
											// ajax 통신을 위한 csrf 설정
											var token = $("meta[name='_csrf']")
													.attr("content");
											var header = $(
													"meta[name='_csrf_header']")
													.attr("content");
											$(document).ajaxSend(
													function(e, xhr, options) {
														xhr.setRequestHeader(
																header, token);
													});
											$(".mypage-info")
													.on(
															"click",
															function() {
																window.location.href = "/member/mypage/info";
															});
											$(".mypage-scheduleinfo")
													.on(
															"click",
															function() {
																window.location.href = "/member/mypage/scheduleInfo";
															});
											$(".mypage-registerUserId")
											.on(
													"click",
													function() {
														window.location.href = "/member/mypage/registerBotUserId";
													});
										});
					</script>
				</div>
			</main>
		</div>
	</div>
</body>
</html>