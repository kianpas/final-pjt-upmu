package com.fpjt.upmu.employeeList.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/employeeList")
public class EmployeeListController {

	@Autowired
	EmployeeListService elService;
	
	//부서목록 불러오기
	@GetMapping("/eList")
	public void mList(Model model) {	
		try {
			List<Department> dList = elService.selectDeptList();
			model.addAttribute("dList", dList);
		} catch (Exception e) {
			log.error("부서목록 오류!");
		}
	}
	
	//부서 등록
	@PostMapping("/departEnroll.do")
	public String departEnroll(Department dept) {
		try {			
			int result = elService.insertDept(dept);
		} catch (Exception e) {
			log.error("부서등록 오류!");
		}
		return "redirect:/redirect:/admin/eListAdmin.do";
	}
	
	//부서에 따른 조직원 조회
	@GetMapping("/selectOneDeptEmp.do")
	@ResponseBody
	public Map<String, Object> selectOneDeptEmp(@RequestParam(value="depNo") String param) {
		Map<String, Object> map = new HashMap<>();
		try {
			String depNo = param;
			List<Employee> eList = elService.selectDeptEmpList(depNo);
			
			//2. map에 요소 저장후 리턴
			map.put("eList", eList);
		} catch (Exception e) {
			log.error("emp목록 오류!");
		}
		return map;
	}
	
	//조직원 검색
	@GetMapping("/selectSearch.do")
	@ResponseBody
	public Map<String, Object> selectSearch(@RequestParam Map<String, String> param) {
		Map<String, Object> map = new HashMap<>();
		try {
			Map<String, String> keyword = param;
			
			if(keyword.get("getSearch") == "") {
				return map; 
			}
			List<Employee> eList = elService.selectSearchList(keyword);
			log.debug("eList={}",eList);
			
			//2. map에 요소 저장후 리턴
			map.put("eList", eList);
		} catch (Exception e) {
			log.error("SearchEmp목록 오류!");
		}
		return map;
	}
	
	//부서 삭제
	@GetMapping("/deleteDept.do")
	public String deleteDept(@RequestParam(value = "depNo") String param) {
		try {			
			int result = elService.deleteDept(param);
		} catch (Exception e) {
			log.error("부서삭제 오류!");
		}
		return "redirect:/admin/eListAdmin.do";
	}
	
	//부서 업데이트 창 띄우기
	@GetMapping("/modifyPop")
	public void modifyPop() {}
	
	//부서 업데이트
	@PostMapping("/modifyDept.do")
	public String modifyDept(Department dep, String modifyDept) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("dep", dep);
			map.put("modifyDept", modifyDept);
			
			int result = elService.updateDept(map);
		} catch (Exception e) {
			log.error("부서등록 오류!");
		}
		return "redirect:/employeeList/close";
	}
	
	//부서 업데이트 시 팝업창 닫는 용도
	@GetMapping("/close")
	public void close() {}
  
	//Choims added
	@GetMapping("/eListForDoc")
	public void mListForDoc(Model model) {	
		try {
			List<Department> dList = elService.selectDeptList();
			model.addAttribute("dList", dList);
		} catch (Exception e) {
			log.error("부서목록 오류!");
		}
	}
}
