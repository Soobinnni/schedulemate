package com.schedulemate.send.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.MemberMapper;
import com.schedulemate.mapper.ScheduleMapper;
import com.schedulemate.mapper.SchedulelistMapper;
import com.schedulemate.schedule.domain.SchedulelistVO;

@Service
@PropertySource("classpath:application.properties")
public class SendServiceImpl implements SendService {
	@Value("${t.apitoken}")
	private String tApiToken;

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private ScheduleMapper scheduleMapper;
	@Autowired
	private SchedulelistMapper schedulelistMapper;

	// 체크한 snum리스트 사용자에게 전송하기
	public void sendChkSchedule(List<Integer> snumList, int mnum) throws Exception {
		List<SchedulelistVO> schedulelist = new ArrayList<>(); // 전체 스케줄 리스트

		for (int snum : snumList) {
			List<SchedulelistVO> schedule = schedulelistMapper.read(snum); // 하나의 snum에 대한 스케줄 리스트
			schedulelist.addAll(schedule); // 합치기
		}

		// sdate를 key로 하고 SchedulelistVO를 value로 하는 Map 객체를 생성하여 결과를 저장할 List 객체에 추가
		Map<String, List<SchedulelistVO>> scheduleMap = new HashMap<>();

		for (SchedulelistVO vo : schedulelist) {
			String sdateToRepository = vo.getSdate();
			if (scheduleMap.containsKey(sdateToRepository)) {
				// 이미 같은 sdate를 가진 Map 객체가 존재하는 경우, List에 SchedulelistVO 객체를 추가
				List<SchedulelistVO> list = scheduleMap.get(sdateToRepository);
				list.add(vo);
				scheduleMap.put(sdateToRepository, list);
			} else {
				// 같은 sdate를 가진 Map 객체가 없는 경우, 새로운 Map 객체를 생성하여 List에 추가
				List<SchedulelistVO> list = new ArrayList<>();
				list.add(vo);
				scheduleMap.put(sdateToRepository, list);
			}
		}

		// scheduleMap
		String mbotUserId = memberMapper.botUserIdReadbyMnum(mnum); // 봇 채팅 유저아이디
		String sendText = makeChkSendMessage(scheduleMap); // 전송할 텍스트

		// api 통신, 텍스트 전송
		sendTelegram(mbotUserId, sendText);
		System.out.println("체크 알림 발송 완료");

	};

	// 데일리 알림 발송 설정 사용자에게 스케줄 전송하기
	public void sendDailySchedule() throws Exception {
		LocalDate currentMonth = LocalDate.now().plusDays(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String sdate = currentMonth.format(formatter); // 내일 날짜의 sdate

		// 데일리 발송 알림이 돼 있고, 내일 날짜에 스케줄이 있는 snum 반환
		List<Integer> scheduleNumlistSendDaily = scheduleMapper.getScheduleNumlistSendDaily(sdate);
		if (scheduleNumlistSendDaily.size()!=0) {
			// snum을 기준으로 mbotUserId List<SchedulelistVO>담아 텍스트 전송
			for (Integer snum : scheduleNumlistSendDaily) {
				// mbotUserId key로담아오기
				String chatId = memberMapper.botUserIdReadbySnum(snum);
				// List<SchedulelistVO> value로 담아오기
				List<SchedulelistVO> schedulelist = schedulelistMapper.read(snum);
				String text = makeDailySendMessage(schedulelist, sdate); // 메시지 만들기

				// 발송
				sendTelegram(chatId, text);
				System.out.println("데일리 알림 발송 완료");
			}
		} else {
			System.out.println("전송할 데일리 알림 발송 없음");
		}
	};

	// 체크한 스케줄 전송 문자 만들기
	private String makeChkSendMessage(Map<String, List<SchedulelistVO>> scheduleMap) throws ParseException {
		String sendText = "★스케줄 메이트 입니다. 일정을 확인해주세요!★";
		sendText += "%0A";

		Set<String> keySet = scheduleMap.keySet(); // sdate keySet
		for (String key : keySet) {
			List<SchedulelistVO> schedulelist = scheduleMap.get(key); // 같은 날짜의 스케줄 리스트
			sendText += "%0A";
			sendText += "%0A";
			sendText += "▶ " + formatDate(key) + " ◀"; // 날짜
			for (SchedulelistVO schedule : schedulelist) {
				sendText += "%0A";
				String category = changeCategoryToString(schedule.getSlcategory());
				String time = changeTimeToString(schedule.getSlplannedTime(), schedule.getSlplannedMin());
				String content = schedule.getSlcontent();
				sendText += "⊙ ";
				sendText += category + " " + time + " " + content;
			}
		}
		return sendText;
	}

	// 데일리 스케줄 전송 문자 만들기
	private String makeDailySendMessage(List<SchedulelistVO> schedulelist, String sdate) throws ParseException {
		String sentText = "★스케줄 메이트 데일리 스케줄 알림입니다!★";
		sentText += "%0A%0A";
		sentText += "▶ " + formatDate(sdate) + " ◀"; // 날짜
		for (SchedulelistVO schedule : schedulelist) {
			sentText += "%0A";
			String category = changeCategoryToString(schedule.getSlcategory());
			String time = changeTimeToString(schedule.getSlplannedTime(), schedule.getSlplannedMin());
			String content = schedule.getSlcontent();
			sentText += "⊙ ";
			sentText += category + " " + time + " " + content;
		}
		return sentText;
	}

	// 날짜 포맷 변경
	private String formatDate(String formatObj) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
		Date date = format.parse(formatObj);

		format.applyPattern("yyyy년 M월 d일");
		String formattedDate = format.format(date);

		return formattedDate;
	}

	// 카테고리 문자열로 변경
	private String changeCategoryToString(int categoryNum) throws ParseException {
		String category = null;
		switch (categoryNum) {
		case 1:
			category = "[취미]";
			break;
		case 2:
			category = "[업무]";
			break;
		case 3:
			category = "[약속]";
			break;
		case 4:
			category = "[기타]";
			break;
		}

		return category;
	}

	// 시간 문자열로 변경
	private String changeTimeToString(int time, int min) throws ParseException {
		String timeToString = null;
		if (min == 0) {
			timeToString = time + "시";
		} else {
			timeToString = time + "시 " + min + "분";
		}
		return timeToString;
	}

	// telegram api 통신. 스케줄을 보냄
	private void sendTelegram(String chatId, String text) {
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
				System.out.println("전송 성공 : " + line);
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