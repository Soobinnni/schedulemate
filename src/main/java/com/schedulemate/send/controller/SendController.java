package com.schedulemate.send.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.schedulemate.send.service.SendService;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/send")
public class SendController {
	@Autowired
	private SendService service;
	
	@PostMapping("/sendChkSchedule")
	public ResponseEntity<String> sendChkSchedule(@RequestBody List<Integer> snumList, HttpServletRequest request) throws Exception {
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");
		//스케줄 전송 서비스 호출
		service.sendChkSchedule(snumList, mnum);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

}