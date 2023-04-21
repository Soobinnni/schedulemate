package com.schedulemate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.schedulemate.schedulelist.domain.SchedulelistVO;

public interface SchedulelistMapper {

	public List<SchedulelistVO> read(@Param("mnum") int mnum, @Param("sdate") String sdate) throws Exception;
}