package com.fpjt.upmu.admin.controller;

import java.io.File;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
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
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	EmployeeListService elService;
	
	@Autowired
	EmployeeService empService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private ServletContext application;
	
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
			String profile = empService.selectProfile(param);
			
			//프로필 사진 경로 불러오기
			String path = "/resources/upload/profile/" + profile;
			
			model.addAttribute("profile", path);
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
							@RequestParam(value = "upFile") MultipartFile upFile,
							@RequestParam(value = "empAuth") String empAuth,							
							RedirectAttributes redirectAttr, 
							Employee employee) {

		String email = employee.getEmpEmail();
		Employee rawEmployee = empService.selectOneEmp(email);

		try {			
			if(empAuth.equals("ADMIN"))
				empService.insertAuth(email);
			else
				empService.deleteAuth(email);
		} catch (Exception e) {
			log.error("error",e);
		}
		try {
			
			//프로필 사진 처리
			if(!upFile.isEmpty()) {

				//프로필 사진 저장 경로
				String saveDirectory = application.getRealPath("/resources/upload/profile");
				
				
				//이미지 파일만 걸러내기 .jpeg .jpg .png만 가능
				String originalFileName = upFile.getOriginalFilename();
				String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1, originalFileName.length());
				
				if(!(extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg"))) {
					System.out.println(extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg"));
					System.out.println(!extension.equals("png"));
					System.out.println(extension.equals("png"));
					redirectAttr.addFlashAttribute("msg", "올바른 이미지 파일이 아닙니다.");
					return "redirect:/common/myProfile.do?empNo=" + rawEmployee.getEmpNo();
				}
				
				File dir = new File(saveDirectory);
				if(!dir.exists())
					dir.mkdirs(); // 복수개의 디렉토리를 생성
				
				String renamedFilename = UpmuUtils.getRenamedFilename(originalFileName);
				
				// a.서버컴퓨터에 저장
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); // 파일이동
				
				// b.저장된 데이터를 Attachment객체에 저장 및 list에 추가
				EmpProfile profile = new EmpProfile();
				profile.setEmpNo(rawEmployee.getEmpNo());
				profile.setOriginalFilename(upFile.getOriginalFilename());
				profile.setRenamedFilename(renamedFilename);
				
				//프로필 사진 존재 여부 조회
				//비존재 시 'N'을 반환
				String profileName = empService.selectProfileName(rawEmployee.getEmpNo());
				// 2. 업무로직 : db저장 board, attachment
				//프로필 사진이 존재, 비존재 시 분기 처리
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
			
			// 비밀번호값이 들어올 경우 처리
			if (!changePw.isEmpty()) {
					String encodedPw = bcryptPasswordEncoder.encode(changePw);
					rawEmployee.setEmpPw(encodedPw);
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
		} catch (Exception e) {
			log.error("내 정보 업데이트 오류!", e);
		}
		return "redirect:/admin/adminProfile.do?empNo=" + rawEmployee.getEmpNo();
	}
	
	@PostMapping("/empDelete.do")
	public void empDelete(@RequestParam(value = "empEmail") String empEmail) {
		empService.deleteEmp(empEmail);
	}
}
