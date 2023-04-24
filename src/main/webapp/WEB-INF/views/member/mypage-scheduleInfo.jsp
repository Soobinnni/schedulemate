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
	<hr>
	<div class='mypage_schedule_info_detail'>
		<div class='send-weekend-schedule'>
			<div class='send-weekend-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }데일리 스케줄 알림 받기</span>
				<div class='slider-box'>
					<label class="switch"> <input type="checkbox" name='mweekend'
						value='1'>
						<div class="slider round"></div>
				</div>	
			</div>
		</div>
		<div class='send-daily-schedule'>
			<div class='send-daily-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }매주 스케줄 알림 받기</span>
				<div class='slider-box'>
			<label class="switch"> <input type="checkbox" name='mdaily'
				value='1'>
				<div class="slider round"></div>
				</div>	
			</div>
		</div>
		<div class='send-important-monthly-schedule'>
			<div class='send-important-monthly-schedule-div'>
				${nbspwide }<img class='alert-img' alt="" src="/images/alert.png">
				<span>${nbspnarrow }매달 스케줄 중요 알림 받기</span>
				<div class='slider-box'>
			<label class="switch"> <input type="checkbox"
				name='mimportantmonth' value='1'>
				<div class="slider round"></div>
				</div>	
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
	});
</script>