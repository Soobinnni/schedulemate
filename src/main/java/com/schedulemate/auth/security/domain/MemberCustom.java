package com.schedulemate.auth.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.schedulemate.member.domain.MemberVO;


public class MemberCustom extends User {
	private static final long serialVersionUID = 1L;

	private MemberVO member;

	public MemberCustom(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public MemberCustom(MemberVO member) {
		super(member.getMid(), member.getMpwd(), member.getMemberAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getMemberAuth())).collect(Collectors.toList()));

		this.member = member;
	}

	public MemberVO getMember() {
		return member;
	}
}

