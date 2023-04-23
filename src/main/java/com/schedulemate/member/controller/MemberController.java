package com.schedulemate.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.schedulemate.member.domain.MemberVO;
import com.schedulemate.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService service;
	
	// 아이디 중복 체크
	@ResponseBody
	@PostMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestBody MemberVO member) throws Exception {
		int success = service.idCheck(member);
		ResponseEntity<String> entity = null;
		System.out.println("아이디 중복 검사 결과 : "+success);
		if (success == 1) {
			entity = new ResponseEntity<>("duplication", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<>("possible", HttpStatus.OK);
		}
		return entity;
	}


}
