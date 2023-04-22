<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/home.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">

<div class="schedule_calendar">
	<!-- 달력(내용) -->
	<div id="calendar_header" style='height: 130px;'>
		<div id="calendar_nav">
			<div class='calendar_nav_grop'>
				<span id="calendar_title" style='padding-left: 62px;'>${schedulelist[0].sdate}</span>
			</div>
		</div>
		<div id='schedule_category' style=''>
			<div class='schedule_category_content'>
				<span class='red'>●</span><span class='category'>취미 </span>
			</div>
			<div class='schedule_category_content'>
				<span class='orange'>●</span><span class='category'>업무 </span>
			</div>
			<div class='schedule_category_content'>
				<span class='green'>●</span><span class='category'>약속 </span>
			</div>
			<div class='schedule_category_content'>
				<span class='blue'>●</span><span class='category'>기타</span>
			</div>
		</div>
	</div>
	<div id="calandar_content" style='min-height:500px;background:#ffffff'>
		<div class="calandar_week" style='border-style: none'>
			<div class='schedulelist_content'>
				<c:if test="${not empty schedulelist }">
					<c:forEach var="list" items="${schedulelist }">
						<div class='schedule' data-value='${list.slnum }'>
							<input class='slimportantschedule' type="checkbox" name='important_sch' value='${list.slimportantschedule }'/> 
							<div class='slcategory' data-value="${list.slcategory }">●</div>
							<div class='sltime'>${list.slplannedTime }시 ${list.slplannedMin }분</div>
							<div class='slcontent'>${list.slcontent }</div>
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
		    var value = $(this).data('value');
		    switch (value) {
			case 1:
			      $(this).css('color', 'red');
				break;
			case 2:
			      $(this).css('color', 'orange');
				break;
			case 3:
				$(this).css('color', 'green');
				break;
			case 4:
				$(this).css('color', 'blue');
				break;
			default:
				$(this).css('color', 'black');
				break;
			}
		  });

		//스케줄이 있는 날 마우스 오버 이벤트 처리(팝업을 띄운다)
		$('.slimportantschedule').on('mouseover', function() {
			var content = '중요 스케줄로 추가합니다.'
			var $popupContainer = $('<div>').addClass('content-popup-container').text(content);

			$popupContainer.css({
				'position': 'absolute',
				'top': $(this).offset().top + $(this).height() + 'px',
				'left': $(this).offset().left + 'px',
				'background': '#FFFFFF',
				'border': '1px solid #000000',
				'box-shadow': '0px 0px 10px rgba(0, 0, 0, 0.5)',
				'padding-right': '10px',
				'padding-left': '10px',
				'margin-left': '16px',
				'max-width': '500px',
				'z-index': 9999,
				'letter-spacing' : '-1px'
			});

			// 팝업 컨테이너를 body 요소에 추가
			$('body').append($popupContainer);
		});

		//스케줄이 있는 날 마우스 아웃 이벤트 처리
		$('.slimportantschedule').on('mouseout', function() {
			$('.content-popup-container').remove(); //팝업 제거
		});
});
</script>