package com.schedulemate.schedulelist.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.schedulemate.mapper.SchedulelistMapper;
import com.schedulemate.schedulelist.domain.SchedulelistVO;

@Service
public class SchedulelistServiceImpl implements SchedulelistService {
	@Autowired
	private SchedulelistMapper mapper;

	public Map<String, List<SchedulelistVO>> read(int mnum, String sdate) throws Exception {
		//쿼리 결과
		List<SchedulelistVO> SchedulelistList = mapper.read(mnum, sdate);

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
}
