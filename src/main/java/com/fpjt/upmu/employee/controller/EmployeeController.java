package com.fpjt.upmu.employee.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.employee.model.service.EmployeeService;
import com.fpjt.upmu.employee.model.vo.EmpProfile;
import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.service.EmployeeListService;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Job;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee")
@Slf4j
public class EmployeeController {

	@Autowired
	EmployeeListService elService;

	@Autowired
	EmployeeService empService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private ServletContext application;

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
	  
	  @GetMapping("/myProfile.do")
		public void myProfile(
								@RequestParam(value = "empNo") String empNo, 
								Principal principal, 
								Model model) {
			try {
				// principal employee객체로 변환
				Employee prinEmp = (Employee) ((Authentication) principal).getPrincipal();
				//자신의 프로필 외에는 접근 금지 시키기
				 if(!Integer.toString(prinEmp.getEmpNo()).equals(empNo)){ 
					 model.addAttribute("msg","자신의 프로필만 접근할 수 있습니다."); 
					 return;
				 }
							 
				Employee employee = elService.selectOneEmp(empNo);
				List<Department> dList = elService.selectDeptList();
				List<Job> jList = elService.selectJobList();
				String profile = empService.selectProfile(empNo);
				
				//프로필 사진 경로 불러오기
				
				String path = "/resources/upload/profile/" + profile;
				
				model.addAttribute("profile", path);
				model.addAttribute("dList", dList);
				model.addAttribute("jList", jList);
				model.addAttribute("employee", employee);
			} catch (Exception e) {
				log.error("프로필 오류!", e);
			}
		}

		@PostMapping("/myProfile.do")
		public String myProfile(
								@RequestParam(value = "empPw") String empPw,
								@RequestParam(value = "changePw") String changePw, 
								@RequestParam(value = "upFile") MultipartFile upFile,
								RedirectAttributes redirectAttr, 
								Employee employee) {

			String email = employee.getEmpEmail();
			Employee rawEmployee = empService.selectOneEmp(email);
			
			try {
				//프로필 사진 처리
				if(!upFile.isEmpty()) {

					//프로필 사진 저장 경로
					String saveDirectory = application.getRealPath("/resources/upload/profile");
					
					//이미지 파일만 걸러내기 .jpeg .jpg .png만 가능
					String originalFileName = upFile.getOriginalFilename();
					String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1, originalFileName.length());
					
					if(!(extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg"))) {
						redirectAttr.addFlashAttribute("msg", "올바른 이미지 파일이 아닙니다.");
						return "redirect:/common/myProfile.do?empNo=" + rawEmployee.getEmpNo();
					}
					
					String renamedFilename = UpmuUtils.getRenamedFilename(originalFileName);
					
					File dest = new File(saveDirectory, renamedFilename);
					upFile.transferTo(dest); // 파일이동
					
					EmpProfile profile = new EmpProfile();
					profile.setEmpNo(rawEmployee.getEmpNo());
					profile.setOriginalFilename(upFile.getOriginalFilename());
					profile.setRenamedFilename(renamedFilename);
					
					//프로필 사진 존재 여부 조회
					//비존재 시 'N'을 반환
					String profileName = empService.selectProfileName(rawEmployee.getEmpNo());
					System.out.println("profileName확인용 = " + profileName);

					//프로필 사진이 존재, 존재하지 않을 시 분기 처리
					int result;
					
					if(profileName.equals("N"))
						result = empService.insertProfile(profile);
					else {
						//원래 파일 삭제
						String filePath = application.getRealPath("/resources/upload/profile/" + profileName);
						File deleteFile = new File(filePath);
						deleteFile.delete();
						
						result = empService.updateProfile(profile);		
					}
				}
				
				// 비밀번호 변경 처리
				if (!empPw.isEmpty()) {
					if (bcryptPasswordEncoder.matches(empPw, rawEmployee.getEmpPw())) {
						String encodedPw = bcryptPasswordEncoder.encode(changePw);
						rawEmployee.setEmpPw(encodedPw);
					} else {
						redirectAttr.addFlashAttribute("msg", "현재 비밀번호가 틀립니다.");
						return "redirect:/common/myProfile.do?empNo=" + rawEmployee.getEmpNo();
					}
				}

				// Employee객체들끼리 비교를 위해 맵에 담는다.
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
				
				//맵키셋
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
					// 내 정보를 업데이트
					redirectAttr.addFlashAttribute("msg", "정보 수정을 성공했습니다.");
					empService.updateEmp(rawEmp);
				}
			} catch (Exception e) {
				log.error("내 정보 업데이트 오류!", e);
			}
			return "redirect:/common/myProfile.do?empNo=" + rawEmployee.getEmpNo();
		}
}
