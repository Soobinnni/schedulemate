package com.schedulemate.schedule.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.schedulemate.schedule.service.ScheduleService;


@Controller
@RequestMapping("/schedule")
@MapperScan(basePackages = "com.schedulemate.mapper")
public class ScheduleController {
	@Autowired
	private ScheduleService service;
	
	@GetMapping("/home")
	public String schedule(Principal principal, Model model, HttpServletRequest request) throws Exception { 
		LocalDate currentMonth = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	    String formattedCurrentMonth = currentMonth.format(formatter);
	    
	    //getMemberNum임시 - member 일련번호 세션
	    int mnum = service.getMemberNum("xpsxm225");
		HttpSession session = request.getSession(true);
		session.setAttribute("mnum", mnum);
		mnum = (Integer)session.getAttribute("mnum");

		model.addAttribute("mnum", mnum);
		model.addAttribute("sdate", (String)formattedCurrentMonth);

		return "schedule.home";
	}
}
