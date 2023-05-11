package com.schedulemate.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.MemberMapper;
import com.schedulemate.member.domain.MemberAuth;
import com.schedulemate.member.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;
    
    //회원가입(+회원권한부여)
    public int register(MemberVO vo) throws Exception{
        memberMapper.create(vo); //회원 정보 insert
        MemberAuth auth = new MemberAuth(); //회원 권한 insert
        auth.setMemberAuth("ROLE_MEMBER");
        return memberMapper.createAuth(auth);    
    };
    //아이디 중복 체크
	public int idCheck(MemberVO member) throws Exception{
        return memberMapper.idCheck(member);    
	};
	//멤버 정보 읽기
	public MemberVO read(String mid) throws Exception{
        return memberMapper.read(mid);    
	};
	
	//userid를 등록한 적 있는 지 조회
	public int botUserIdChk(int mnum) throws Exception{
		return memberMapper.botUserIdChk(mnum);
	};
	//userid 중복 체크
	public int chkDuplicateBotUserId(String mbotUserId) throws Exception{
		return memberMapper.chkDuplicateBotUserId(mbotUserId);
	};
	//userid를 등록
	public int botUserIdRegiste(String mbotUserId, int mnum) throws Exception{
		return memberMapper.botUserIdRegiste(mbotUserId, mnum);
	};
	//마이페이지 데일리 알람 업데이트
	public int updateMdailyStatus(MemberVO vo) throws Exception{
		return memberMapper.updateMdailyStatus(vo);
	};
	//마이페이지 매주 알람 업데이트
	public int updateMweeklyStatus(MemberVO vo) throws Exception{
		return memberMapper.updateMweeklyStatus(vo);
	};
	//마이페이지 매달 중요 알람 업데이트
	public int updateMimportantmonthStatus(MemberVO vo) throws Exception{
		return memberMapper.updateMimportantmonthStatus(vo);
	};
}