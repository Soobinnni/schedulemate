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
				<span id="calendar_title">2023.01</span>
				<button type="button" class="month-move" id="calendar_nav_btn_next"
					data-ym="">▶</button>
			</div>
		</div>
		<div id='schedule_category'>
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

	var div = '<div class="__REST__ __CLASS__ __TODAY__"><span style="display:block" name="schedule-date" __VALUE__>__DATE__</span></div>';
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

		//새로운 달을 그림.
		drawMonth($(this).data('ym'));
		//새로운 스케줄을 가져옴
		var sdate = $('#calendar_title').text();
		readScheduleAjax(sdate);
	});
});


$(document).ready(function() {
	var sdate = ${ sdate }; //현 날짜(yyyy.mm)
	//페이지가 준비되면, schedule에 따른 schedulelist를 불러옴
	readScheduleAjax(sdate);
});


//schedulelist를 불러오는 ajax
function readScheduleAjax(sdate) {
	var mnum = ${ mnum }; //회원번호
	var schedulelistObj = {
		"mnum": mnum,
		"sdate": sdate
	};
	var schedulelistStr = JSON.stringify(schedulelistObj);
	$.ajax({
		type: "post",
		url: "/schedulelist/",
		data: schedulelistStr,
		contentType: "application/json; charset=utf-8",
		success: function(response) {
			addSchedulelist(response);
		}
	});
}

//schedulelist를 schedule의 요소로 추가
function addSchedulelist(response) {
	$('.has-date').each(function() {
		// 캘린더와 일치하는 스케줄 날짜 값 찾기
		var date = $(this).find('span[name=schedule-date]').attr('value');
		// 스케줄 목록이 있는 경우
		if (response[date]) {
			var scheduleList = response[date]; //List<SchedulelistVO>
			// 스케줄 목록을 추가할 요소
			var $span = $('<span>');
			// 각 스케줄에 대해서 처리
			$.each(scheduleList, function(index, schedule) {
				var slcategory = schedule.slcategory;// 스케줄 타이틀
				var slcontent = schedule.slcontent;// 스케줄 내용
				var plannedTime = schedule.slplannedTime;// 예정된 시간, 분
				var plannedMin = schedule.slplannedMin;

				var schedule = plannedTime + '시 ' + plannedMin + '분 ' + slcontent;
				if (plannedMin == 0) {
					schedule = plannedTime + '시 ' + slcontent;
				}
				// 카테고리 캘린더에 추가
				var $item = $('<span>').html('●');
				categoryColorDecision(slcategory, $item);
				$span.append($item);

				// 스케줄 프로퍼티를 hidden 태그 추가
				var $hidden_slcategory = $('<input>').attr('type', 'hidden').val(slcategory);
				var $hidden_schedule = $('<input>').attr('type', 'hidden').val(schedule);
				$item.append($hidden_slcategory).append($hidden_schedule);
			});
			// 스케줄 정보를 담은 $span을 .has-date div 요소에 추가
			$(this).append($span);
		}
	});
}
function categoryColorDecision(slcategory, $item) { //카테고리 숫자, 추가 요소
	// 조건에 따라 스타일을 지정
	switch (slcategory) {
		case 1:
			$item.css('color', 'red');
			break;
		case 2:
			$item.css('color', 'orange');
			break;
		case 3:
			$item.css('color', 'green');
			break;
		case 4:
			$item.css('color', 'blue');
			break;
		default:
			$item.css('color', 'black');
	}
}
</script>