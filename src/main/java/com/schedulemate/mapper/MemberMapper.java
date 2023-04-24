package com.schedulemate.mapper;

import org.apache.ibatis.annotations.Param;

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
	//userid를 등록한 적 있는 지 조회
	public int botUserIdChk(int mnum) throws Exception;
	//userid를 등록
	public int botUserIdRegiste(@Param("mbotUserId") String mbotUserId, @Param("mnum") int mnum) throws Exception;
}