package com.fpjt.upmu.document.controller;

import java.beans.PropertyEditor;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpjt.upmu.document.model.service.DocService;
import com.fpjt.upmu.document.model.vo.DocLine;
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
	

	
	@GetMapping("/docList")
	public String docList(@RequestParam String type, Model model) {
		//홍길동의 사번은 1, 이 메소드는 approver를 검색.
		int id = 1;
		
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("status", type);
		
		List<String> docNoList = docService.selectDocNo(param);
		List<Document> docList = new ArrayList<>();
		
		for (String docNo : docNoList) {
			param.put("docNo", docNo);
			docList.add(docService.selectOneDocumentByParam(param));
		}
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


	@PostMapping("/docDetail")
	public String updateMenu(
			@ModelAttribute DocLine docLine,
			Model model){
		try {
			int result = 0;
			//result = docService.updateDocument(param);

			result = docService.updateMyDocLineStatus(docLine);
			result = docService.updateOthersDocLineStatus(docLine);

			return "redirect:/document/docDetail?docNo="+docLine.getDocNo();
		} catch (Exception e) {
			log.error("수정 실패!",e);
			throw e;
		}
	}

	@GetMapping("/docForm")
	public String docForm(){
		return "document/docForm";
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
