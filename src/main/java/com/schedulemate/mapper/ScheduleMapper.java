package com.schedulemate.mapper;

import org.apache.ibatis.annotations.Param;

public interface ScheduleMapper {
	//멤버 넘버 read
	public int getMemberNum(@Param("mid") String mid) throws Exception;
}
