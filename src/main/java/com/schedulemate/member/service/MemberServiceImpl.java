package com.schedulemate.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.MemberMapper;
import com.schedulemate.member.domain.MemberAuth;
import com.schedulemate.member.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper mapper;
    
    //회원가입(+회원권한부여)
    public int register(MemberVO vo) throws Exception{
        mapper.create(vo); //회원 정보 insert
        MemberAuth auth = new MemberAuth(); //회원 권한 insert
        auth.setMemberAuth("ROLE_MEMBER");
        return mapper.createAuth(auth);    
    };
    //아이디 중복 체크
	public int idCheck(MemberVO member) throws Exception{
        return mapper.idCheck(member);    
	};
	//멤버 정보 읽기
	public MemberVO read(String mid) throws Exception{
        return mapper.read(mid);    
	};
}
