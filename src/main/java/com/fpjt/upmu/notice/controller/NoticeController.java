package com.fpjt.upmu.notice.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpjt.upmu.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
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

}
