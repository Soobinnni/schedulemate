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
	<hr style='width:800px'>
	<div class='mypage_userid_info_detail'>
		<div class="mypage_userid_info_form_container" style='width:500px;'>
			<form class='userid_form'>
				<input name="mbotUserId" type='text' style='width:300px'
					class='mypage_userid_info_input' placeholder="userId를 입력해주세요">
				<input class='modify_success_btn' type="button" value='수정완료' />
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
								console.log(inputData);
								chkDuplicateBotUserId(inputData); 
							}
						});
					});
	function chkDuplicateBotUserId(inputData){
		$.ajax({
			type: "post",
			url: "/member/chkDuplicateBotUserId",
			data: JSON.stringify({
				"mbotUserId" : inputData.toString()
			}),
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				console.log(response);
				if (response=='duplicate') {
					alert('이미 등록된 아이디입니다.\n다른 아이디를 입력해주세요!');
				} else {
					var userIdForm = $(".userid_form");
					userIdForm.attr("action", "/member/botUserIdRegiste");
					userIdForm.attr("method", "post");
					userIdForm.submit();
					alert('수정이 완료됐습니다!');
				}
			}
		}); 
	}
</script>