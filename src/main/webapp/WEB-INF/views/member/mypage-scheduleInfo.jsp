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
			<div class='send-weekend-schedule-div'>
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
		<div class='send-weekend-schedule'>
			<div class='send-weekend-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }매주 스케줄 알림 받기</span>
				<div class='slider-box'>
			<label class="switch">
					<c:choose>
						<c:when test="${member.mweekend eq 1}">
							<input class='mweekend_btn' type="checkbox" name='mweekend_btn'
							value='1' checked>
						</c:when>
						<c:otherwise>
							<input class='mweekend_btn' type="checkbox" name='mweekend_btn'
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
	$(".mdaily_btn").change(function() {
		var url = "Mdaily";
		var value;
		if ($(this).is(":checked")) { //체크 이벤트
			value = 1;
		} else { //언체크 이벤트
			value = 0;
		};
		var scheduleJSON = {
			"mdaily": value
		};
		mAlertStatusUpdate(url, scheduleJSON);
	});
	//매주 알림 체크 / 언체크 이벤트
	$(".mweekend_btn").change(function() {
		var url = "Mweekend";
		var value;
		if ($(this).is(":checked")) { //체크 이벤트
			value = 1;
		} else { //언체크 이벤트
			value = 0;
		};
		var scheduleJSON = {
			"mweekend": value
		};
		mAlertStatusUpdate(url, scheduleJSON);
	});
	//매달 중요 알림 체크 / 언체크 이벤트
	$(".mimportantmonth_btn").change(function() {
		var url = "Mimportantmonth";
		var value;
		if ($(this).is(":checked")) { //체크 이벤트
			value = 1;
		} else { //언체크 이벤트
			value = 0;
		};
		var scheduleJSON = {
			"mimportantmonth": value
		};
		mAlertStatusUpdate(url, scheduleJSON);
	});

	function mAlertStatusUpdate(url, data) {
		console.log(data);
		$.ajax({
			url: "/member/mypage/update"+url+"Status",
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