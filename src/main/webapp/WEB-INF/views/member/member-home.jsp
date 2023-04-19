<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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