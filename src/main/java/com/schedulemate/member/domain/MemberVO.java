package com.schedulemate.member.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class MemberVO {
	private int mnum; //멤버 넘버
	private String mname;//멤버 이름
	private String mid;//멤버 아이디
	private String mpwd;//멤버 비밀번호
	private String mjob;//멤버 직업
	private String memail;//멤버 이메일
	private String mphonenumber;//멤버 휴대폰번호
	private int mweekend; //주 스케줄 알림 여부
	private int mdaily; //하루 스케줄 알림 여부
	private int mimportantmonth; //한달 전 중요 스케줄 알림 여부
	private String mbotUserId; //봇 유저 아이디
	
	private List<MemberAuth> memberAuthList; //멤버권한

}
