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

	// 아이디 중복 체크
	public int idCheck(MemberVO member) throws Exception;

	// userid를 등록한 적 있는 지 조회
	public int botUserIdChk(int mnum) throws Exception;
	
	// userid 중복 체크
	public int chkDuplicateBotUserId(@Param("mbotUserId") String mbotUserId) throws Exception;

	// userid를 등록
	public int botUserIdRegiste(@Param("mbotUserId") String mbotUserId, @Param("mnum") int mnum) throws Exception;

	// Mnum으로 userid 읽기
	public String botUserIdReadbyMnum(@Param("mnum") int mnum) throws Exception;
	
	// Snum으로 userid 읽기
	public String botUserIdReadbySnum(@Param("snum") int snum) throws Exception;
	
	// 마이페이지 데일리 알람 업데이트
	public int updateMdailyStatus(MemberVO vo) throws Exception;

	// 마이페이지 매주 알람 업데이트
	public int updateMweekendStatus(MemberVO vo) throws Exception;

	// 마이페이지 매달 중요 알람 업데이트
	public int updateMimportantmonthStatus(MemberVO vo) throws Exception;
}