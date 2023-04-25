package com.schedulemate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.schedulemate.schedule.domain.ScheduleVO;

public interface ScheduleMapper {
	//멤버 넘버 read
	public int getMemberNum(@Param("mid") String mid) throws Exception;
	//스케줄 register
	public int create(ScheduleVO vo) throws Exception;
	public int getScheduleById(Integer snum) throws Exception;
	//스케줄 read
	public ScheduleVO read(@Param("mnum") int mnum, @Param("sdate") String sdate) throws Exception;
	//데일리 알림 스케줄 m_botUserId : s_num Map형태로 받기
	public List<Integer> getScheduleNumlistSendDaily(@Param("sdate") String sdate) throws Exception;
}
