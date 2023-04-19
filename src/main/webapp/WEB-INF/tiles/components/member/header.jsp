<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"% -->

<!-- 로그인을 하지 않은 경우 
<sec:authorize access="isAnonymous()">
</sec:authorize>-->
<!-- 로그인을 한(인증된 사용자인) 경우
<sec:authorize access="isAuthenticated()">
</sec:authorize> -->
<div class='header_content'>
	<div class='login'>로그인</div>
	<div class='join'>회원가입</div>
</div>
<!-- 
<div class='header_content'>
	<div class='logout'>로그아웃</div>
	<div class='mypage'>마이페이지</div>
</div>	 -->