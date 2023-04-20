package com.schedulemate.schedule.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule")
@MapperScan(basePackages = "com.schedulemate.mapper")
public class ScheduleController {
	
	@GetMapping("/home")
	public String schedule() throws Exception {
		LocalDate today = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String formattedToday = today.format(formatter);
	    
	    
		return "schedule.home";
	}
}
