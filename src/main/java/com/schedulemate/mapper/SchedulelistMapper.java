package com.schedulemate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.schedulemate.schedule.domain.SchedulelistVO;

public interface SchedulelistMapper {

	public List<SchedulelistVO> readMonthly(@Param("mnum") int mnum, @Param("sdate") String sdate) throws Exception;
	public List<SchedulelistVO> read(@Param("snum") int snum) throws Exception;
}