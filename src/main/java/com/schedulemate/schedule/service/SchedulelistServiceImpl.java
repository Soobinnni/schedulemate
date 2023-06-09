package com.schedulemate.schedule.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.SchedulelistMapper;
import com.schedulemate.schedule.domain.SchedulelistVO;

@Service
public class SchedulelistServiceImpl implements SchedulelistService {
	@Autowired
	private SchedulelistMapper mapper;

	//해당 날짜의 스케줄 리스트 담기
	public Map<String, List<SchedulelistVO>> readMonthly(int mnum, String startDate, String endDate) throws Exception {
		//쿼리 결과
		List<SchedulelistVO> SchedulelistList = mapper.readMonthly(mnum, startDate, endDate);

		// sdate를 key로 하고 SchedulelistVO를 value로 하는 Map 객체를 생성하여 결과를 저장할 List 객체에 추가
		Map<String, List<SchedulelistVO>> scheduleMap = new HashMap<>();

		for (SchedulelistVO vo : SchedulelistList) {
			String sdateToRepository = vo.getSdate();
			if (scheduleMap.containsKey(sdateToRepository)) {
				// 이미 같은 sdate를 가진 Map 객체가 존재하는 경우, List에 SchedulelistVO 객체를 추가
				List<SchedulelistVO> list = scheduleMap.get(sdateToRepository);
				list.add(vo);
				scheduleMap.put(sdateToRepository, list);
			} else {
				// 같은 sdate를 가진 Map 객체가 없는 경우, 새로운 Map 객체를 생성하여 List에 추가
				List<SchedulelistVO> list = new ArrayList<>();
				list.add(vo);
				scheduleMap.put(sdateToRepository, list);
			}
		}
		// end

		return scheduleMap;
	};
	
	//스케줄 읽기
	public List<SchedulelistVO> read(int snum) throws Exception{
		return mapper.read(snum);
	};
	
	//스케줄 등록
	public int register(SchedulelistVO vo) throws Exception{
		return mapper.create(vo);
	};
	//스케줄 삭제
	public int delete(int slnum) throws Exception{
		return mapper.delete(slnum);
	};
	//스케줄 수정
	public int modify(SchedulelistVO vo) throws Exception{
		return mapper.update(vo);
	};
	//중요 스케줄 업데이트
	public int modifyImportantSchedule(SchedulelistVO vo) throws Exception{
		return mapper.updateImportantSchedule(vo);
	};
}