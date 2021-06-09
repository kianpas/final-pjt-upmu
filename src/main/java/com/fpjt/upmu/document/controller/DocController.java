package com.fpjt.upmu.document.controller;

import java.beans.PropertyEditor;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpjt.upmu.document.model.service.DocService;
import com.fpjt.upmu.document.model.vo.Document;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/document")
public class DocController {
	
	@Autowired
	private DocService docService;
	
	@GetMapping("/docMain")
	public String docMain() {
		return "document/docMain";
	}
	
	@GetMapping("/{approverType}")
	public String docList(@PathVariable String approverType, Model model) {
		//홍길동의 사번은 1, 이 메소드는 approver를 검색.
		int id = 1;
		//String approverType = "approver";
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("approverType", approverType);
		
		List<Document> docList = docService.selectDocList(param);
		log.debug("docList = {}",docList);
		model.addAttribute("docList", docList);
		
		return "document/docList";
	}
	
	@GetMapping("/docDetail")
	public String docDetail(@RequestParam String docNo, Model model) {
		
		Document document = docService.selectOneDocument(docNo);
		log.debug("document = {}",document);

		model.addAttribute("document", document);
		
		return "document/docDetail";
	}

	
	/**
	 * java.sql.Date, java.util.Date 필드에 값 대입시
	 * 사용자 입력값이 ""인 경우, null로 처리될 수 있도록 설정.08
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
