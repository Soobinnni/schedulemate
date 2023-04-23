<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/join.css">

<div id="join_container">
	<div class="join_content">
		<!-- mid -->
		<form action="/join" method="post" class='join_form'>
			<!-- mname -->
			<div class='mname_container'>
				<label for='mname'>이름</label> <input type="text" name='mname'
					id='mname' placeholder="|&nbsp;&nbsp;이름">
			</div>
			<div class='mid_container' style="height: 29px">
				<span style='display: inline-block; float: left;'>아이디</span> <input
					type="text" name='mid' id='mid' placeholder="|&nbsp;&nbsp;아이디"
					style='width: 200px; float: left; margin-left: 132px; margin-right: 0'>
				<span class="id_check_btn">중복확인</span>
			</div>
			<!-- mpwd -->
			<div style='clear: both;'></div>
			<div class='mpwd_container'>
				<label for='mpwd'>비밀번호</label> <input type="password" name='mpwd'
					id='mpwd' placeholder="|&nbsp;&nbsp;비밀번호">
			</div>
			<!-- confirm mpwd -->
			<div class='confirm_mpwd_container'>
				<label for='confirm_mpwd'>비밀번호 확인</label> <input type="password"
					name='confirm_mpwd' id='confirm_mpwd'
					placeholder="|&nbsp;&nbsp;비밀번호 확인">
			</div>
			<!-- mjob -->
			<div class='mjob_container'>
				<label for='mjob'>직업</label> <select name='mjob' id='mjob'>
					<option value='직장인'>직장인</option>
					<option value='전문직'>전문직</option>
					<option value='자영업'>자영업</option>
					<option value='프리랜서'>프리랜서</option>
					<option value='학생'>학생</option>
					<option value='기타'>기타</option>
				</select>
			</div>
			<!-- memail -->
			<div class='memail_container'>
				<label for='memail'>이메일</label> <input type="email" name='memail'
					id='memail' placeholder="|&nbsp;&nbsp;이메일">
			</div>
			<!-- mphonenumber -->
			<div class='mphonenumber_container'>
				<label for='mphonenumber'>휴대폰 번호</label> <input type="text"
					name='mphonenumber' id='mphonenumber'
					placeholder="|&nbsp;&nbsp;핸드폰 번호 (ex 01012345678)">
			</div>
			<!-- join-submit -->
			<div class='join_submit'>
				<input type="submit" class='join_submit_btn' value='회원가입'>
			</div>
			<sec:csrfInput />
		</form>
	</div>
</div>
<script>
	$(document).ready(function() {		
		// ajax 통신을 위한 csrf 설정
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr(
			"content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
		//유효성 검사
		function validateId() {
			var id = $("#mid").val();
			if (id == "") {
				alert("아이디를 입력해주세요.");
				return false;
			} else {
				return true;
			}
		}
		//비밀번호 재확인 여부
		function pwdConfirmChk() {
			if ($("#confirm_mpwd").val() === "") {
				alert("비밀번호 재확인을 해야합니다.");
				return;
				$("#confirm_mpwd").focus();
			}
		}
		function validateForm() {
			var name = $("#mname").val();
			var id = $("#mid").val();
			var pwd = $("#mpwd").val();
			var email = $("#memail").val();//이메일
			var phonenumber = $("#mphonenumber").val(); //핸드폰번호  

			if (name == "") {
				alert("이름을 입력해주세요.");
				return false;
			}
			if (id == "") {
				alert("아이디를 입력해주세요.");
				return false;
			}

			if (pwd == "") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			if (email == "") {
				alert("이메일을 입력해주세요.");
				return false;
			}
			if (phonenumber == "") {
				alert("전화번호를 입력해주세요.");
				return false;
			}

			// 10자리 또는 11자리 숫자만 허용하는 정규식
			var phoneRegex = /^\d{10,11}$/;
			if (!phoneRegex.test(phone)) {
				alert("핸드폰 번호는 10자리 또는 11자리의 숫자만 입력해주세요.");
				return false;
			}

			return true;
		}

		// 아이디 중복체크
		function idChk() {
			var isValidId = validateId();
			if (isValidId) {
				$.ajax({
					url : "/member/idCheck",
					type : "post",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify({
						"mid" : $("#mid").val()
					}),
					success : function(data) {
						if (data == "duplication") {
							alert("중복된 아이디 입니다.");
							$("#uId").val(''); //입력값 재설정
						} else {
							alert("사용 가능한 아이디입니다.");
						}
					}
				});
			}
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
		//아이디 중복 체크
		$(".id_check_btn").on("click", function() {
			idChk();
		});
		//회원 가입 버튼
		$(".join_submit_btn").on("click", function() {
			if (!validateForm()) {
				event.preventDefault();
			} else {
				$(".join_form").submit();
			}
		});

		//비밀번호 재확인 불일치 경우.
		$(function() {
			$('#confirm_mpwd').blur(function() {
				if ($('#mpwd').val() != $('#confirm_mpwd').val()) {
					if ($('#confirm_mpwd').val() != '') {
						alert("비밀번호가 일치하지 않습니다.");
						$('#confirm_mpwd').val('');
						$('#confirm_mpwd').focus();
					}
				}
			})
		});
	});
</script>