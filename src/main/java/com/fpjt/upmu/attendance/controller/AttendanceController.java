package com.fpjt.upmu.attendance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fpjt.upmu.attendance.model.service.AttendanceService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/attendance")
public class AttendanceController {
	
	@Autowired
	private AttendanceService attendanceService;
	
	@GetMapping("/attendanceManage.do")
	public String attendanceManage() {
		
		return "/attendance/attendanceManage";
	}

}
