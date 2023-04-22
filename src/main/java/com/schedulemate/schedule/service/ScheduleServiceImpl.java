package com.schedulemate.schedule.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.ScheduleMapper;
import com.schedulemate.schedule.domain.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private ScheduleMapper mapper;

	//멤버 넘버 read
	public int getMemberNum(String mid) throws Exception{
		return mapper.getMemberNum(mid);
	};
	//스케줄 read
	public ScheduleVO read(int mnum, String sdate) throws Exception {
		return mapper.read(mnum, sdate);
	};
}
