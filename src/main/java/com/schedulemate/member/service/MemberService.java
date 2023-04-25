package com.schedulemate.member.service;

import com.schedulemate.member.domain.MemberVO;

public interface MemberService {
	public int register(MemberVO vo) throws Exception;
	public int idCheck(MemberVO member) throws Exception;
	public MemberVO read(String mid) throws Exception;
	public int botUserIdChk(int mnum) throws Exception;
	public int botUserIdRegiste(String mbotUserId, int mnum) throws Exception;
	public int updateMdailyStatus(MemberVO vo) throws Exception;
	public int updateMweekendStatus(MemberVO vo) throws Exception;
	public int updateMimportantmonthStatus(MemberVO vo) throws Exception;
}
