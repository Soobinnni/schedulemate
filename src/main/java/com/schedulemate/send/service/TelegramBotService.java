package com.schedulemate.send.service;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Value;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import lombok.NonNull;

@Service
public class TelegramBotService extends TelegramLongPollingBot {
	private final int NUM_THREADS = 4; //최대 스레드 개수
	private final ExecutorService executorService = Executors.newFixedThreadPool(NUM_THREADS);

    @Value("${telegram.bot.token}")
	private String token;
    @Value("${telegram.bot.username}")
	private String username;

    @Override
    public String getBotToken() {
        return token;
    }

    @Override
    public String getBotUsername() {
        return username;
    }
    
    public TelegramLongPollingBot getBot() {
    	return this;
    }

    //메시지 전송
    public void sendMessage(@NonNull String chatId, String text) throws TelegramApiException {
            SendMessage message = new SendMessage();
            message.setChatId(chatId);
            message.setText(text);
        try {
        	execute(message);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }
    //여러 메시지 전송
    public void sendMessages(Map<String, String> chatIdToTextMap) {
        List<Callable<Void>> tasks = new ArrayList<>();

        for (Map.Entry<String, String> entry : chatIdToTextMap.entrySet()) {
            String chatId = entry.getKey();
            String text = entry.getValue();

            tasks.add(() -> {
                SendMessage message = new SendMessage(chatId, text);
                getBot().execute(message);
                return null;
            });
        }

        try {
            executorService.invokeAll(tasks);
            executorService.shutdown();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

	@Override
	public void onUpdateReceived(Update update) {
		//새로운 메시지가 도착했다면 해당 메시지의 내용을 추출하고, 필요한 처리를 수행하는 등의 작업을 수행하는 메소드	
	}
}
