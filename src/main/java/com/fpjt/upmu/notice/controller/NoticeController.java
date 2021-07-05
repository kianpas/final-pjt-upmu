package com.fpjt.upmu.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.notice.model.service.NoticeService;
import com.fpjt.upmu.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/noticeBtn")
	public String example(Authentication authentication, Model model) {
		Employee principal = (Employee) authentication.getPrincipal();
		int empNo = principal.getEmpNo();
		
		List<Notice> noticeList = noticeService.selectNoticeList(empNo);
		int noticeCount = noticeService.countNoticeList(empNo);
	
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeCount", noticeCount);
		return "notice/noticeBtn";
	}	
	
	@DeleteMapping("/deleteNotice")
	public ResponseEntity<?> deleteNotice(@RequestParam int no){
		try {
			log.debug("no = {}", no);
			int result = noticeService.deleteNotice(no);
			
			if(result > 0) {
				Map<String, Object> map = new HashMap<>();
				map.put("msg", "알림 삭제 성공!");
				
				return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
		} catch (Exception e) {
			log.error("알림 삭제 실패!",e);
			throw e;
		}
	}
	
	@PutMapping("/updateNotice")
	public ResponseEntity<?> updateNotice(@RequestParam int no){
		try {
			log.debug("no = {}", no);
			int result = noticeService.updateNotice(no);
			
			if(result > 0) {
				Map<String, Object> map = new HashMap<>();
				map.put("msg", "알림 수정 성공!");
				
				return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
		} catch (Exception e) {
			log.error("알림 삭제 실패!",e);
			throw e;
		}
	}
	@DeleteMapping("/deleteNoticeList")
	public ResponseEntity<?> deleteNoticeList(
			@RequestParam int empNo,
			@RequestParam(required = false) String checked
			){
		try {
			log.debug("empNo = {}", empNo);
			log.debug("checked = {}", checked);
			if(checked.equals("undefined"))
				checked=null;
			log.debug("checked = {}", checked);
			
			Map<String,Object> map = new HashMap<>();
			map.put("empNo",empNo);
			map.put("checked",checked);
			
			
			int result = noticeService.deleteNoticeList(map);

			Map<String, Object> map2 = new HashMap<>();
			if(result > 0) {
				map2.put("msg", "알림 삭제 성공!");
				return new ResponseEntity<Map<String,Object>>(map2, HttpStatus.OK);
			}
			else {
				//return new ResponseEntity<>(HttpStatus.NOT_FOUND);
				map2.put("msg", "해당하는 알림 없음");
				return new ResponseEntity<Map<String,Object>>(map2, HttpStatus.OK);
			}
			
		} catch (Exception e) {
			log.error("알림 삭제 실패!",e);
			throw e;
		}
	}	

}
