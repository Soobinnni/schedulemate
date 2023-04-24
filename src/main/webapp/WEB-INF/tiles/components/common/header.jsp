<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class='header_content'>
<!-- 로그인을 한(인증된 사용자인) 경우-->
<sec:authorize access="isAuthenticated()"> 
	<div class='logout'><a href="#" onclick="document.getElementById('logout').submit();" style='text-decoration: none;color:white;'>로그아웃</a></div>
	<div class='mypage'><a href='/member/mypage/info' style='text-decoration: none;color:white;'>마이페이지</a></div>
</sec:authorize>

<!-- 로그인을 하지 않은 경우 -->
<sec:authorize access="isAnonymous()">
	<div class='login'><a href='/auth/login' style='text-decoration: none;color:white;'>로그인</a></div>
	<div class='join'><a href='/join' style='text-decoration: none;color:white;'>회원가입</a></div>
</sec:authorize>
</div>	
<form id="logout" action="/logout" method="POST">
	<sec:csrfInput />
</form>