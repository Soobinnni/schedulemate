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
				<span id="calendar_title" style='padding-left: 22px;'>${sdate}</span>
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
							<c:choose>
								<c:when test="${empty schedulelist }">
									<input type="hidden" name='snum' value="0" />
								</c:when>
								<c:otherwise>
									<input type="hidden" name='snum' value='${schedulelist[0].snum}' />
								</c:otherwise>
							</c:choose>
						<input type="hidden" name='sdate' value='${sdate }' />
						<select name="slimportantschedule" class="new_schedule_important">
							<option value="0">선택안함</option>
							<option value="1">중요 스케줄</option>
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
										<c:forEach begin="1" step="1" end="12" var="i">
											<option value="${i}">${i}</option>
										</c:forEach>
									</optgroup>
									<optgroup label="오후">
										<c:forEach begin="13" step="1" end="24" var="i">
											<option value="${i}">${i}</option>
										</c:forEach>
									</optgroup>
								</select>
							<select name="slplannedMin" class="new_schedule_plannedMin">
								<optgroup label="분">
										<c:forEach begin="0" step="5" end="55" var="i">
											<option value="${i}">${i}</option>
										</c:forEach>
								</optgroup>
							</select>
						</div>
						<input name="slcontent" type='text' class="new_schedule_content_text">
						<button type='button' class='new_schedule_btn'>+</button>
					</form>
				</div>
				<c:if test="${not empty schedulelist }">
					<c:forEach var="list" items="${schedulelist }">
						<div class='schedule'>
								<label for="slcategory"><input type='text' class='slcategory' name = 'slcategory' value="${list.slcategory }" style='margin-left:10px;' hidden><span class='slcategory_css' style='margin-left:10px;'>●</span></label>
								<div class='sltime'>
									<c:choose>
										<c:when test="${ list.slplannedMin eq 0}">
											<label for="slplannedTime"><input type='text' name = 'slplannedTime' value="${list.slplannedTime }" hidden><span class=''>${list.slplannedTime }시</span></label>
										</c:when>
										<c:otherwise>
											<label for="slplannedTime"><input type='text'  class='slplannedTime' name = 'slplannedTime' value="${list.slplannedTime }" hidden><span>${list.slplannedTime }시</span></label>
											<label for="slplannedMin"><input type='text'  class='slplannedMin' name = 'slplannedMin' value="${list.slplannedMin }" hidden><span>${list.slplannedMin }분</span></label>							
										</c:otherwise>
									</c:choose>
								</div>	
								<input type='text' class='slcontent' name = 'slcontent' value='${list.slcontent }' readonly="readonly">
							<div class='schedule_change'>
								<span class='schedule_modify' data-value='${list.slnum }'><img src="/images/schedule-modify.png"></span>
								<span class='schedule_delete' data-value='${list.slnum }'><img width="24px" src="/images/schedule-delete.png"></span>							
								<c:choose>
									<c:when test="${ list.slimportantschedule eq 0}">
										<input class='slimportantschedule' type="checkbox" name='important_sch' value='${list.slimportantschedule }'/> 
									</c:when>
									<c:otherwise>
										<input class='slimportantschedule' type="checkbox" name='important_sch' value='${list.slimportantschedule }' checked/> 
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class='schedule_modify_div'>
							<form class = 'schedule_modify_form' action="/schedule/schedulelist/modify" method="post">
								<input type="hidden" name='slnum' value='${list.slnum }'/>
								<input type="hidden" name='sdate' value='${list.sdate }'/>
								<select name="slcategory" class="modify_schedule_category" >
									<option value="1">취미</option>
									<option value="2">업무</option>
									<option value="3">약속</option>
									<option value="4">기타</option>
								</select>
								<div class="modify_schedule_time">
									<select name="slplannedTime" class="modify_schedule_plannedTime">
											<optgroup label="오전">
												<c:forEach begin="1" step="1" end="12" var="i">
													<option value="${i}">${i}</option>
												</c:forEach>
											</optgroup>
											<optgroup label="오후">
												<c:forEach begin="13" step="1" end="24" var="i">
													<option value="${i}">${i}</option>
												</c:forEach>
											</optgroup>
										</select>
									<select name="slplannedMin" class="modify_schedule_plannedMin">
										<optgroup label="분">
												<c:forEach begin="0" step="5" end="55" var="i">
													<option value="${i}">${i}</option>
												</c:forEach>
										</optgroup>
									</select>
								</div>
								<input name="slcontent" type='text' class="modify_schedule_content_text" placeholder="${list.slcontent }">
								<div class='modify_schedule_change'>
									<span class='schedule_modify_submit' data-value='${list.slnum }'><img width="24px" src="/images/schedule-modify-complete.png"></span>
									<span class='schedule_modify_submit_close' ><img width="24px" style='margin-left:5px;' src="/images/schedule-modify-close.png"></span>
								</div>
							</form>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	$(".schedule_modify_div").hide();
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
	$('.new_schedule_btn').on("click", function(){
		var slcontent = $(".new_schedule_content_text").val();
		if (slcontent.trim() === '') {
		  alert('내용을 입력해주세요.');
		  return;
		};
		$('.new_schedule_form').submit();
	});
	//스케줄 삭제 btn 클릭 이벤트
	$('.schedule_delete').on("click", function(){
		var slnum = $(this).data('value');
		var sdate = "${schedulelist[0].sdate}";
		var scheduleJSON = {
			"slnum" : slnum,	
			"sdate": sdate
		};
		$.ajax({
		    url: "/schedule/schedulelist/delete",
		    type: "DELETE",
			data: JSON.stringify(scheduleJSON),
			contentType: "application/json; charset=utf-8",
		    success: function(response) {
		        window.location.href =response;
		    }
		});
	});
	//스케줄 수정 btn 클릭 이벤트
	$('.schedule_modify').on("click", function(){
		$('.content-popup-container').remove(); //팝업 제거
		var $schedule = $(this).closest(".schedule");
		var $schedule_modify_div =  $(this).closest('div.schedule').next('div.schedule_modify_div.schedule_modify_div');
		$schedule.hide();
		$schedule_modify_div.show();
	});
	//스케줄 수정 완료 btn 클릭 이벤트
	$(document).on('click', '.schedule_modify_submit', function() {
		var slcontent = $(this).closest(".schedule_modify_form").find('.modify_schedule_content_text').val().trim();
		if (slcontent === '') {
		    alert('내용을 입력해주세요.');
		    return;
		};
		$(this).closest('.schedule_modify_form').submit();
	});
	//스케줄 수정 취소 btn 클릭 이벤트
	$(document).on('click', '.schedule_modify_submit_close', function() {
		$('.content-popup-container').remove(); //팝업 제거
		var $schedule_modify_div = $(this).closest(".schedule_modify_div");
		$schedule_modify_div.find('input').val(''); //내용 지움
		$schedule_modify_div.hide();
		$(this).closest('.schedule_modify_div').prev('.schedule').show();
	});
	
	//중요 스케줄 체크 / 언체크 이벤트
	$(".slimportantschedule").change(function() {
		var checkedValue;
		var slnum = $(this).closest('.schedule').find('.schedule_delete').data('value');

		if ($(this).is(":checked")) { //체크 이벤트
			checkedValue = 1;
		} else { //언체크 이벤트
			checkedValue = 0;
		};

		var scheduleJSON = {
			"slimportantschedule": checkedValue,
			"slnum": slnum
		};
		$.ajax({
			url: "/schedule/schedulelist/modifyImportantSchedule",
			type: "post",
			data: JSON.stringify(scheduleJSON),
			contentType: "application/json; charset=utf-8",
			success: function(response) {
				//삭제 성공
			}
		});
	});
	
	//중요 알림 추가 마우스 오버 이벤트 처리(팝업을 띄운다)
	$('.slimportantschedule').on('mouseover', function() {
		var content = '중요 스케줄로 추가/삭제합니다.'
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
	//수정 확인 알림 마우스 오버 이벤트 처리(팝업을 띄운다)
	$(document).on('mouseover', '.schedule_modify_submit', function() {
		var content = '스케줄 수정을 완료합니다.'
			var $location = $(this);
			makeMouseOverPopup(content, $location);
	})
	//수정 닫음 알림 마우스 오버 이벤트 처리(팝업을 띄운다)
	$(document).on('mouseover', '.schedule_modify_submit_close', function() {
		var content = '스케줄 수정을 취소합니다.'
			var $location = $(this);
			makeMouseOverPopup(content, $location);
	})
	
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
	//수정 확인 알림 마우스 아웃 이벤트 처리
	$(document).on('mouseout', '.schedule_modify_submit', function() {
		$('.content-popup-container').remove(); //팝업 제거
	});
	//수정 확인 알림 마우스 아웃 이벤트 처리
	$(document).on('mouseout', '.schedule_modify_submit_close', function() {
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