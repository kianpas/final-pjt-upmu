package com.fpjt.upmu.employeeList.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Employee;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/employeeList")
public class EmployeeListController {

	@Autowired
	EmployeeListService elService;
	
	@GetMapping("/eList")
	public void mList(Model model) {	
		try {
			List<Department> dList = elService.selectDeptList();
			model.addAttribute("dList", dList);
		} catch (Exception e) {
			log.error("부서목록 오류!");
		}
	}
	
	@PostMapping("/departEnroll.do")
	public String departEnroll(Department dept, RedirectAttributes redirectAttr) {
		try {			
			int result = elService.insertDept(dept);
		} catch (Exception e) {
			log.error("부서등록 오류!");
		}
		return "redirect:eList";
	}
	
	@GetMapping("/selectOneDeptEmp.do")
	@ResponseBody
	public Map<String, Object> selectOneDeptEmp(@RequestParam(value="depNo") String param) {
		Map<String, Object> map = new HashMap<>();
		try {
			String depNo = param;
			log.debug(depNo);
			List<Employee> eList = elService.selectDeptEmpList(depNo);
			log.debug("eList={}",eList);
			
			//2. map에 요소 저장후 리턴
			map.put("eList", eList);
		} catch (Exception e) {
			log.error("emp목록 오류!");
		}
		return map;
	}
	
	@GetMapping("/selectSearch.do")
	@ResponseBody
	public Map<String, Object> selectSearch(@RequestParam Map<String, String> param) {
		Map<String, Object> map = new HashMap<>();
		try {
			Map<String, String> keyword = param;

			List<Employee> eList = elService.selectSearchList(keyword);
			log.debug("eList={}",eList);
			
			//2. map에 요소 저장후 리턴
			map.put("eList", eList);
		} catch (Exception e) {
			log.error("SearchEmp목록 오류!");
		}
		return map;
	}
}
