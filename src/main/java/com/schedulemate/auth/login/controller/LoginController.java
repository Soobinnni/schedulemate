package com.schedulemate.auth.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class LoginController {
	@RequestMapping("/login")
	public String login(String error, String logout, Model model) {
		if (error != null) {
			System.out.println("회원 로그인 에러");
			model.addAttribute("error", "error");
		}
		if (logout != null) {
			System.out.println("회원 로그아웃");
			// model.addAttribute("logout", "로그아웃!!!");
			return "redirect:/";
		}
		return "auth.login";
	}
}
