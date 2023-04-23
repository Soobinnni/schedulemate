<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/auth.css">

<div id="login_container">
	<div class="login_content">
		<div class="login_box">
			<div class = 'login_box_first'>
				<div class='auth_content'>
					<div class='auth_text'><label for="username">아이디</label><br><br><label for="password">비밀번호</label></div>  
					<div class='auth_box'>
						<form action="/login" method="post" class="login_submit_form">
							<input type='text' name='username'
								id="username" placeholder="아이디"><br>
							<input type='password' name='password' id="password"
								placeholder="비밀번호">
							<sec:csrfInput />
						</form>	
					</div>		
				</div>
				<div class='submit_content'>
					<input class='login_submit' type="submit" value="Login">		
				</div>	
			</div>	
			<!-- 로그인 상태유지 체크박스 -->
			<div align="left" style="margin-top: 17px">
				<label for="login_status" style="position: static">로그인 상태유지</label>
				<input type="checkbox" name="remember-me"
					style="accent-color: #EB0000;" id="login_status" checked> <span
					style="display: inline-block; float: right; font-size: 1em"
					id="forgot"> <a href="/memberFindId">아이디 찾기</a> | <a
					href="/memberFindPassword">비밀번호 찾기</a>
				</span>
			</div>
			<c:if test="${ not empty error }">
				<div style="color: red; margin-top: 15px; margin-left: 5px"
					align="left">
					아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다. <br>입력하신 내용을 다시 확인해주세요.
				</div>
			</c:if>
		</div>
	</div>
</div>

<script>
	$(".login_submit").on("click", function(){
		$(".login_submit_form").submit();
	});
</script>