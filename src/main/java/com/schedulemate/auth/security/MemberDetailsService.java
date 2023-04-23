package com.schedulemate.auth.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.schedulemate.auth.security.domain.MemberCustom;
import com.schedulemate.mapper.MemberMapper;
import com.schedulemate.member.domain.MemberVO;

import lombok.extern.java.Log;

@Log
public class MemberDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper mapper;

	// 사용자 정의 유저 상세 클래스 메서드-loadUserByUsername의 Username은 userId이다.
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		System.out.println("MemberDetailsService");

		// DB조회
		MemberVO member = mapper.read(userId);
		log.info("queried by umember mapper: " + member);
		return member == null ? null : new MemberCustom(member);
	}
}