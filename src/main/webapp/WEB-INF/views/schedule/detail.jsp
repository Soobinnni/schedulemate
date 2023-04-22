<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/home.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">

<div class="schedule_calendar">
	<!-- 달력(내용) -->
	<div id="calendar_header" style='height: 80px;display:inline-block;margin-top:30px'>
		<div id="calendar_nav" style='display:inline-block;width:300px;float:left'>
				<span id="calendar_title" style='padding-left: 22px;'>${schedulelist[0].sdate}</span>
		</div>
		<div id='schedule_category' style='display:inline-block;float:right;padding-left: 0;padding-top: 10px;margin-right: 10px;'>
			<div class='schedule_category_content' style='margin-top:3px'>
				<img src="/images/important-checked.png" width="25px" style='display:inline-block'><span class='category'>중요 스케줄&nbsp;&nbsp;&nbsp;</span>
			</div>
			<div class='schedule_category_content'>
				<span class='red'>●</span><span class='category'>취미 &nbsp;</span>
			</div>
			<div class='schedule_category_content'>
				<span class='orange'>●</span><span class='category'>업무 &nbsp;</span>
			</div>
			<div class='schedule_category_content'>
				<span class='green'>●</span><span class='category'>약속 &nbsp;</span>
			</div>
			<div class='schedule_category_content'>
				<span class='blue'>●</span><span class='category'>기타</span>
			</div>
		</div>
	</div>
	<div id="calandar_content" style='min-height:500px;background:#ffffff'>
		<div class="calandar_week" style='border-style: none'>
			<div class='schedulelist_content'>
			<div class='new_schedule_content'>
					<form class="new_schedule_form" action="/schedule/schedulelist/register" method="post">
						<input type="hidden" name='sdate' value='${schedulelist[0].sdate }' />
						<input type="hidden" name='snum' value='${schedulelist[0].snum }' />
						<select name="slimportantschedule" class="new_schedule_important">
							<option value="1">중요 스케줄</option>
							<option value="0">선택안함</option>
						</select>
						<select name="slcategory" class="new_schedule_category">
							<option value="1">취미</option>
							<option value="2">업무</option>
							<option value="3">약속</option>
							<option value="4">기타</option>
						</select>
						<div class="new_schedule_time">
							<select name="slplannedTime" class="new_schedule_plannedTime">
									<optgroup label="오전">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</optgroup>
									<optgroup label="오후">
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
										<option value="24">24</option>
									</optgroup>
								</select>
							<select name="slplannedMin" class="new_schedule_plannedMin">
								<optgroup label="분">
									<option value="0">0</option>
									<option value="5">5</option>
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="25">25</option>
									<option value="30">30</option>
									<option value="35">35</option>
									<option value="40">40</option>
									<option value="45">45</option>
									<option value="50">50</option>
									<option value="55">55</option>
								</optgroup>
							</select>
						</div>
						<input name="slcontent" type='text' class="new_schedule_content_text" label='분'>
						<button type='button' class='new_schedule_btn'>+</button>
					</form>
				</div>
				<c:if test="${not empty schedulelist }">
					<c:forEach var="list" items="${schedulelist }">
						<div class='schedule' data-value='${list.slnum }'>
								<label for="slcategory"><input type='text' class='slcategory' name = 'slcategory' value="${list.slcategory }" style='margin-left:10px;' hidden><span class='slcategory_css' style='margin-left:10px;'>●</span></label>
								<c:choose>
									<c:when test="${ list.slplannedMin eq 0}">
										<input type='text' class='sltime' name = 'slplannedTime' value='${list.slplannedTime }시' readonly="readonly">
									</c:when>
									<c:otherwise>
										<input type='text' class='sltime' name = 'slplannedTime' value='${list.slplannedTime }시&nbsp;&nbsp;${list.slplannedMin }분' readonly="readonly">
									</c:otherwise>
								</c:choose>
								<input type='text' class='slcontent' name = 'slcontent' value='${list.slcontent }' readonly="readonly">
							<div class='schedule_change'>
								<span class='schedule_delete'><img width="24px" src="/images/schedule-delete.png"></span>
								<span class='schedule_modify'><img src="/images/schedule-modify.png"></span>
								<input class='slimportantschedule' type="checkbox" name='important_sch' value='${list.slimportantschedule }'/> 
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	$('.slcategory').each(function() { //카테고리 별로 css 색상 변경
		var value = $(this).val();
		var $slcategory_css = $(this).siblings('.slcategory_css');
		switch (value) {
			case '1':
				$slcategory_css.css('color', 'red');
				break;
			case '2':
				$slcategory_css.css('color', 'orange');
				break;
			case '3':
				$slcategory_css.css('color', 'green');
				break;
			case '4':
				$slcategory_css.css('color', 'blue');
				break;
			default:
				$slcategory_css.css('color', 'black');
				break;
		}
	});
	//스케줄 추가 btn 클릭 이벤트
	$('new_schedule_btn').on("click", function(){
		$('new_schedule_form').submit();
	});
	

	//중요 알림 추가 마우스 오버 이벤트 처리(팝업을 띄운다)
	$('.slimportantschedule').on('mouseover', function() {
		var content = '중요 스케줄로 추가합니다.'
		var $location = $(this);
		makeMouseOverPopup(content, $location);
	});
	//추가 알림 마우스 오버 이벤트 처리(팝업을 띄운다)
	$('.new_schedule_btn').on('mouseover', function() {
		var content = '스케줄을 추가합니다.'
		var $location = $(this);
		makeMouseOverPopup(content, $location);
	});
	//삭제 알림 마우스 오버 이벤트 처리(팝업을 띄운다)
	$('.schedule_delete').on('mouseover', function() {
		var content = '스케줄을 삭제합니다.'
		var $location = $(this);
		makeMouseOverPopup(content, $location);
	});
	//수정 알림 마우스 오버 이벤트 처리(팝업을 띄운다)
	$('.schedule_modify').on('mouseover', function() {
		var content = '스케줄을 수정합니다.'
		var $location = $(this);
		makeMouseOverPopup(content, $location);
	});
	
	//중요 알림 추가 마우스 아웃 이벤트 처리
	$('.slimportantschedule').on('mouseout', function() {
		$('.content-popup-container').remove(); //팝업 제거
	});
	//추가 알림 마우스 아웃 이벤트 처리
	$('.new_schedule_btn').on('mouseout', function() {
		$('.content-popup-container').remove(); //팝업 제거
	});
	//삭제 알림 마우스 아웃 이벤트 처리
	$('.schedule_delete').on('mouseout', function() {
		$('.content-popup-container').remove(); //팝업 제거
	});
	//수정 알림 마우스 아웃 이벤트 처리
	$('.schedule_modify').on('mouseout', function() {
		$('.content-popup-container').remove(); //팝업 제거
	});
});	

function makeMouseOverPopup(content, $location) {
	var $popupContainer = $('<div>').addClass('content-popup-container').text(content);

	$popupContainer.css({
		'position': 'absolute',
		'top': $location.offset().top + $location.height() + 'px',
		'left': $location.offset().left + 'px',
		'background': '#FFFFFF',
		'border': '1px solid #000000',
		'box-shadow': '0px 0px 10px rgba(0, 0, 0, 0.5)',
		'padding-right': '10px',
		'padding-left': '10px',
		'margin-left': '16px',
		'max-width': '500px',
		'z-index': 9999,
		'letter-spacing': '-1px'
	});

	// 팝업 컨테이너를 body 요소에 추가
	$('body').append($popupContainer);

	// 마우스가 팝업 바깥으로 나갈 때 팝업을 삭제
	$popupContainer.on('mouseleave', function() {
		$(this).remove();
	});
}
</script>