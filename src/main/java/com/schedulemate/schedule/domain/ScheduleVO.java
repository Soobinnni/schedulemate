package com.schedulemate.schedule.domain;

import lombok.ToString;
import lombok.Getter;
import lombok.Setter;

@ToString
@Getter
@Setter
public class ScheduleVO {
	private int snum; //스케줄 넘버
	private String sdate; //스케줄 날짜
	
	private int mnum; //회원 넘버
}
