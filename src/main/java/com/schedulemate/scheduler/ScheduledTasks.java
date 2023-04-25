package com.schedulemate.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.schedulemate.send.service.SendService;

@Component
public class ScheduledTasks {
	@Autowired
	private SendService sendService;

	@Scheduled(cron = "0 0 18 * * ?") // 오후 6시마다 데일리 알림 발송
	public void callSendService() throws Exception {
		sendService.sendDailySchedule();
	}

}
