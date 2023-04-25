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
		<div class="mypage_userid_info_form_container">
			<form class='userid_form' action="/member/botUserIdRegiste" method="post">
				<input name="mbotUserId" type='text' class='mypage_userid_info_input'
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
									url : "/member/botUserIdChk",
									success : function(response) {
										if (response != 'null') { //등록 정보 있음
											var sdUserIdInput = $('input[name="sdUserId"]');
											if (sdUserIdInput.val() !== null) {
												var formContainer = $('.mypage_userid_info_detail');
												formContainer
														.find('.userid_form')
														.attr('action', '/member/mypage/modifyBotUserId')
														.attr('method', 'get');
												formContainer
														.find(
																'.mypage_userid_info_input')
														.removeClass('mypage_userid_info_input')
														.addClass('mypage_userid_info_modify_input')
														.attr('placeholder',
																'*************')
														.attr('readonly',
																'readonly');
												formContainer
														.find(
																'.mypage_userid_info_sub_btn')
														.removeClass('mypage_userid_info_sub_btn')
														.addClass('mypage_userid_info_modify_btn')
														.val('수정하기');
											}
										}
									}
								});
						//submit 전 검사
						$(".mypage_userid_info_sub_btn").on("click", function(){
							var inputData = $(".mypage_userid_info_input").val();
							if (inputData=='') {
								alert('내용을 입력해주세요!');
								return
							} else {
								$(".userid_form").submit();
							}
						});
						//수정 페이지로 이동
						$(".mypage_userid_info_modify_btn").on("click", function(){
							window.location.href = '/member/modifyBotUserId';
						});
					});
</script>