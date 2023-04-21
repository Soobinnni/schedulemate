package com.schedulemate.schedule.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.ScheduleMapper;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private ScheduleMapper mapper;

	//멤버 넘버 read
	public int getMemberNum(String mid) throws Exception{
		return mapper.getMemberNum(mid);
	};
}
