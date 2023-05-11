<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="nbspnarrow" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>	
<c:set var="nbspwide" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>	
<!--<sec:csrfInput />-->
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="/css/mypage-scheduleinfo.css">

<div class="mypage_schedule_info_container">
	<div class='mypage_schedule_info_title'>
		<h2>
			<i>스케줄 알림 설정</i>
		</h2>
	</div>
	<hr style='width:800px'>
	<div class='mypage_schedule_info_detail'>
		<div class='send-daily-schedule'>
			<div class='send-weekly-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }데일리 스케줄 알림 받기</span>
				<div class='slider-box'>
					<label class="switch"> 
					<c:choose>
						<c:when test="${member.mdaily eq 1}">
							<input class='mdaily_btn' type="checkbox" name='mdaily'
							value='1' checked>
						</c:when>
						<c:otherwise>
							<input class='mdaily_btn' type="checkbox" name='mdaily'
							value='1'>
						</c:otherwise>	
					</c:choose>					
						<div class="slider round"></div>
				</div>	
			</div>
		</div>
		<div class='send-weekly-schedule'>
			<div class='send-weekly-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }매주 스케줄 알림 받기</span>
				<div class='slider-box'>
			<label class="switch">
					<c:choose>
						<c:when test="${member.mweekly eq 1}">
							<input class='mweekly_btn' type="checkbox" name='mweekly_btn'
							value='1' checked>
						</c:when>
						<c:otherwise>
							<input class='mweekly_btn' type="checkbox" name='mweekly_btn'
							value='1'>
						</c:otherwise>	
					</c:choose>	 
					<div class="slider round"></div>
				</div>	
			</div>
		</div>
		<div class='send-important-monthly-schedule'>
			<div class='send-important-monthly-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }매달 스케줄 중요 알림 받기</span>
				<div class='slider-box'>
			<label class="switch"> 
					<c:choose>
						<c:when test="${member.mimportantmonth eq 1}">
							<input class='mimportantmonth_btn' type="checkbox" name='mimportantmonth'
							value='1' checked>
						</c:when>
						<c:otherwise>
							<input class='mimportantmonth_btn' type="checkbox" name='mimportantmonth'
							value='1'>
						</c:otherwise>	
					</c:choose>	
				<div class="slider round"></div>
				</div>	
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	// ajax 통신을 위한 csrf 설정
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr(
		"content");
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
	//데일리 알림 체크 / 언체크 이벤트
	$(".mdaily_btn").change(function(event) {
		var $selector = $(".mdaily_btn");
		var url = "Mdaily";
		var type = "mdaily";
		ChkUserIDIsSaved($selector, url, type);//유저 아이디 입력돼 있는지 확인
	});
	//매주 알림 체크 / 언체크 이벤트
	$(".mweekly_btn").change(function(event) {
		var $selector = $(".mweekly_btn");
		var url = "Mweekly";
		var type = "mweekly";
		ChkUserIDIsSaved($selector, url, type);//유저 아이디 입력돼 있는지 확인
	});
	//매달 중요 알림 체크 / 언체크 이벤트
	$(".mimportantmonth_btn").change(function(event) {
		var $selector = $(".mimportantmonth_btn");
		var url = "Mimportantmonth";
		var type = "mimportantmonth";
		ChkUserIDIsSaved($selector, url, type);//유저 아이디 입력돼 있는지 확인
	});
	
	function ChkUserIDIsSaved($selector, url, type){
		//userid가 입력되어 있는 지 조회.
		$.ajax({
			type: "post",
			url: "/member/botUserIdChk",
			success: function(response) {
				if(response == 'null'){ //등록한 적 없음 - 등록 페이지로 이동
					alert('먼저 봇 유저아이디를 입력해야합니다!');
					window.location.href = '/member/mypage/registerBotUserId'
					return;
				} else { //등록 전적이 있으면, 업데이트 가능.
					var sendData = getAlarmData($selector, url, type);
					mAlertStatusUpdate(sendData[0], sendData[1])
				}
			}
		});
	}
	function getAlarmData($selector, url, type){
		var url = "/member/mypage/update"+url+"Status";
		var value;
		if ($selector.is(":checked")) { //체크 이벤트
			value = 1;
		} else { //언체크 이벤트
			value = 0;
		};
		var scheduleJSON = {};
		scheduleJSON[type] = value;
		var sendData = [url,scheduleJSON ];
		return sendData;
	}

	function mAlertStatusUpdate(url, data) {
		$.ajax({
			url: url,
			type: "post",
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				alert('스케줄 알림 \n상태를 변경했습니다!');
			}
		});
	}
});
</script>