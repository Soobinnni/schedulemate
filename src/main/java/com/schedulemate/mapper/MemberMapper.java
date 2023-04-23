package com.schedulemate.mapper;

import com.schedulemate.member.domain.MemberAuth;
import com.schedulemate.member.domain.MemberVO;

public interface MemberMapper {
	// 아이디를 읽어오기
	public MemberVO read(String mid);
	// 회원가입
	public void create(MemberVO vo) throws Exception;
	// 회원가입 권한 부여
	public int createAuth(MemberAuth auth) throws Exception;
    //아이디 중복 체크
	public int idCheck(MemberVO member) throws Exception;
}