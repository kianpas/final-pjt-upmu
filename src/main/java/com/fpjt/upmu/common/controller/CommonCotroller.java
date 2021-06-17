package com.fpjt.upmu.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;

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
}
