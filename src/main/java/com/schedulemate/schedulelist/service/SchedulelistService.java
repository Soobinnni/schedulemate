package com.schedulemate.schedulelist.service;

import java.util.List;
import java.util.Map;

import com.schedulemate.schedulelist.domain.SchedulelistVO;

public interface SchedulelistService {
	public Map<String, List<SchedulelistVO>> read(int mnum, String sdate) throws Exception;
}
