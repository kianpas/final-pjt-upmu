package com.fpjt.upmu.member.controller;

import java.beans.PropertyEditor;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.fpjt.upmu.member.model.service.MemberService;
import com.fpjt.upmu.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"loginMember", "next"})
public class MemberController {

	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@ModelAttribute("common")
	public Map<String, Object> common(){
		log.info("@ModelAttribute(\"common\")");
		Map<String, Object> map = new HashMap<>();
		map.put("adminEmail", "admin@kh.or.kr");
		map.put("adminPhone", "070-1234-5678");
		return map;
	}
	
	
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
		
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {

		try {
			log.info("member = {}", member);
			//0. 비밀번호 암호화처리
			String rawPassword = member.getEmp_pw();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setEmp_pw(encodedPassword);
			log.info("member(암호화처리이후) = {}", member);
			
			int result = memberService.insertMember(member);
			
			redirectAttr.addFlashAttribute("msg", "회원가입성공");
		} catch (Exception e) {
			log.error("회원가입 오류!", e);
			throw e;
		}
		return "redirect:/";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		PropertyEditor editor = new CustomDateEditor(format, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	@GetMapping("/memberLogin.do")
	public void memberLogin(
				@SessionAttribute(required = false) String next,
				@RequestHeader(name = "Referer", required = false) String referer, 
				Model model) {
		log.info("referer = {}", referer);
		log.info("next = {}", next);
		if(next == null && referer != null)
			model.addAttribute("next", referer); // sessionScope에 저장
	}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(
					@RequestParam int emp_no, 
					@RequestParam String password,
					@SessionAttribute(required = false) String next,
					Model model,
					RedirectAttributes redirectAttr) {
		
		//1. 업무로직
		Member member = memberService.selectOneMember(emp_no);
		log.info("member = {}", member);
		
		
		//2. 로그인여부 분기처리
		if(member != null && bcryptPasswordEncoder.matches(password, member.getEmp_pw())) {
			// 로그인 성공
			// loginMember 세션속성으로 저장하려면, class에 @SessionAttributes로 등록
			model.addAttribute("loginMember", member);
			//사용한 next값은 제거
			model.addAttribute("next", null);
		}
		else {
			// 로그인 실패
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
			return "redirect:/member/memberLogin.do";
		}
		
		
		return "redirect:" + (next != null ? next : "/");
	}
	
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus status) {
		if(!status.isComplete())
			status.setComplete();
		return "redirect:/";
	}
	
	@GetMapping("/memberDetail.do")
	public ModelAndView memberDetail(ModelAndView mav, @SessionAttribute(name = "loginMember") Member loginMember) {
		log.info("loginMember = {}", loginMember);
		//속성 저장
		mav.addObject("time", System.currentTimeMillis());
		//viewName 설정
		mav.setViewName("member/memberDetail");
		return mav;
	}
	
	@PostMapping("/memberUpdate.do")
	public ModelAndView memberUpdate(
								@ModelAttribute Member member,
								@ModelAttribute("loginMember") Member loginMember,
								ModelAndView mav, 
								HttpServletRequest request
							) {
		log.debug("member = {}", member);
		log.debug("loginMember = {}", loginMember);
		
		try {
			
			int result = memberService.updateMember(member);
			
			
			//리다이렉트시 자동생성되는 queryString 방지
			RedirectView view = new RedirectView(request.getContextPath() + "/member/memberDetail.do");
			view.setExposeModelAttributes(false);
			mav.setView(view);
			
			
			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
			flashMap.put("msg", "사용자 정보 수정 성공!!!!!!");
			
		} catch (Exception e) {
			log.error("사용자 정보 수정 오류!", e);
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/checkIdDuplicate1.do")
	public String checkIdDuplicate1(@RequestParam int emp_no, Model model) {
		//1. 업무로직
		Member member = memberService.selectOneMember(emp_no);
		boolean available = member == null;
		//2. Model에 속성 저장
		model.addAttribute("available", available);
		model.addAttribute("emp_no", emp_no);
		
		return "jsonView";
	}
	
	@GetMapping("/checkIdDuplicate2.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate2(@RequestParam int emp_no) {
		//1. 업무로직
		Member member = memberService.selectOneMember(emp_no);
		boolean available = member == null;
		//2. map에 요소 저장후 리턴
		Map<String, Object> map = new HashMap<>();
		map.put("available", available);
		map.put("emp_no", emp_no);
		
		return map;
	}

	@GetMapping("/checkemp_noDuplicate3.do")
	public ResponseEntity<Map<String, Object>> checkemp_noDuplicate3(@RequestParam int emp_no) {
		//1. 업무로직
		Member member = memberService.selectOneMember(emp_no);
		boolean available = (member == null);
		//2. map에 요소 저장후 리턴
		Map<String, Object> map = new HashMap<>();
		map.put("available", available);
		map.put("emp_no", emp_no);
		
		return ResponseEntity
				.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
				.body(map);
	}
	
	
	
}




