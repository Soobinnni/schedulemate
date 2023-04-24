package com.schedulemate.send.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.SendMapper;

@Service
public class SendServiceImpl implements SendService {
	@Autowired
	private SendMapper mapper;
	
	//userid를 등록한 적 있는 지 조회
	public int sendUserIdChk(int mnum) throws Exception{
		return mapper.sendUserIdChk(mnum);
	};
}
