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
<link rel="stylesheet" type="text/css" href="/css/member-main-template.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
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
					<tiles:insertAttribute name="content" ignore="true" />
				</div>	
			</main>
		</div>
	</div>
</body>
</html>