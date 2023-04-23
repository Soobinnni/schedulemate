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
	private List<MemberAuth> memberAuthList; //멤버권한
}
