package com.fpjt.upmu.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.employeeList.model.vo.Employee;
import com.fpjt.upmu.schedule.model.service.ScheduleService;
import com.fpjt.upmu.schedule.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/schedule")
@Slf4j
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;

	@GetMapping("/schedule.do")
	public String scheduleList(Authentication authentication, Model model) {
		
		Employee principal = (Employee)authentication.getPrincipal();
		
		List<Schedule> list = scheduleService.selectScheduleList(principal.getEmpNo()); // 사원번호
		
		model.addAttribute("list", list);
		
		return "schedule/schedule";
	}
	
	@PostMapping("/scheduleEnroll.do")
	public String scheduleEnroll(Authentication authentication, @ModelAttribute Schedule schedule, @RequestParam String shareSch, RedirectAttributes redirectAttr) {
		try {
			
			log.debug("schdule = {}", schedule);

			int result = scheduleService.insertSchedule(schedule);
			redirectAttr.addFlashAttribute("msg", "일정이 등록되었습니다.");
			
		} catch(Exception e) {
			log.error("일정 등록 오류!", e);
			throw e;
		}
	
		return "redirect:schedule.do";
	}
	
	@PostMapping("/scheduleUpdate.do")
	@ResponseBody
	public int scheduleUpdate(@RequestParam Map<String, Object> schMap) {
		int result = 0;
		log.debug("calMap = {}", schMap);
		try {
			
			result = scheduleService.updateSchedule(schMap);
			
		} catch(Exception e) {
			log.error("일정 수정 오류!", e);
			throw e;
		}
		
		return result;
	}

	@PostMapping("/schDateUpdate.do")
	@ResponseBody
	public int schDateUpdate(@RequestParam Map<String, Object> schDateMap) {
		int result = 0;
		try {

			result = scheduleService.updateSchDate(schDateMap);

		} catch(Exception e) {
			log.error("일정 수정 오류!", e);
			throw e;
		}

		return result;
	}
	
	@PostMapping("/scheduleDelete.do")
	@ResponseBody
	public int scheduleDelete(@RequestParam int schNo) {
		int result = 0;
		try {
			result = scheduleService.deleteSchedule(schNo);
			
		} catch(Exception e) {
			log.error("삭제 오류!", e);
			throw e;
			
		}
		
		return result;
	}
}