package com.schedulemate.schedule.service;

import com.schedulemate.schedule.domain.ScheduleVO;

public interface ScheduleService {
	//멤버 넘버 read
	public int getMemberNum(String mid) throws Exception;
	//스케줄 read
	public ScheduleVO read(int mnum, String sdate) throws Exception;
}
