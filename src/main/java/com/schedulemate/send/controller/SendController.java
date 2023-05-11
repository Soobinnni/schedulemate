package com.schedulemate.send.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.schedulemate.send.domain.SendVO;
import com.schedulemate.send.service.SendInfoService;
import com.schedulemate.send.service.TelegramBotService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/send")
public class SendController {
	@Autowired
	private SendInfoService sendService;
	@Autowired
	private TelegramBotService botService;
	
	@PostMapping("/sendChkSchedule")
	public ResponseEntity<String> sendChkSchedule(@RequestBody List<Integer> snumList, HttpServletRequest request) throws Exception {
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");
		//스케줄 전송 정보 가져오는 서비스 호출
		
		Map<String, String> infoToBeSentToTelegramMap=sendService.getSendChkScheduleInfo(snumList, mnum);
		
		//보낼 정보
		String chatId = infoToBeSentToTelegramMap.get("chatId");
		String text = infoToBeSentToTelegramMap.get("text");
		SendVO sendVO = new SendVO("checked");
		String message = botService.sendMessage(chatId, text, sendVO);
		
		//스케줄 전송 서비스 호출
		return new ResponseEntity<String>(message, HttpStatus.OK);
	}

}