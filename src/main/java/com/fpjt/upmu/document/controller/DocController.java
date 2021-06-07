package com.fpjt.upmu.document.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fpjt.upmu.document.model.service.DocService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/document")
public class DocController {
	
	@Autowired
	private DocService docService;
	
	@GetMapping("/docList.do")
	public String docList() {
		log.debug("테스트");
		return "document/docList";
	}

}
