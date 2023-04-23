package com.schedulemate.member.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberAuth {

	private int mnum; //멤버번호
	private String memberAuth; // 멤버 권한
}
