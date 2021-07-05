package com.fpjt.upmu.attendance.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fpjt.upmu.address.model.vo.AddressExt;
import com.fpjt.upmu.attendance.model.service.AttendanceService;
import com.fpjt.upmu.attendance.model.vo.Attendance;
import com.fpjt.upmu.attendance.model.vo.AttendanceExt;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/attendance")
public class AttendanceController {

	@Autowired
	private AttendanceService attendanceService;

	@GetMapping("/attendanceManage.do")
	public ModelAndView attendanceManage(ModelAndView mav) {
		mav.setViewName("/attendance/attendanceManage");
		return mav;
	}

	// 업무 시작
	@GetMapping("/startWork/{empNo}")
	public int startWork(@PathVariable int empNo) {
		try {
			log.debug("empNo {}", empNo);
			int result = attendanceService.startWork(empNo);
			return result;
		} catch (Exception e) {
			log.error("출근 입력 오류", e);
			throw e;
		}

	}

	// 업무 종료
	@GetMapping("/endWork/{empNo}")
	public int endWork(@PathVariable int empNo) {
		try {
			log.debug("empNo {}", empNo);
			int result = attendanceService.endWork(empNo);
			return result;
		} catch (Exception e) {
			log.error("퇴근 입력 오류", e);
			throw e;
		}

	}

	// 주간 근무
	@GetMapping("/workHour")
	public List<AttendanceExt> workHourList(@RequestParam int empNo, @RequestParam int startOfWeek,
			@RequestParam int endOfWeek) {
		try {
			log.debug("empNo {}, startOfWeek {}", empNo, startOfWeek);
			log.debug("endOfWeek {}", endOfWeek);
			Map<String, Object> map = new HashMap<>();
			map.put("empNo", empNo);
			map.put("startOfWeek", startOfWeek);
			map.put("endOfWeek", endOfWeek);

			List<AttendanceExt> weekHourList = attendanceService.weekHourList(map);
			log.debug("weekHourList {}", weekHourList);
			return weekHourList;

		} catch (Exception e) {
			log.error("시간 조회 오류", e);
			throw e;
		}

	}

	// 근태내역테이블 조회
	@GetMapping("/workTable")
	public List<Attendance> selectWorkTable(@RequestParam int empNo, @RequestParam String search) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("empNo", empNo);
			map.put("search", search);

			List<Attendance> list = attendanceService.selectWorkList(map);

			return list;
		} catch (Exception e) {
			log.error("근무 내역 조회 오류", e);
			throw e;
		}
	}

	@GetMapping("/attendanceDuplicate")
	public Map<String, Object> checkAttendDuplicate(@RequestParam String checkDate, @RequestParam int empNo)
			throws Exception {

		try {
			// 1. 업무로직
			log.debug("checkDate {}, empNo {}", checkDate, empNo);
			Map<String, Object> map = new HashMap<>();
			map.put("checkDate", checkDate);
			map.put("empNo", empNo);
			AttendanceExt attExt = attendanceService.selectOneAttendance(map);

			boolean available = attExt == null;

			// 2. Map에 속성 저장
			Map<String, Object> map2 = new HashMap<>();
			map2.put("available", available);
			map2.put("attExt", attExt);

			return map2;
		} catch (Exception e) {
			log.error("주소록 중복 확인 오류!", e);
			throw e;
		}
	}
}
