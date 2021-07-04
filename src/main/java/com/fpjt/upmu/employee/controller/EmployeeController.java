package com.fpjt.upmu.employee.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.employee.model.service.EmployeeService;
import com.fpjt.upmu.employee.model.vo.Employee;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee")
@Slf4j
public class EmployeeController {

	@Autowired
	private EmployeeService empService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@GetMapping("/empLogin.do")
	public void EmpLogin() {}

	@GetMapping("/empEnroll.do")
	public void EmpEnroll() {}

	@GetMapping("/empIdPwSearch.do")
	public void EmpIdPwdSearch() {}

	@GetMapping("/jusoPopup.do")
	public void jusoPopup() {}
	
	@GetMapping("/empPwSearch")
	public void empPwSearch() {}
	
	@PostMapping("/jusoPopup.do")
	public void jusoPost() throws Exception {}
	
	@PostMapping("/empEnroll.do")
	public String EmployeeEnroll(Employee employee, RedirectAttributes redirectAttr) {

		try {
			// 0. 비밀번호 암호화처리
			String rawPassword = employee.getEmpPw();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			employee.setEmpPw(encodedPassword);

			// 1. 업무로직
			int result = empService.insertEmployee(employee);
			result = empService.insertRole(employee.getEmpEmail());
			// 2. 사용자피드백
			redirectAttr.addFlashAttribute("msg", "회원가입성공");
		} catch (Exception e) {
			log.error("회원가입 오류!", e);
		}
		return "redirect:/";
	}

	@GetMapping("/checkIdDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate(@RequestParam String id) {
		Map<String, Object> map = new HashMap<>();
		try {
			Employee employee = empService.selectOneEmp(id);
			boolean available = (employee == null);
			
			map.put("available", available);
			map.put("id", id);			
		} catch (Exception e) {
			log.error("아이디 중복체크 오류!", e);
		}
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}
	 
	@PostMapping("/empIdSearch.do")
	public void empIdIdSearch(Employee employee, Model model) {
		String id = null;
		try {
			Map<String, String> emp = new HashMap<>();
			emp.put("empName", employee.getEmpName());
			emp.put("empPhone", employee.getEmpPhone() + "  ");
			
			id = empService.selectId(emp);
			
			if(id == null) 
				id = "아이디가 존재하지 않습니다.";
			
			model.addAttribute("id", id);
		} catch (Exception e) {
			log.error("아이디 찾기 오류!", e);
		}
	}
	
	@PostMapping("/mailPwSearch.do") 
	public void mailIdPwSearch(Employee employee, Model model) {
		log.debug("emppw = {}", employee); 
		String msg;
		Map<String, String> map = new HashMap<>();
		String id = employee.getEmpEmail();
		String no = empService.selectCheckId(id);
		
		try {
			//권한 중복 체크(중복 시 삭제)
			String checkId = empService.selectCheckPwSearch(id);
			
			if(checkId != null) {
				empService.deleteSearchPw(id);
			}
			//id체크
			if(no != null) {
				//패스워드 변경 권한 번호 생성
				int authRandNum = (int)(Math.random() + 1)*10000;
				String num = Integer.toString(authRandNum);
				String encodedNum = bcryptPasswordEncoder.encode(num);
				
				//권한 번호 DB저장
				map.put("num", encodedNum);
				map.put("id", id);
				int result = empService.insertPwSearch(map);
				
				//메일 보내기
				msg = empService.sendMail(id, encodedNum);
				model.addAttribute("msg", msg);
			}
			else {
				model.addAttribute("msg", "아이디가 존재하지 않습니다.");
			}
		} catch (Exception e) {
			log.error("비밀번호 찾기 오류!", e);
		}
	}
	
	  @PostMapping("/empPwSearch.do") 
	  public String empPwSearch(String empPw, String authVal, RedirectAttributes redirectAttr){		  
		log.debug(empPw); 
		log.debug(authVal); 
		// 0. 비밀번호 암호화처리
		String rawPassword = empPw;
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		
		try {
			// 1. 업무로직
			String id = empService.selectPwSearchId(authVal);
			log.debug(id);
			empService.deleteSearchPw(id);

			Map<String, String> map = new HashMap<>();
			map.put("pw", encodedPassword);
			map.put("id", id);
			
			int result = empService.updatePw(map);
			// 2. 사용자피드백
			redirectAttr.addFlashAttribute("msg", "비밀번호 재설정 완료");			
		} catch (Exception e) {
			log.error("비밀번호 찾기 후 재설정 오류", e);
			return "redirect:/common/accessDenied.do";
		}
		return "redirect:/";
	  }

	  @PostMapping("/upProfile.do")
	  public void upProfile() {
		  log.debug("성공성공");
	  }
}
