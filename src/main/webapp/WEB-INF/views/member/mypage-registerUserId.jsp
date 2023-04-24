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
		<div class="mypage_userid_info_form_container">
			<form action="">
				<input name="sdUserId" type='text' class='mypage_userid_info_input'
					placeholder="userId를 입력해주세요"> <input
					class='mypage_userid_info_sub_btn' type="submit" value='입력' />
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
						//userId 입력 정보가 있는 지 확인
						$
								.ajax({
									type : "post",
									url : "/send/sendUserIdChk",
									success : function(response) {
										if (response != 'null') { //등록 정보 있음
											var sdUserIdInput = $('input[name="sdUserId"]');
											if (sdUserIdInput.val() !== null) {
												var formContainer = $('.mypage_userid_info_detail');
												formContainer
														.find(
																'.mypage_userid_input_form')
														.removeClass(
																'mypage_userid_input_form')
														.addClass(
																'mypage_userid_modify_form')
														.find(
																'.mypage_userid_info_input')
														.attr('placeholder',
																'*************');
												formContainer
														.find(
																'.mypage_userid_info_sub_btn')
														.removeClass(
																'mypage_userid_info_sub_btn')
														.addClass(
																'mypage_userid_info_modify_bt')
														.val('수정하기');
											}
										}
									}
								});
					});
</script>