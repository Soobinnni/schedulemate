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
	var value = date.substring(0, 8);
	var divClass;
	var hasDate;
	var week = null;
	var days = fullDays(date);
	for (var i = 0, length = days.length; i < length; i += 7) {
		//전체 셀을 주단위로 잘라서 사용
		week = days.slice(i, i + 7);
		
		('__CLASS__', (hasDate)? 'class="has-date"': '')

		var $div = $('<div></div>');
		week.forEach(function(obj, index) {
			hasDate = !( ('0'+obj['date']).slice(-2) == '0'); //날짜를 가진 span인지.
			divClass = (index === 0) ? 'sun' : 'calandar_day';
			divClass = (index === 6) ? 'sat' : divClass;

			$div.append(div.replace('__REST__', divClass)
				.replace('__TODAY__', (obj['today']) ? 'today' : '')
				.replace('__VALUE__', 'value="' + value + ('0' + obj['date']).slice(-2) + '"')
				.replace('__CLASS__', (hasDate)? 'has-date': '')
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