package com.schedulemate.schedule.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.schedulemate.schedule.service.ScheduleService;
import com.schedulemate.schedule.service.SchedulelistService;
import com.schedulemate.schedule.domain.ScheduleVO;
import com.schedulemate.schedule.domain.SchedulelistVO;


@Controller
@RequestMapping("/schedule")
@MapperScan(basePackages = "com.schedulemate.mapper")
public class ScheduleController {
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private SchedulelistService schedulelistService;
	
	@GetMapping("/home")
	public String schedule(Principal principal, Model model, HttpServletRequest request) throws Exception { 
		LocalDate tomorrow = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	    String formattedCurrentMonth = tomorrow.format(formatter);
	    
	    //getMemberNum임시 - member 일련번호 세션
	    int mnum = scheduleService.getMemberNum(principal.getName());
		HttpSession session = request.getSession(true);
		session.setAttribute("mnum", mnum);
		mnum = (Integer)session.getAttribute("mnum");
		
		model.addAttribute("mnum", mnum);
		model.addAttribute("sdate", (String)formattedCurrentMonth);
		
		return "schedule.home";
	}
	@GetMapping("/checkSchedule")
	public String checkSchedule(Model model, String sdate, HttpServletRequest request) throws Exception { 
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");
		
		model.addAttribute("mnum", mnum);
		model.addAttribute("sdate", sdate);

		return "schedule.checkSchedule";
	}

	//스케줄보기
	@GetMapping("/detail")
	public String detail(String sdate, HttpServletRequest request, Model model) throws Exception {
		ScheduleVO vo;
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");
		
		vo = scheduleService.read(mnum, sdate); //일정이 있는 지
		if(vo!=null) {
			List<SchedulelistVO> listVO = schedulelistService.read(vo.getSnum());
			model.addAttribute("schedulelist", listVO);
		}
		model.addAttribute("sdate", sdate);
		return "schedule.detail";
	}
	
	//스케줄 등록
	@PostMapping("/schedulelist/register")
	public String register(SchedulelistVO vo, HttpServletRequest request) throws Exception{
		String url = "redirect:/schedule/detail?sdate="+vo.getSdate();
		if (vo.getSnum()==0) {
			ScheduleVO schedulevo = new ScheduleVO();
			schedulevo.setSdate(vo.getSdate());
			schedulevo.setMnum((Integer) request.getSession(true).getAttribute("mnum"));
			int snum = scheduleService.register(schedulevo);
			System.out.println("새 스케줄 생성 (snum): "+snum);
			vo.setSnum(snum);
		}
		int success = schedulelistService.register(vo);
		System.out.println("등록 성공 : "+success);
		
		return url;
	}
	
	//스케줄 삭제
	@DeleteMapping("/schedulelist/delete")
	public ResponseEntity<String> delete(@RequestBody SchedulelistVO vo) throws Exception{
		String url = "/schedule/detail?sdate="+vo.getSdate();
		
		int success = schedulelistService.delete(vo.getSlnum());
		System.out.println("삭제 성공 : "+success);
		
		return new ResponseEntity<>(url, HttpStatus.OK);
	}
	
	//스케줄 수정
	@PostMapping("/schedulelist/modify")
	public String modify(SchedulelistVO vo) throws Exception{
		String url = "redirect:/schedule/detail?sdate="+vo.getSdate();
		int success = schedulelistService.modify(vo);
		System.out.println("수정 성공 : "+success);
		
		return url;
	}
	
	//중요 스케줄 업데이트
	@PostMapping("/schedulelist/modifyImportantSchedule")
	public ResponseEntity<String> modifyImportantSchedule(@RequestBody SchedulelistVO vo) throws Exception{
		int success = schedulelistService.modifyImportantSchedule(vo);
		System.out.println("중요 스케줄 변경 성공 : "+success);
		
		return new ResponseEntity<>("중요 업데이트 성공", HttpStatus.OK);
	}
	
	@PostMapping("/schedulelist")
	public ResponseEntity<Map<String, List<SchedulelistVO>>> schedulelist(@RequestBody  Map<String, String> object) throws Exception{
		int mnum = Integer.parseInt(object.get("mnum"));
		String sdate = (String)object.get("sdate");
				
		//key - value
		Map<String, List<SchedulelistVO>> schedulelistMap = schedulelistService.readMonthly(mnum, sdate);
		return new ResponseEntity<>(schedulelistMap, HttpStatus.OK);
	}
}
