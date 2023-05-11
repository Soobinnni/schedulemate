package com.schedulemate.send.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SendVO {
	public SendVO() {
		super();
	};
	public SendVO(String sdRequestedType) {
		this.sdRequestedType = sdRequestedType;
	};
	
	private int sdNum; //전송고유번호
	private int mnum; //멤버고유번호
	private String sdTimeToSend; //발송시도시각
	private int sdOccuredError; //오류발생여부
	private String sdErrorMessage; //에러메시지
	private String sdRequestedType; //메시지타입
}
