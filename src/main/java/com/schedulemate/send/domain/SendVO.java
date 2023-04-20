package com.schedulemate.send.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class SendVO {
	private int sdnum; //전송 넘버
	private int sdweekend; //일주일 전송 여부
	private int sdwdaily; //데일리 전송 여부
	private int sdweeimportantmonth; //한달 중요일정 전송 여부

	private int mnum; //멤버 넘버
	private int snum;//스케줄 넘버
}
