package com.schedulemate.mapper;

import org.apache.ibatis.annotations.Param;

import com.schedulemate.send.domain.SendVO;

public interface SendMapper {
	public void logSendSuccessMessage(SendVO sendVo, @Param("chatId")String chatId) throws Exception;
	public void logSendFailureMessage(SendVO sendVo, @Param("chatId")String chatId) throws Exception;
}
