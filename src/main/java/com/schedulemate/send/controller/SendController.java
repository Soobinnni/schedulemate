package com.schedulemate.send.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/*import com.schedulemate.send.service.SendService;*/

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/send")
public class SendController {
	@Value("${t.apitoken}")
	private static String tApiToken;

	public static void funcTelegram(String chatId, String text) {
		String Token = tApiToken;

		BufferedReader in = null;

		try {
			// 통신
			URL obj = new URL(
					"https://api.telegram.org/bot" + Token + "/sendmessage?chat_id=" + chatId + "&text=" + text);

			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("POST");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;

			while ((line = in.readLine()) != null) { // response를 차례대로 출력
				System.out.println("스케줄 전송 성공 : " + line);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}
}