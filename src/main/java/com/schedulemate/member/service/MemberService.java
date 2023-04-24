package com.schedulemate.member.service;

import com.schedulemate.member.domain.MemberVO;

public interface MemberService {
	public int register(MemberVO vo) throws Exception;
	public int idCheck(MemberVO member) throws Exception;
	public MemberVO read(String mid) throws Exception;
}
