<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!-- js -->
<script src="/js/member-schedule.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/member-schedule.css">

<!-- content_memberhome -->
<!-- 날짜선택 -->
<div class="schedule_calendar">
	<!-- 달력(내용) -->
	<div id="calendar_header">
		<div id="calendar_nav">
			<div class='calendar_nav_grop'>
				<button type="button" class="month-move" id="calendar_nav_btn_prev"
					data-ym="">◀</button>
				<strong id="calendar_title">2023.01</strong>
				<button type="button" class="month-move" id="calendar_nav_btn_next"
					data-ym="">▶</button>
			</div>
		</div>
		<div id='schedule_category'>
			<div class='schedule_category_content'><span class='red'>●</span><span class='category'>취미　</span></div>
			<div class='schedule_category_content'><span class='orange'>●</span><span class='category'>업무　</span></div>
			<div class='schedule_category_content'><span class='green'>●</span><span class='category'>약속　</span></div>
			<div class='schedule_category_content'><span class='blue'>●</span><span class='category'>기타</span></div>
		</div>
		<div class="day_names">
			<div class='day_names_content'>
				<div class="day_name" id='sun' align='center'>SUN</div>
				<div class="day_name" align='center'>MON</div>
				<div class="day_name" align='center'>TUE</div>
				<div class="day_name" align='center'>WEB</div>
				<div class="day_name" align='center'>THU</div>
				<div class="day_name" align='center'>FRI</div>
				<div class="day_name" id='sat' align='center'>SAT</div>
			</div>	
		</div>
	</div>
	<div id="calandar_content">
		<div class="calandar_week">
			<!-- 							<div class="sun">1</div>
							<div class="calandar_day">2</div>
							<div class="calandar_day">3</div>
							<div class="calandar_day">4</div>
							<div class="calandar_day">5</div>
							<div class="calandar_day">6</div>
							<div class="sat">7</div> -->
		</div>
		<!-- 행 반복 -->
		<div class="calandar_week">
			<!-- 							<div class="sun">29</div>
							<div class="calandar_day">30</div>
							<div class="calandar_day"></div>
							<div class="calandar_day"></div>
							<div class="calandar_day"></div>
							<div class="calandar_day"></div>
							<div class="sat"></div> -->
		</div>
	</div>
</div>
<script>
function prevMonth(date) {
	var target = new Date(date);
	target.setDate(1);
	target.setMonth(target.getMonth() - 1);

	return getYmd(target);
}

function nextMonth(date) {
	var target = new Date(date);
	target.setDate(1);
	target.setMonth(target.getMonth() + 1);

	return getYmd(target);
}

function getYmd(target) {
	// IE에서 날짜 문자열에 0이 없으면 인식 못함
	var month = ('0' + (target.getMonth() + 1)).slice(-2);
	return [target.getFullYear(), month, '01'].join('-');
}

function fullDays(date) {
	var target = new Date(date);
	var year = target.getFullYear();
	var month = target.getMonth();

	var firstWeekDay = new Date(year, month, 1).getDay();
	var thisDays = new Date(year, month + 1, 0).getDate();

	// 월 표시 달력이 가지는 셀 갯수는 3가지 가운데 하나이다.
	// var cell = [28, 35, 42].filter(n => n >= (firstWeekDay + thisDays)).shift();
	var cell = [28, 35, 42].filter(function(n) {
		return n >= (firstWeekDay + thisDays);
	}).shift();

	// 셀 초기화, IE에서 Array.fill()을 지원하지 않아서 변경
	// var days = new Array(cell).fill({date: '', dayNum: '', today: false});
	var days = []
	for (var i = 0; i < cell; i++) {
		days[i] = {
			date: '',
			dayNum: '',
			today: false
		};
	}

	var now = new Date();
	var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
	var inDate;
	for (var index = firstWeekDay, i = 1; i <= thisDays; index++, i++) {
		inDate = new Date(year, month, i);
		days[index] = {
			date: i,
			dayNum: inDate.getDay(),
			today: (inDate.getTime() === today.getTime())
		};
	}

	return days;
}
function drawMonth(date) {
	$('#calendar_title').text(date.substring(0, 7).replace('-', '.'));
	$('#calendar_nav_btn_prev').data('ym', prevMonth(date));
	$('#calendar_nav_btn_next').data('ym', nextMonth(date));

	$('#calandar_content').empty();

	var div = '<div class="__REST__ __CLASS__ __TODAY__"><span name="schedule-date" __VALUE__>__DATE__</span></div>';
	var value = date.substring(0, 8).replace('-', '.').replace('-', '.');
	var divClass;
	var hasDate;
	var week = null;
	var days = fullDays(date);
	for (var i = 0, length = days.length; i < length; i += 7) {
		//전체 셀을 주단위로 잘라서 사용
		week = days.slice(i, i + 7);

		('__CLASS__', (hasDate) ? 'class="has-date"' : '')

		var $div = $('<div></div>');
		week.forEach(function(obj, index) {
			hasDate = !(('0' + obj['date']).slice(-2) == '0'); //날짜를 가진 span인지.
			divClass = (index === 0) ? 'sun' : 'calandar_day';
			divClass = (index === 6) ? 'sat' : divClass;

			$div.append(div.replace('__REST__', divClass)
				.replace('__TODAY__', (obj['today']) ? 'today' : '')
				.replace('__VALUE__', 'value="' + value + ('0' + obj['date']).slice(-2) + '"')
				.replace('__CLASS__', (hasDate) ? 'has-date' : '')
				.replace('__DATE__', obj['date']));
		});
		$('#calandar_content').append($div);
	}
}

$(function() {
	var date = (new Date()).toISOString().substring(0, 10);
	drawMonth(date);

	$('.month-move').on('click', function(e) {
		e.preventDefault();

		drawMonth($(this).data('ym'));
	});
});
$(document).ready(function() {
	var mnum = ${mnum};
	var sdate = ${sdate};
	console.log(sdate);
	var schedulelistObj = {
			"mnum" : mnum,
			"sdate" : sdate
	};
	var schedulelistStr = JSON.stringify(schedulelistObj);
	$.ajax({
		type: "post",
		url: "/schedulelist/",
		data: schedulelistStr,
		contentType: "application/json; charset=utf-8",
		success: function(result) {
			$.each(result, function(key, value){
				  console.log(result[key]);
				});
			}
		});
});
</script>