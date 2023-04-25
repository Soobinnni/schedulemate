package com.schedulemate.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.schedulemate.member.domain.MemberVO;
import com.schedulemate.member.service.MemberService;

@Controller
public class CommonController {
	@Autowired
	private MemberService service;
	@Autowired
	private PasswordEncoder passwordEncoder; //암호화
	
	@GetMapping("/join")
	public String joinForm() {
		return "join-form";
	}
	
	@PostMapping("/join")
	public String join(MemberVO vo) throws Exception {
		// 비밀번호 암호화
		String inputPassword = vo.getMpwd();
		vo.setMpwd(passwordEncoder.encode(inputPassword)); //암호화
		
		int success = service.register(vo); //등록
		
		System.out.println("회원가입 완료 : "+success);
		
		return "redirect:/auth/login"; //완료 페이지 이동
	}
}
