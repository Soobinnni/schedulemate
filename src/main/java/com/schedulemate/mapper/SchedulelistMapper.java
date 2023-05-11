package com.schedulemate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.schedulemate.schedule.domain.SchedulelistVO;

public interface SchedulelistMapper {

	public List<SchedulelistVO> readMonthly(@Param("mnum") int mnum, @Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;
	
	//스케줄 읽기
	public List<SchedulelistVO> read(@Param("snum") int snum) throws Exception;
	//스케줄 등록
	public int create(SchedulelistVO vo) throws Exception;
	//스케줄 삭제
	public int delete(@Param("slnum") int slnum) throws Exception;
	//스케줄 수정
	public int update(SchedulelistVO vo) throws Exception;
	//중요 스케줄 업데이트
	public int updateImportantSchedule(SchedulelistVO vo) throws Exception;
}