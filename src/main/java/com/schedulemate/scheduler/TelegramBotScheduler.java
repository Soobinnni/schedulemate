package com.schedulemate.scheduler;

import java.time.Instant;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.schedulemate.send.domain.SendVO;
import com.schedulemate.send.service.SendInfoService;
import com.schedulemate.send.service.TelegramBotService;

import java.time.Duration;

@Component
public class TelegramBotScheduler {

    @Autowired
    private TelegramBotService telegramBotService;
    @Autowired
    private SendInfoService sendService;

    @Value("${telegram.bot.pool-size}")
    private int threadPoolSize;

	@Scheduled(cron = "0 0 18 * * ?") // 오후 6시마다 데일리 알림 발송
    public void sendDailyReminder() throws Exception {
        Map<String, String> infoToBeSentToTelegramMap = sendService.getSendDailyScheduleInfo(); // sendService에서 알림 정보 리스트 가져오기
        SendVO sendVO = new SendVO("daily");

		Instant start = Instant.now();
        telegramBotService.sendMessages(sendVO, infoToBeSentToTelegramMap);
        Instant end = Instant.now();
		long timeElapsedMillis = Duration.between(start, end).toMillis();
		long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
	    long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
	    long millis = timeElapsedMillis % 1000;
        System.out.println("데일리 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");
    
    }

	
//	  @Scheduled(cron = "0 0 19 ? * SUN")// 일요일 오후 7시마다 매주 알림 발송 

	  @Scheduled(cron = "0 23 22 * * ?") // 오후 7시마다 매주 알림 발송 
	  public void sendWeeklyReminder() throws Exception { 
		  Map<String, String> infoToBeSentToTelegramMap = sendService.getSendWeeklyScheduleInfo(); // sendService에서 알림 정보 리스트 가져오기
	        SendVO sendVO = new SendVO("weekly");

			Instant start = Instant.now();
	        telegramBotService.sendMessages(sendVO, infoToBeSentToTelegramMap);
	        Instant end = Instant.now();
			long timeElapsedMillis = Duration.between(start, end).toMillis();
			long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
		    long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
		    long millis = timeElapsedMillis % 1000;
	        System.out.println("주간 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");
	  }
	  /*
	  @Scheduled(cron = "0 0 20 L * ?") // 매달 마지막날 오후 8시마다 매달 중요 알림 발송 public void
	  */
	  @Scheduled(cron = "0 20 23 * * ?") // 오후 7시마다 매주 알림 발송 
	  public void sendImportantMonthlyReminder() throws Exception { 
		  Map<String, String> infoToBeSentToTelegramMap = sendService.getSendImportantMonthlyScheduleInfo(); // sendService에서 알림 정보 리스트 가져오기
	        SendVO sendVO = new SendVO("importantMonthly");

			Instant start = Instant.now();
	        telegramBotService.sendMessages(sendVO, infoToBeSentToTelegramMap);
	        Instant end = Instant.now();
			long timeElapsedMillis = Duration.between(start, end).toMillis();
			long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
		    long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
		    long millis = timeElapsedMillis % 1000;
	        System.out.println("매달 중요 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");
	  }
}
