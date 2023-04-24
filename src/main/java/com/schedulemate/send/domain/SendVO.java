package com.schedulemate.send.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class SendVO {
	private int sdnum; //전송 넘버
	private String sdUserId; //전송 유저아이디
	
	private int mnum; //멤버 넘버
	private int snum;//스케줄 넘버
	private int sdate;//스케줄 날짜
}
