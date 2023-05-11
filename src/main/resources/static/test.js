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
			$(".modify_cancel_btn").on("click", function() {
				window.location.href = "/member/mypage/registerBotUserId";
			});
			//submit 전 검사
			$(".modify_success_btn").on("click", function() {
				var inputData = $(".mypage_userid_info_input").val();
				if (inputData == '') {
					alert('내용을 입력해주세요!');
					return
				} else {
					console.log('중복검사 실시 : ' + inputData);
					chkDuplicateBotUserId(inputData);
				}
			});
		});
// 중복 검사
function chkDuplicateBotUserId(inputData) {
	console.log('중복검사 에이젝스 : ' + inputData);
	$
		.ajax({
			type: "post",
			url: "/member/chkDuplicateBotUserId",
			data: JSON.stringify({
				"mbotUserId": inputData
			}),
			success: function(response) {
				console.log(response);
				if (response == 'duplicate') {
					console.log('중복');
					alert('이미 등록된 챗 아이디입니다!\n다른 아이디를 입력해주세요.');
				} else {
					console.log('가능');
					$(".userid_form").submit();
				}
			}
		});
}