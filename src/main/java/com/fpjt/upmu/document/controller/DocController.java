package com.fpjt.upmu.document.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.common.util.HelloSpringUtils;
import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.document.model.service.DocService;
import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocForm;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.DocReply;
import com.fpjt.upmu.document.model.vo.Document;
import com.fpjt.upmu.document.model.vo.MultiDocLine;
import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.notice.model.service.NoticeService;
import com.fpjt.upmu.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/document")
public class DocController {
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private DocService docService;
	
	@GetMapping("/myDocList")
	public String myDocList(
			@RequestParam int empNo,
			@RequestParam(required = true, defaultValue = "1") int cpage, 
			HttpServletRequest request,
			Model model
			) {

		final int limit = 10; 
		final int offset = (cpage-1)*limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		param.put("empNo", empNo);
		
		List<Document> docList = docService.selectDocumentList(param);

		model.addAttribute("docList", docList);
		
		//===========pageBar시작===============
		int totalContents = docService.selectDocCount(param);
		String url = request.getRequestURI()+"?empNo="+empNo;
		String pageBar = UpmuUtils.getMvcPageBar(cpage, limit, totalContents, url);
		model.addAttribute("pageBar",pageBar);
		//============pageBar끝===============
		log.debug("totalContents ={}",totalContents);
		
		return "document/docList";
	}
	
	@GetMapping("/adminDocList")
	public String adminDocList(
			@RequestParam(required = true, defaultValue = "1") int cpage, 
			HttpServletRequest request,
			Model model
			) {
		final int limit = 10; 
		final int offset = (cpage-1)*limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		List<Document> docList = docService.selectDocumentList(param);

		model.addAttribute("docList", docList);
		
		//===========pageBar시작===============
		int totalContents = docService.selectDocAllCount(param);
		String url = request.getRequestURI();
		String pageBar = UpmuUtils.getMvcPageBar(cpage, limit, totalContents, url);
		model.addAttribute("pageBar",pageBar);
		//============pageBar끝===============
		log.debug("totalContents ={}",totalContents);
		
		return "document/docList";
	}
	
	
	@PostMapping("/docDelete")
	public String docDelete(@RequestParam int docNo) {
		
		int result = docService.deleteDocument(docNo);
		return "redirect:/document/docForm";
	}
	
	@GetMapping("/docMenu")
	public String docMenu(Authentication authentication, Model model) {
		Employee principal = (Employee) authentication.getPrincipal();
		Map<String, Object> param = new HashMap<>();
		param.put("id", principal.getEmpNo());

		Map<String,Object> menuCounter = new HashMap<>();
		param.put("status", "notdecided");
		menuCounter.put("notdecided", docService.selectDocCount(param));
		param.put("status", "approved");
		menuCounter.put("approved", docService.selectDocCount(param));
		param.put("status", "completed");
		menuCounter.put("completed", docService.selectDocCount(param));
		param.put("status", "afterview");
		menuCounter.put("afterview", docService.selectDocCount(param));
		param.put("status", "rejected");
		menuCounter.put("rejected", docService.selectDocCount(param));

		model.addAttribute("menuCounter", menuCounter);
		return "document/docMenu";
	}
	
