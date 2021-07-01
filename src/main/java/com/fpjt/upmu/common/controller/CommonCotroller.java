package com.fpjt.upmu.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.vo.Job;
import com.fpjt.upmu.notice.model.service.NoticeService;
import com.fpjt.upmu.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/common")
public class CommonCotroller {

	@Autowired
	EmployeeListService elService;
	
	//부서목록 불러오기
	@GetMapping("/eListPop.do")
	public void eListPop(Model model) {	
		try {
			List<Department> dList = elService.selectDeptList();
			model.addAttribute("dList", dList);
		} catch (Exception e) {
			log.error("부서목록 오류!");
		}
	}
	
	@GetMapping("/myProfile")
	public void myProfile(@RequestParam(value = "empNo") String param, Model model) {
		try {
			Employee employee = elService.selectOneEmp(param);
			List<Department> dList = elService.selectDeptList();
			List<Job> jList = elService.selectJobList();
			
			model.addAttribute("dList", dList);
			model.addAttribute("jList", jList);
			model.addAttribute("employee", employee);
		} catch (Exception e) {
			log.error("프로필 오류!");
		}
	}
	
	@PostMapping("accessDenied.do")
	public void error() {
		
	}
}
