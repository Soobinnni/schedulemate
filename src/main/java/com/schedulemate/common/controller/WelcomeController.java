package com.schedulemate.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WelcomeController {
	@GetMapping("/")
	public String home() throws Exception{
		return "/common/welcome";
	}
}
