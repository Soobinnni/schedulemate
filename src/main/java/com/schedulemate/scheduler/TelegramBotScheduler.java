package com.schedulemate.scheduler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.schedulemate.send.service.SendInfoService;
import com.schedulemate.send.service.TelegramBotService;

@Component
public class TelegramBotScheduler {

    @Autowired
    private TelegramBotService telegramBotService;
    @Autowired
    private SendInfoService sendService;

    @Value("${telegram.bot.pool-size}")
    private int threadPoolSize;

	/*
	 * @Scheduled(cron = "0 0 18 * * ?") // 오후 6시마다 데일리 알림 발송
	 */	@Scheduled(cron = "0 53 2 * * ?") // 오후 6시마다 데일리 알림 발송
    public void sendDailyReminder() throws Exception {
        Map<String, String> infoToBeSentToTelegramMap = sendService.getSendDailyScheduleInfo(); // sendService에서 알림 정보 리스트 가져오기

        List<Callable<Void>> callables = new ArrayList<>();
        for (String chatId : infoToBeSentToTelegramMap.keySet()) {
            String text = infoToBeSentToTelegramMap.get(chatId);
            callables.add(() -> {
            	telegramBotService.sendMessage(chatId, text);
                return null;
            });
        }

        ExecutorService executor = Executors.newFixedThreadPool(threadPoolSize); // 최대 스레드 수는 properties 파일에서 읽어온 값으로 설정
        List<Future<Void>> futures = executor.invokeAll(callables);

        for (Future<Void> future : futures) {
            future.get();
        }

    	System.out.println("데일리 메세지 발송 완료");
        executor.shutdown(); // 모든 스레드 종료 대기
    }

	/*
	 * @Scheduled(cron = "0 0 19 * * ?") // 오후 7시마다 매주 알림 발송 public void
	 * sendWeeklyReminder() { ExecutorService executor =
	 * Executors.newFixedThreadPool(threadPoolSize); //List<User> userList =
	 * getUserListFromDatabase(); // sendService에서 알림 정보 리스트 가져오기 for (User user :
	 * userList) { executor.submit(() -> telegramBot.sendMessage(user.getChatId(),
	 * "주간 알림입니다.")); } executor.shutdown(); }
	 * 
	 * @Scheduled(cron = "0 0 20 * * ?") // 오후 8시마다 매달 중요 알림 발송 public void
	 * sendMonthlyReminder() { ExecutorService executor =
	 * Executors.newFixedThreadPool(threadPoolSize); //List<User> userList =
	 * getUserListFromDatabase(); // sendService에서 알림 정보 리스트 가져오기 for (User user :
	 * userList) { executor.submit(() -> telegramBot.sendMessage(user.getChatId(),
	 * "월간 알림입니다.")); } executor.shutdown(); }
	 */
}
