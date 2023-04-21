package com.schedulemate.schedulelist.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.schedulemate.schedulelist.domain.SchedulelistVO;
import com.schedulemate.schedulelist.service.SchedulelistService;


@Controller
@RequestMapping("/schedulelist")
public class SchedulelistController {
	@Autowired
	private SchedulelistService service;
	
	
	@PostMapping("/")
	public ResponseEntity<Map<String, List<SchedulelistVO>>> schedulelist(@RequestBody  Map<String, String> object) throws Exception{
		int mnum = Integer.parseInt(object.get("mnum"));
		String sdate = (String)object.get("sdate");
		
		//key - value
		Map<String, List<SchedulelistVO>> schedulelistMap = service.read(mnum, sdate);
		System.out.println(schedulelistMap);
		return new ResponseEntity<>(schedulelistMap, HttpStatus.OK);
	}
}
