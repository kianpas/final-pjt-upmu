package com.fpjt.upmu.document.controller;

import java.beans.PropertyEditor;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fpjt.upmu.document.model.service.DocService;
import com.fpjt.upmu.document.model.vo.Document;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/document")
public class DocController {
	
	@Autowired
	private DocService docService;
	
	@GetMapping("/docList.do")
	public String docList() {
		log.info("test");
		List<Document> docList = docService.selectDocList();
		log.info("docList = {}", docList);
		
		return "document/docList";
	}

	
	/**
	 * java.sql.Date, java.util.Date 필드에 값 대입시
	 * 사용자 입력값이 ""인 경우, null로 처리될 수 있도록 설정.
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		//org.springframework.beans.propertyeditors.CustomDateEditor.CustomDateEditor(DateFormat dateFormat, boolean allowEmpty)
		PropertyEditor editor = new CustomDateEditor(format,true); //빈 문자열을 허용하겠다는 뜻.
		binder.registerCustomEditor(Date.class, editor);
	}
}
