package com.schedulemate;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import com.schedulemate.mapper.ScheduleMapper;
import com.schedulemate.schedule.domain.ScheduleVO;
import com.schedulemate.send.service.TelegramBotService;

import java.time.Duration;

@SpringBootTest
class SchedulemateApplicationTests {
	@Autowired
	private TelegramBotService service;
	@Autowired
	private ScheduleMapper mapper;
	private final int NUM_THREADS = 12; // 최대 스레드 개수
	private final ExecutorService executorService = Executors.newFixedThreadPool(NUM_THREADS);

	
	// 단일 스레드로 전송 : 4 분, 47 초, 217 밀리나노초(초당 1.738개 처리)
	public void sendMessagesWithSingleThread() {
		String[] chatIds = { "", "", "" };

		Map<String, String> chatIdToTextMap = new HashMap<>();
		for (int i = 1; i <= 500; i++) {
			chatIdToTextMap.put(String.valueOf(i), chatIds[i % 3]);
		}

		Instant start = Instant.now();
		for (Map.Entry<String, String> entry : chatIdToTextMap.entrySet()) {
			String text = entry.getKey();
			String chatId = entry.getValue();
			/*
			 * try { service.sendMessage(chatId, text); } catch (TelegramApiException e) {
			 * // TODO Auto-generated catch block e.printStackTrace(); }
			 */
		}
		Instant end = Instant.now();
		long timeElapsedMillis = Duration.between(start, end).toMillis();
		long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
		long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
		long millis = timeElapsedMillis % 1000;
		System.out.println("데일리 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");
	}

	
	// 10개 스레드로 나누어 전송 : 3 분, 3 초, 127 밀리나노초(초당 2.732개개 처리)
	public void sednMessages() {
		Thread t1 = new Thread(new ThreadEx(1, 50));
		Thread t2 = new Thread(new ThreadEx(51, 100));
		Thread t3 = new Thread(new ThreadEx(101, 150));
		Thread t4 = new Thread(new ThreadEx(151, 200));
		Thread t5 = new Thread(new ThreadEx(201, 250));
		Thread t6 = new Thread(new ThreadEx(251, 300));
		Thread t7 = new Thread(new ThreadEx(301, 350));
		Thread t8 = new Thread(new ThreadEx(351, 400));
		Thread t9 = new Thread(new ThreadEx(401, 450));
		Thread t10 = new Thread(new ThreadEx(451, 500));

		t1.start();
		t2.start();
		t3.start();
		t4.start();
		t5.start();
		t6.start();
		t7.start();
		t8.start();
		t9.start();
		t10.start();
		
		Instant start = Instant.now();
		try {
			t1.join(); // main스레드가 t1 스레드가 종료될 때까지 기다림
			t2.join(); // main스레드가 t2 스레드가 종료될 때까지 기다림
			t3.join();
			t4.join();
			t5.join();
			t6.join();
			t7.join();
			t8.join();
			t9.join();
			t10.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} 

		Instant end = Instant.now();
		long timeElapsedMillis = Duration.between(start, end).toMillis();
		long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
		long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
		long millis = timeElapsedMillis % 1000;
		System.out.println("데일리 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");
	}

	class ThreadEx implements Runnable {
		private int start;
		private int finish;

		public ThreadEx(int start, int finish) {
			super();
			this.start = start;
			this.finish = finish;
		}

		@Override
		public void run() {
			String[] chatIds = { "", "", "" };
			Map<String, String> chatIdToTextMap = new HashMap<>();
			for (int i = start; i <= finish; i++) {
				chatIdToTextMap.put(String.valueOf(i), chatIds[i % 3]);
			}
			for (Map.Entry<String, String> entry : chatIdToTextMap.entrySet()) {
				String text = entry.getKey();
				String chatId = entry.getValue();

				/*
				 * try { service.sendMessage(chatId, text); } catch (TelegramApiException e) {
				 * // TODO Auto-generated catch block e.printStackTrace(); }
				 */
			}
		}
	}
	
	@Test
	// 스레드풀로 스레드를 미리 생성, 메시지 정보를 한 번에 모은 뒤, 10개 멀티스레드로 나누어 전송 : 2 분, 18 초, 983 밀리나노초(초당 3.597개 처리)
	public void sendRessemebledMessages() {
		String[] chatIds = { "", "", "" };
		// 1419128966
		// 5887681987

		Map<String, String> chatIdToTextMap = new HashMap<>();
		for (int i = 1; i <= 500; i++) {
			chatIdToTextMap.put(String.valueOf(i), chatIds[i % 3]);
		}
		List<Callable<Void>> tasks = new ArrayList<>();

		for (Map.Entry<String, String> entry : chatIdToTextMap.entrySet()) {
			String text = entry.getKey();
			String chatId = entry.getValue();

			tasks.add(() -> {
				SendMessage message = new SendMessage(chatId, text);
				service.getBot().execute(message);
				return null;
			});
		}

		try {
			Instant start = Instant.now();
			executorService.invokeAll(tasks);
			Instant end = Instant.now();
			long timeElapsedMillis = Duration.between(start, end).toMillis();
			long minutes = TimeUnit.MILLISECONDS.toMinutes(timeElapsedMillis);
			long seconds = TimeUnit.MILLISECONDS.toSeconds(timeElapsedMillis) % 60;
			long millis = timeElapsedMillis % 1000;
			System.out.println("데일리 메세지 발송 완료: " + minutes + " 분, " + seconds + " 초, " + millis + " 밀리나노초");

			executorService.shutdown();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}