package com.schedulemate.mapper;

public interface SendMapper {
	//userid를 등록한 적 있는 지 조회
	public int sendUserIdChk(int mnum) throws Exception;
}
