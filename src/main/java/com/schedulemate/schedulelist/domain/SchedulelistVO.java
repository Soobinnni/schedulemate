package com.schedulemate.schedulelist.domain;

import lombok.ToString;
import lombok.Getter;
import lombok.Setter;

@ToString
@Getter
@Setter
public class SchedulelistVO {
	private int slnum; //스케줄 목록 넘버
	private int slplannedTime; //스케줄 목록 시각
	private int slplannedMin; //스케줄 목록 분
	private String slcontent; //스케줄 목록 내용
	private int slimportantschedule; //중요 스케줄 표시
	private int slcategory; //스케줄 목록 카테고리

	private int snum; //스케줄 넘버
}
