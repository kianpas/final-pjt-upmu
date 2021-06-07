package com.fpjt.upmu.memberList.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/memberList")
public class MemberListController {

	@GetMapping("/mList")
	public void mList() {
		log.info("GET@mList요청");
	}
}
