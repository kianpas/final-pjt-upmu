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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.employee.model.service.EmployeeService;
import com.fpjt.upmu.employeeList.model.vo.Employee;

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
	public void EmpLogin(
				@SessionAttribute(required = false) String next,
				@RequestHeader(name = "Referer", required = false) String referer, 
				Model model) {
		log.info("referer = {}", referer);
		log.info("next = {}", next);
		if(next == null && referer != null)
			model.addAttribute("next", referer); // sessionScope에 저장
	}
	
	@GetMapping("/empEnroll.do")
	public void EmpEnroll(
				@SessionAttribute(required = false) String next,
				@RequestHeader(name = "Referer", required = false) String referer, 
				Model model) {
		log.info("referer = {}", referer);
		log.info("next = {}", next);
		if(next == null && referer != null)
			model.addAttribute("next", referer); // sessionScope에 저장
	}
	
	@PostMapping("/empEnroll.do")
	public String EmployeeEnroll(Employee employee, RedirectAttributes redirectAttr) {

		try {
			log.info("Employee = {}", employee);
			//0. 비밀번호 암호화처리
			String rawPassword = employee.getEmpPw();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			employee.setEmpPw(encodedPassword);
			log.info("Employee(암호화처리이후) = {}", employee);
			
			//1. 업무로직
			int result = empService.insertEmployee(employee);
			//2. 사용자피드백
			redirectAttr.addFlashAttribute("msg", "회원가입성공");
		} catch (Exception e) {
			log.error("회원가입 오류!", e);
		}
		return "redirect:/";
	}
	
	@GetMapping("/checkIdDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate(@RequestParam String id) {
		Employee employee = empService.selectOneEmp(id);
		boolean available = (employee == null);
		
		Map<String, Object> map = new HashMap<>();
		map.put("available", available);
		map.put("id", id);
		
		return ResponseEntity
				.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
				.body(map);
	}
	
	@GetMapping("/jusoPopup.do")
	public void jusoPopup() {
		
	}
	
	@PostMapping("/jusoPopup.do")
	public void jusoPost() {
		
	}
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//		PropertyEditor editor = new CustomDateEditor(format, true);
//		binder.registerCustomEditor(Date.class, editor);
//	}
//	
//	@PostMapping("/EmployeeLogin.do")
//	public String EmployeeLogin(
//					@RequestParam int emp_no, 
//					@RequestParam String password,
//					@SessionAttribute(required = false) String next,
//					Model model,
//					RedirectAttributes redirectAttr) {
//		
//		//1. 업무로직
//		Employee Employee = EmployeeService.selectOneEmployee(emp_no);
//		log.info("Employee = {}", Employee);
////		log.info("encryptedPassword = {}", bcryptPasswordEncoder.encode(password));
//		
//		
//		//2. 로그인여부 분기처리
//		if(Employee != null && bcryptPasswordEncoder.matches(password, Employee.getEmp_pw())) {
//			// 로그인 성공
//			// loginEmployee 세션속성으로 저장하려면, class에 @SessionAttributes로 등록
//			model.addAttribute("loginEmployee", Employee);
//			//사용한 next값은 제거
//			model.addAttribute("next", null);
//		}
//		else {
//			// 로그인 실패
//			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
//			return "redirect:/Employee/EmployeeLogin.do";
//		}
//		
//		
//		return "redirect:" + (next != null ? next : "/");
//	}
//	
//	@GetMapping("/EmployeeLogout.do")
//	public String EmployeeLogout(SessionStatus status) {
//		if(!status.isComplete())
//			status.setComplete();
//		return "redirect:/";
//	}
//	
//	@GetMapping("/EmployeeDetail.do")
//	public ModelAndView EmployeeDetail(ModelAndView mav, @SessionAttribute(name = "loginEmployee") Employee loginEmployee) {
//		log.info("loginEmployee = {}", loginEmployee);
//		//속성 저장
//		mav.addObject("time", System.currentTimeMillis());
//		//viewName 설정
//		mav.setViewName("Employee/EmployeeDetail");
//		return mav;
//	}
//	
//	@PostMapping("/EmployeeUpdate.do")
//	public ModelAndView EmployeeUpdate(
//								@ModelAttribute Employee Employee,
//								@ModelAttribute("loginEmployee") Employee loginEmployee,
//								ModelAndView mav, 
//								HttpServletRequest request
//							) {
//		log.debug("Employee = {}", Employee);
//		log.debug("loginEmployee = {}", loginEmployee);
//		
//		try {
//			int result = EmployeeService.updateEmployee(Employee);
//			
//			
//			//리다이렉트시 자동생성되는 queryString 방지
//			RedirectView view = new RedirectView(request.getContextPath() + "/Employee/EmployeeDetail.do");
//			view.setExposeModelAttributes(false);
//			mav.setView(view);
//			
//			
//			//ModelAndView와 RedirectAttributes 충돌시 FlashMap을 직접 사용
//			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
//			flashMap.put("msg", "사용자 정보 수정 성공!!!!!!");
////			redirectAttr.addFlashAttribute("msg", "사용자 정보 수정 성공!");
//			
//		} catch (Exception e) {
//			log.error("사용자 정보 수정 오류!", e);
//			throw e;
//		}
//		return mav;
//	}
//	

}




