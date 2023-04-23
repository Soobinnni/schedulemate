<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/home.css">

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
		</div>
	</div>
</div>
<script>
//달력 동적 생성 start
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
//달력 동적 생성 end

//페이지 준비 start
$(document).ready(function() {		
	// ajax 통신을 위한 csrf 설정
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr(
		"content");
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
	var sdate = ${ sdate }; //현 날짜(yyyy.mm)
	//페이지가 준비되면, schedule에 따른 schedulelist를 ajax로 불러옴
	readScheduleAjax(sdate);

	//스케줄 날짜 일 클릭 이벤트(스케줄 입력 폼으로 이동)
	$(document).on('click', '.has-date', function() {
		var sdate = $(this).find('span[name="schedule-date"]').attr('value'); //클릭한 날 날짜 정보
		window.location.href = '/schedule/detail?sdate=' + sdate;
	});


	//스케줄이 있는 날 마우스 오버 이벤트 처리(팝업을 띄운다)
	$(document).on('mouseenter', '.has-schedulelist', function() {
		var hiddenInput = $(this).find('input[type="hidden"]');
		var scheduleList = JSON.parse(hiddenInput.val());
		var $popupContainer = $('<div>').addClass('schedule-popup-container');
		var $popupList = $('<ul>').addClass('schedule-popup-list');

		// scheduleList를 이용하여 처리(마우스오버 팝업 생성)
		$.each(scheduleList, function(index, schedule) {
			var slcategory = schedule.slcategory;
			var schedulecontent = schedule.schedulecontent;

			// 팝업에 append할 내용 추가
			var $categorySpan = $('<span>').html('●');
			categoryColorDecision(slcategory, $categorySpan); //●색상 결정
			var $contentSpan = $('<span>').html(schedulecontent);
			var $popupListItem = $('<li>').addClass('schedule-popup-item');

			$popupListItem.append($categorySpan);
			$popupListItem.append($contentSpan);
			$popupList.append($popupListItem);
		});

		// 팝업 css 설정
		$popupContainer.append($popupList);
		$popupList.css({
			'list-style': 'none',
			'padding-left': '15px'
		});
		$popupContainer.css({
			'position': 'absolute',
			'top': $(this).offset().top + $(this).height() + 'px',
			'left': $(this).offset().left + 'px',
			'background': '#FFFFFF',
			'border': '1px solid #000000',
			'box-shadow': '0px 0px 10px rgba(0, 0, 0, 0.5)',
			'padding-right': '15px',
			'max-width': '500px',
			'z-index': 9999
		});

		// 팝업 컨테이너를 body 요소에 추가
		$('body').append($popupContainer);
	});

	//스케줄이 있는 날 마우스 아웃 이벤트 처리
	$(document).on('mouseleave', '.has-schedulelist', function() {
		$('.schedule-popup-container').remove(); //팝업 제거
	});
});
//페이지 준비 end

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
		url: "/schedule/schedulelist",
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
			var $div_schedulelist = $('<div class="has-schedulelist" style="width:90%">');
			var $span = $('<span>');
			var scheduleJSON = {}; // 스케줄 정보를 저장할 배열
			// 각 스케줄에 대해서 처리
			$.each(scheduleList, function(index, schedule) {
				var slcategory = schedule.slcategory; // 스케줄 타이틀
				var slcontent = schedule.slcontent; // 스케줄 내용
				var plannedTime = schedule.slplannedTime; // 예정된 시간, 분
				var plannedMin = schedule.slplannedMin;

				// 스케줄 정보 JSON저장
				scheduleJSON[index] = {
					"slcategory": slcategory,
					"schedulecontent": ' ' + plannedTime + '시 ' + plannedMin + '분 ' + slcontent
				};

				// 카테고리 캘린더에 추가
				var $item = $('<span>').html('●');
				categoryColorDecision(slcategory, $item);
				$span.append($item);
			});
			// 스케줄 정보를 담은 배열을 JSON 문자열로 변환하여 hidden 태그 추가
			var $hidden_schedulelist = $('<input>').attr('type', 'hidden').attr('name', 'schedulelist').val(JSON.stringify(scheduleJSON));
			$div_schedulelist.append($hidden_schedulelist);

			// 스케줄 정보를 담은 $span을 .has-date div 요소에 추가
			$div_schedulelist.append($span);
			$(this).append($div_schedulelist);
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