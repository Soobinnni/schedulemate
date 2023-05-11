
package com.schedulemate.send.service;

import java.util.List;
import java.util.Map;

public interface SendInfoService {
	//체크한 snum리스트 사용자에게 전송하기
	public Map<String, String> getSendChkScheduleInfo(List<Integer> snumList, int mnum) throws Exception;
	//데일리 알림 발송 설정 사용자에게 스케줄 전송하기
	public Map<String, String> getSendDailyScheduleInfo() throws Exception;
	//매주 알림 발송 설정 사용자에게 스케줄 전송하기
	public Map<String, String> getSendWeeklyScheduleInfo() throws Exception;
	//매달 중요 알림 발송 설정 사용자에게 스케줄 전송하기
	public Map<String, String> getSendImportantMonthlyScheduleInfo() throws Exception; 
}
