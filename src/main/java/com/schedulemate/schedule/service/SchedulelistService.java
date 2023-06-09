package com.schedulemate.schedule.service;

import java.util.List;
import java.util.Map;

import com.schedulemate.schedule.domain.SchedulelistVO;

public interface SchedulelistService {
	public Map<String, List<SchedulelistVO>> readMonthly(int mnum, String startDate, String endDate) throws Exception;
	public List<SchedulelistVO> read(int snum) throws Exception;
	public int register(SchedulelistVO vo) throws Exception;
	public int delete(int slnum) throws Exception;
	public int modify(SchedulelistVO vo) throws Exception;
	public int modifyImportantSchedule(SchedulelistVO vo) throws Exception;
}
