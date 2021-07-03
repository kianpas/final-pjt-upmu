package com.fpjt.upmu.admin.controller;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.employee.model.service.EmployeeService;
import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.vo.Job;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	EmployeeListService elService;
	
	@Autowired
	EmployeeService empService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//부서목록 불러오기
	@GetMapping("/eListAdmin.do")
	public void eListAdmin(Model model) {	
		try {
			List<Department> dList = elService.selectDeptList();
			model.addAttribute("dList", dList);
		} catch (Exception e) {
			log.error("부서목록 오류!");
		}
	}
	
	@GetMapping("/adminProfile")
	public void adminProfile(
							@RequestParam(value = "empNo") String param, 
							Model model) {
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
	
	@PostMapping("/adminProfile")
	public String adminProfile(
							@RequestParam(value = "changePw") String changePw, 
							RedirectAttributes redirectAttr, 
							Employee employee) {

		String email = employee.getEmpEmail();
		Employee rawEmployee = empService.selectOneEmp(email);

		// 비밀번호값이 들어올 경우 처리
		if (changePw != "") {
				String encodedPw = bcryptPasswordEncoder.encode(changePw);
				rawEmployee.setEmpPw(encodedPw);
		}
		
		// Employee객체들끼리 비교를 위해 맵에 담는다.
		try {
			Map<String, Object> emp = new HashMap<>();
			Map<String, Object> rawEmp = new HashMap<>();

			for (Field field : employee.getClass().getDeclaredFields()) {
				field.setAccessible(true);
				Object value;
				value = field.get(employee);
				emp.put(field.getName(), value);
			}
			for (Field field : rawEmployee.getClass().getDeclaredFields()) {
				field.setAccessible(true);
				Object value;
				value = field.get(rawEmployee);
				rawEmp.put(field.getName(), value);
			}
			Set<String> aKeys = emp.keySet();
			Set<String> bKeys = rawEmp.keySet();

			// 두개 맵의 키를 동일하게 갖고왔어도 한번 더 equals로 확인
			if (bKeys.equals(aKeys)) {
				for (String key : bKeys) {
					// 두 맵의 키를 이용하여 값들을 비교
					// 변경불가값들
					if (key == "empNo" || key == "empPw" || key == "empState" || key == "authorities") {
						break;
					}
					// 비교하여 값을 바꿔줌
					else if (!(emp.get(key)).equals(rawEmp.get(key))) {
						rawEmp.put(key, emp.get(key));
					}
					rawEmp.put("empDept", emp.get("empDept"));
				}
				// 내 정보를 없데이트
				empService.updateEmp(rawEmp);
			}
		} catch (IllegalArgumentException | IllegalAccessException e) {
			log.error("내 정보 업데이트 오류!");
		}
		return "redirect:/admin/adminProfile.do?empNo=" + rawEmployee.getEmpNo();
	}
	
	@PostMapping("/empDelete.do")
	public void empDelete(@RequestParam(value = "empEmail") String empEmail) {
		empService.deleteEmp(empEmail);
	}
}
