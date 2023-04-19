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
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".login").on("click", function(){
			location.href = '/auth/login'
		});
		$(".join").on("click", function(){
			location.href = '/auth/joinform'
		});
	});
</script>
</head>
<body>
	[스케줄 메이트 홈 화면]
	스케줄을 추가하고,
	알림도 받아보세요!
	스케줄 메이트 함께하기
	<button type='button' class='login'>로그인</button>
	<button type='button' class='join'>회원가입</button>
</body>
</html>