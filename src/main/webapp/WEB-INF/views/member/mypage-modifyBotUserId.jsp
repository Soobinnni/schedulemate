<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="nbspnarrow"
	value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
<c:set var="nbspwide" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
<!--<sec:csrfInput />-->
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="/css/mypage-registerUserId.css">

<div class="mypage_userid_info_container">
	<div class='mypage_userid_info_title'>
		<h2>
			<i>알림 봇 아이디 입력 / 수정</i>
		</h2>
	</div>
	<hr>
	<div class='mypage_userid_info_detail'>
		<div class="mypage_userid_info_form_container" style='width:500px;'>
			<form class='userid_form' action="/member/botUserIdRegiste"
				method="post">
				<input name="mbotUserId" type='text' style='width:300px'
					class='mypage_userid_info_input' placeholder="userId를 입력해주세요">
				<input class='modify_success_btn' type="submit" value='수정완료' />
				<button class='modify_cancel_btn' type='button'>수정취소</button>
				<sec:csrfInput />
			</form>
		</div>
	</div>
</div>
<script>
	$(document)
			.ready(
					function() {
						// ajax 통신을 위한 csrf 설정
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr(
								"content");
						$(document).ajaxSend(function(e, xhr, options) {
							xhr.setRequestHeader(header, token);
						});
						//modify 취소
						$(".modify_cancel_btn").on("click", function(){
							window.location.href = "/member/mypage/registerBotUserId";
						});
						//submit 전 검사
						$(".modify_success_btn").on("click", function(){
							var inputData = $(".mypage_userid_info_input").val();
							if (inputData=='') {
								alert('내용을 입력해주세요!');
								return
							} else {
								$(".userid_form").submit();
							}
						});
					});
</script>