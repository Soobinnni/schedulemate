package com.schedulemate.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
	@GetMapping("/schedule")
	public String schedule() throws Exception {
		return "member-home";
	}
}
