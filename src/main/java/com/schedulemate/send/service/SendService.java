
package com.schedulemate.send.service;

import java.util.List;

public interface SendService {
	//체크한 snum리스트 사용자에게 전송하기
	public void sendChkSchedule(List<Integer> snumList, int mnum) throws Exception;
}
