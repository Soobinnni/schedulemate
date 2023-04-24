<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--<sec:csrfInput />-->
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/mypage-info.css">

<div class=""></div>
<script>
	function changeCss() {
		$(".mypage-info").css({
			'color' : 'black',
			'border-bottom' : '3px dashed black'
		});
		$(".mypage-info").on("mouseover", function() {
			$(".mypage-info").css({
				'color' : 'white'
			});
		});
		$(".mypage-info").on("mouseout", function() {
			$(".mypage-info").css({
				'color' : 'black'
			});
		});
	}
	$(document).ready(function() {
		changeCss();
	});
</script>