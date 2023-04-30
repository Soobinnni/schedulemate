package com.schedulemate.send.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import lombok.NonNull;

@Service
public class TelegramBotService extends TelegramLongPollingBot {

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

	@Override
	public void onUpdateReceived(Update update) {
		//새로운 메시지가 도착했다면 해당 메시지의 내용을 추출하고, 필요한 처리를 수행하는 등의 작업을 수행하는 메소드	
	}
}