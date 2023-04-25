package com.schedulemate.member.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.schedulemate.member.domain.MemberVO;
import com.schedulemate.member.service.MemberService;
/*import com.schedulemate.send.service.SendService;*/

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	/*
	 * @Autowired private SendService sendService;
	 */

	// 아이디 중복 체크
	@ResponseBody
	@PostMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestBody MemberVO member) throws Exception {
		int success = memberService.idCheck(member);
		ResponseEntity<String> entity = null;
		System.out.println("아이디 중복 검사 결과 : " + success);
		if (success == 1) { // count 결과 1
			entity = new ResponseEntity<>("duplication", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<>("possible", HttpStatus.OK);
		}
		return entity;
	}

	// 마이페이지
	@GetMapping("/mypage/info")
	public String info(Model model, Principal principal) throws Exception {
		// 멤버 정보 read
		MemberVO vo = memberService.read(principal.getName());
		model.addAttribute("member", vo);

		return "mypage.info";
	}

	// 마이페이지
	@GetMapping("/mypage/scheduleInfo")
	public String scheduleInfo(Model model, Principal principal) throws Exception {
		// 멤버 정보 read
		MemberVO vo = memberService.read(principal.getName());
		model.addAttribute("member", vo);

		return "mypage.scheduleInfo";
	}

	// 마이페이지
	@GetMapping("/mypage/registerBotUserId")
	public String registerBotUserId() throws Exception {
		return "mypage.registerBotUserId";
	}
	// 마이페이지
	@GetMapping("/mypage/modifyBotUserId")
	public String modifyBotUserId() throws Exception {
		return "mypage.modifyBotUserId";
	}
	
	//마이페이지 데일리 알람 업데이트
	@PostMapping("/mypage/updateMdailyStatus")
	public ResponseEntity<String> updateMdailyStatus(@RequestBody MemberVO vo, HttpServletRequest request) throws Exception {
		vo.setMnum((Integer)request.getSession(true).getAttribute("mnum"));
		int success = memberService.updateMdailyStatus(vo);
		System.out.println("데일리 알람 상태 변경 완료 : "+success);
		return new ResponseEntity<String>("update success", HttpStatus.OK);
	}	
	//마이페이지 매주 알람 업데이트
	@PostMapping("/mypage/updateMweekendStatus")
	public ResponseEntity<String> updateMweekendStatus(@RequestBody MemberVO vo, HttpServletRequest request) throws Exception {
		vo.setMnum((Integer)request.getSession(true).getAttribute("mnum"));
		int success = memberService.updateMweekendStatus(vo);
		System.out.println("매주 알람 상태 변경 완료 : "+success);
		return new ResponseEntity<String>("update success", HttpStatus.OK);
	}	
	//마이페이지 매달 중요 알람 업데이트
	@PostMapping("/mypage/updateMimportantmonthStatus")
	public ResponseEntity<String> updateMimportantmonthStatus(@RequestBody MemberVO vo, HttpServletRequest request) throws Exception {
		vo.setMnum((Integer)request.getSession(true).getAttribute("mnum"));
		int success = memberService.updateMimportantmonthStatus(vo);
		System.out.println("매달 중요 알람 상태 변경 완료 : "+success);
		return new ResponseEntity<String>("update success", HttpStatus.OK);
	}
	

	//bot userid체크
	@PostMapping("/botUserIdChk")
	public ResponseEntity<String> botUserIdChk(HttpServletRequest request) throws Exception {
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");

		int responseResult = memberService.botUserIdChk(mnum);

		System.out.println("userId 조회 결과 : " + responseResult);
		if (responseResult == 0) {
			return new ResponseEntity<>("null", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("not null", HttpStatus.OK);
		}
	}
	
	//bot userid입력
	@PostMapping("/botUserIdRegiste")
	public String botUserIdRegiste(HttpServletRequest request, String mbotUserId, Model model) throws Exception {
		int mnum = (Integer) request.getSession(true).getAttribute("mnum");

		int success = memberService.botUserIdRegiste(mbotUserId, mnum);

		System.out.println("userId 등록 성공 : " + success);
		
		return "redirect:/member/mypage/registerBotUserId";
	}
}