	@GetMapping("/docMain")
	public String docMain(Authentication authentication, Model model) {
		
		try {
			if(authentication != null) {
				Employee principal = (Employee) authentication.getPrincipal();
				
				Map<String, Object> param = new HashMap<>();
				param.put("id", principal.getEmpNo());

				Map<String,Object> menuCounter = new HashMap<>();
				param.put("status", "notdecided");
				menuCounter.put("notdecided", docService.selectDocCount(param));
				param.put("status", "approved");
				menuCounter.put("approved", docService.selectDocCount(param));
				param.put("status", "completed");
				menuCounter.put("completed", docService.selectDocCount(param));
				param.put("status", "afterview");
				menuCounter.put("afterview", docService.selectDocCount(param));
				param.put("status", "rejected");
				menuCounter.put("rejected", docService.selectDocCount(param));

				model.addAttribute("menuCounter", menuCounter);		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "document/docMain";
	}
	

	
	@GetMapping("/docList")
	public String docList(
			@RequestParam int empNo, 
			@RequestParam String type, 
			@RequestParam(required = true, defaultValue = "1") int cpage, 
			HttpServletRequest request,
			Model model
			) {
		//paging
		//final int cpage = 1;	//임시값
		
		final int limit = 10; 
		final int offset = (cpage-1)*limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		
		//홍길동의 사번은 1, 이 메소드는 approver를 검색.
		int id = empNo;
		param.put("id", id);
		param.put("status", type);
		
		List<String> docNoList = docService.selectDocNo(param);
		
		List<Document> docList = new ArrayList<>();
		for (String docNo : docNoList) {
			param.put("docNo", docNo);
			docList.add(docService.selectOneDocumentByParam(param));
		}
		model.addAttribute("docList", docList);
		
		//===========pageBar시작===============
		int totalContents = docService.selectDocCount(param);
		String url = request.getRequestURI()+"?empNo="+empNo+"&type="+type;
		String pageBar = UpmuUtils.getMvcPageBar(cpage, limit, totalContents, url);
		model.addAttribute("pageBar",pageBar);
		//============pageBar끝===============
		log.debug("totalContents ={}",totalContents);
		
		return "document/docList";
	}
//	여기수정중
	@GetMapping("/docDetail")
	public String docDetail(@RequestParam String docNo,
			Authentication authentication,
			Model model,
			RedirectAttributes redirectAttr
			) {
		
		try {
			Document document = docService.selectOneDocument(docNo);
			log.debug("document = {}",document);
			if(document==null) {
				redirectAttr.addFlashAttribute("msg", "해당하는 문서가 존재하지 않습니다.");
				return "redirect:/document/docForm";
			}
			//로그인한 사번이 기안자 사번과 같거나 결재선 사번중에 포함될 경우에만 정상작동. 그 외에는 헤더로 보내든 어디로 보내든...
			Employee principal = (Employee) authentication.getPrincipal();
			int flag = 0;
			if(principal.getEmpNo()==document.getWriter()) {
				flag=1;
			}
			for (DocLine docLine : document.getDocLine()) {
				if(principal.getEmpNo()==docLine.getApprover()) {
					flag=1;
				}
			}
			//관리자 권한이 있을 경우에는 return안하도록.
			boolean authorized = principal.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"));
			if(!authorized) {
				if(flag==0) {
					redirectAttr.addFlashAttribute("msg", "해당 문서에 접근할 권한이 없습니다.");
					return "redirect:/document/docForm";
				}
			}
			
			List<DocAttach> docAttachList = docService.selectDocAttachList(docNo);
			log.debug("docAttachList = {}",docAttachList);
			
			List<DocReply> docReplyList = docService.selectDocReplyList(docNo);
			log.debug("docReplyList = {}",docReplyList);

			model.addAttribute("document", document);
			model.addAttribute("docAttachList", docAttachList);
			model.addAttribute("docReplyList", docReplyList);
			
			return "document/docDetail";
		} catch (Exception e) {
			log.error("문서 로딩 실패!",e);
			throw e;
		}
	}


	@PostMapping("/docDetail")
	public String updateDocDetail(
			@ModelAttribute DocLine docLine,
			Model model){
		try {
			int result = 0;

			result = docService.updateMyDocLineStatus(docLine);
				result = docService.updateOthersDocLineStatus(docLine);

			return "redirect:/document/docDetail?docNo="+docLine.getDocNo();
		} catch (Exception e) {
			log.error("수정 실패!",e);
			throw e;
		}
	}

	@GetMapping("/docForm")
	public String docForm(Model model){
		
		List<DocForm> docFormList = docService.selectDocFormList();
		
		model.addAttribute("docFormList", docFormList);
		
		return "document/docForm";
	}
	
//	docNo
//	title
//	writer
//	docLine<-input으로 값들 넣어줌
//	content
	@PostMapping("/docInsert")
	public String docInsert(
			@ModelAttribute Document document,
			@ModelAttribute MultiDocLine docLines,
			@RequestParam(name = "upFile") MultipartFile[] upFiles,
			RedirectAttributes redirectAttr
			) throws Exception{
		try {
			List<DocLine> lineList = new ArrayList<>();
			for (DocLine docLine : docLines.getDocLines()) {
				//approver, agreer는 notdecided
				if("approver".equals(docLine.getApproverType()) || "agreer".equals(docLine.getApproverType())) {
					docLine.setStatus("notdecided");
				}
				//enforcer, referer는 afterview
				if("enforcer".equals(docLine.getApproverType()) || "referer".equals(docLine.getApproverType())) {
					docLine.setStatus("afterview");
				}
				lineList.add(docLine);
				
				log.debug("docLine = {}", docLine);
			}
			document.setDocLine(lineList);
			log.debug("document = {}", document);
			
			
			//첨부파일 DocAttach
			String saveDirectory = application.getRealPath("/resources/upload/document");
			log.debug("saveDirectory = {}", saveDirectory);
			
			//디렉토리 생성
			File dir = new File(saveDirectory);
			if(!dir.exists()) {
				dir.mkdirs(); //복수개의 디렉토리를 생성
			}
			List<DocAttach> attachList = new ArrayList<>();
			for(MultipartFile upFile : upFiles) {
				//input[name=upFile]로부터 비어있는 upFile이 넘어온다면
				if(upFile.isEmpty()) continue;
				
				String renamedFilename = 
						HelloSpringUtils.getRenamedFilename(upFile.getOriginalFilename());
				//a.서버컴퓨터에 저장
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); //파일이동
				
				//b.저장된 데이터를 DocAttach객체에 저장 및 list 추가
				DocAttach attach = new DocAttach();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
			}
			
			log.debug("attachList = {}", attachList);
			//board객체에 설정
			//board.setAttachList(attachList);

			int result = 0;
			//result = docService.insertDocument(document);
			result = docService.insertDocument(document,attachList);

			return "redirect:/document/docDetail?docNo="+document.getDocNo();
			//return "/document/docMain";
		} catch (Exception e) {
			log.error("문서 입력 실패!",e);
			throw e;
		}
	}
	
	/**
	 * ResponseEntity
	 * 1. status code 커스터마이징
	 * 2. 응답 header 커스터마이징
	 * 3. @ResponseBody 기능 포함
	 * @param no
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@GetMapping("/fileDownload.do")
	public ResponseEntity<Resource> fileDownloadWithResponseEntity(
			@RequestParam int no
			) throws UnsupportedEncodingException{
		ResponseEntity<Resource> responseEntity;
		
		try {
			//1. 업무로직 : db조회
			DocAttach attach = docService.selectOneAttachment(no);
			if(attach ==null) {
				return ResponseEntity.notFound().build();
			}
			
			//2. Resource객체
			String saveDirectory = application.getRealPath("/resources/upload/document");
			File downFile = new File(saveDirectory, attach.getRenamedFilename());
			Resource resource = resourceLoader.getResource("file:"+downFile);
			String filename = new String(attach.getOriginalFilename().getBytes("utf-8"),"iso-8859-1");
			
			//3. ResponseEntity객체 생성 및 리턴
			//builder패턴
			responseEntity = ResponseEntity
				.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
				.header(HttpHeaders.CONTENT_DISPOSITION,"attachment;filename="+filename)
				.body(resource);
		} catch (Exception e) {
			log.error("파일 다운로드 오류",e);
			throw e;
		}
		
		return responseEntity;
	}
	
	@PostMapping("/docReply")
	public String insertReply(@ModelAttribute DocReply docReply, Model model){
		try {
			int result = 0;
			log.debug("docReply = {}",docReply);
			result = docService.insertReply(docReply);

			return "redirect:/document/docDetail?docNo="+docReply.getDocNo();
		} catch (Exception e) {
			log.error("댓글 입력 실패!",e);
			throw e;
		}

	}
	
	@GetMapping("/docFormSelect")
	public ResponseEntity<DocForm> docFormatSelect(@RequestParam String no) {
		try {
			DocForm docForm = docService.selectOneDocForm(no);
			log.debug("document = {}",docForm);
			if(docForm != null) {
				return ResponseEntity.
							ok()
							.body(docForm);
			}
			else {
				return ResponseEntity
							.notFound()
							.build();
			}
		} catch (Exception e) {
			log.error("문서양식 조회 오류 : "+no,e);
			throw e;
		}
	}

	@GetMapping("/docFormEdit")
	public String DocFormEdit(Model model){
		List<DocForm> docFormList = docService.selectDocFormList();
		
		model.addAttribute("docFormList", docFormList);
		
		return "document/docFormEdit";
	}
	
	@PostMapping("/docFormEdit")
	public String insertDocFormEdit(
			@ModelAttribute DocForm docForm,
			RedirectAttributes redirectAttr
			){
		
		int result = docService.updateDocForm(docForm);
		
		redirectAttr.addFlashAttribute("msg","양식 수정 성공!");

		return "redirect:/document/docFormEdit";
	}
	
	@GetMapping("/docFormAdd")
	public String docFormAdd(){
		return "document/docFormAdd";
	}
	
	@PostMapping("/docFormAdd")
	public String InsertDocFormAdd(
			@ModelAttribute DocForm docForm,
			RedirectAttributes redirectAttr
			){
		
		int result = docService.insertDocForm(docForm);

		redirectAttr.addFlashAttribute("msg","양식 추가 성공!");

		return "redirect:/document/docFormAdd";
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
