<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- ajax 통신을 위한 meta tag -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta charset="UTF-8">
<title>스케줄 메이트</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/welcome.css">

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {		
		// ajax 통신을 위한 csrf 설정
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr(
			"content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
		$(".login").on("click", function() {
			location.href = '/auth/login'
		});
		$(".join").on("click", function() {
			location.href = '/join'
		});
	});
</script>
</head>
<body>
	<div id='welcome_container'>
		<div class='welcome_content'>
			<div class='welcome_main'>
				<div class='welcome_logo'>
					<span style='color: white'>Schedule</span> <span style='color: red'>M</span><span
						style='color: orange'>a</span><span style='color: green'>t</span><span
						style='color: blue'>e</span>
				</div>
				<div class='welcome_info'>
					스케줄을 추가하고, 알림도 받아보세요! <br>스케줄 메이트 함께하기
					<br>
					<div class='login_join_btn'>
						<button type='button' class='login'><b>로그인</b></button>
						<button type='button' class='join'><b>회원가입</b></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>