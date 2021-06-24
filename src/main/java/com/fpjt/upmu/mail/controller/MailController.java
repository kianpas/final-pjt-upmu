package com.fpjt.upmu.mail.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.mail.model.service.MailService;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailAttach;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mail")
@Slf4j
public class MailController {
	
	//합칠 수 있는건 합치기
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private MailService mailService;
	
	//받은 메일함 - user 2
	@GetMapping("/receiveMailList.do")
	public String receiveMailList(
				@RequestParam(required = true, defaultValue = "1") int cpage,
				HttpServletRequest request,
				Model model
			) {
		
		try {
			log.debug("cpage = {}", cpage);
			final int limit = 10;
			final int offset = (cpage - 1) * limit;
			Map<String, Object> param = new HashMap<>();
			param.put("limit", limit);
			param.put("offset", offset);

//			List<Mail> list = mailService.selectMailList(param, 사원번호);
			//	List<Mail> list = mailService.selectMailList1(param, 1); //test - user1
			List<Mail> list = mailService.selectMailList1(param, 2); //test - user2

//			int totalContents = mailService.selectMailTotalContents(사원번호);
			//int totalContents = mailService.selectMailTotalContents1(1); //test - user1
			int totalContents = mailService.selectMailTotalContents1(2); //test - user2
			
			String url = request.getRequestURI();
			
			log.debug("totalContents = {}, url = {}", totalContents, url);
			
			String pageBar = UpmuUtils.getPageBar(totalContents, cpage, limit, url);
			
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			
		} catch(Exception e) {
			log.error("받은 메일함 조회 오류!", e);
			throw e;
		}
		
		return "mail/receiveMailList";
	}
	
	//보낸 메일함 - user 1
	@GetMapping("/sendMailList.do")
	public String sendMailList(
				@RequestParam(required = true, defaultValue = "1") int cpage,
				HttpServletRequest request,
				Model model
			) {
		
		try {
			log.debug("cpage = {}", cpage);
			final int limit = 10;
			final int offset = (cpage - 1) * limit;
			Map<String, Object> param = new HashMap<>();
			param.put("limit", limit);
			param.put("offset", offset);

//			List<Mail> list = mailService.selectMailList(param, 사원번호);
			List<Mail> list = mailService.selectMailList2(param, 1); //test

//			int totalContents = mailService.selectMailTotalContents(사원번호);
			int totalContents = mailService.selectMailTotalContents2(1);
			String url = request.getRequestURI();
			
			log.debug("totalContents = {}, url = {}", totalContents, url);
			
			String pageBar = UpmuUtils.getPageBar(totalContents, cpage, limit, url);
			
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			
		} catch(Exception e) {
			log.error("보낸 메일함 조회 오류!", e);
			throw e;
		}
		
		return "mail/sendMailList";
	}
	
	//메일 보내기
	@GetMapping("/mailForm.do")
	public void mailForm() {}
	
	//메일 보내기(답장)
	@PostMapping("/mailForm.do")
	public void mailForm2() {}
	
	@PostMapping("/mailEnroll.do")
	public String mailEnroll(
				@ModelAttribute MailExt mail,
				@RequestParam(name = "upFile") MultipartFile[] upFiles,
				RedirectAttributes redirectAttr
			) throws Exception {
			
		try {
			log.debug("mail = {}", mail);

			String saveDirectory = application.getRealPath("/resources/upload/mail");
			log.debug("saveDirectory = {}", saveDirectory);
				
			File dir = new File(saveDirectory);
			if(!dir.exists())
				dir.mkdirs();
					
			List<MailAttach> attachList = new ArrayList<>();
			for(MultipartFile upFile : upFiles) {

				if(upFile.isEmpty()) continue;
						
				String renamedFilename = UpmuUtils.getRenamedFilename(upFile.getOriginalFilename());
					
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest);
					
				MailAttach attach = new MailAttach();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
						
			}
			log.debug("attachList = {}", attachList);
				
			mail.setAttachList(attachList);
	
			int result = mailService.insertMail(mail);
					
			redirectAttr.addFlashAttribute("msg", "메일 전송 성공!");
		} catch(Exception e) {
			log.error("메일 전송 오류!", e);
			throw e;
		}
			
		return "redirect:/mail/sendMailList.do?sender_no=1";

	}
	
	//받은 메일 상세 보기
	@GetMapping("/receiveMailView.do")
	public void selectOneReceiveMail(@RequestParam int no, Model model) {
		
//		MailExt mail = mailService.selectOneMailCollection1(no);
		MailExt mail = mailService.selectOneMailCollection(no);
		log.debug("mail = {}", mail);
		
		model.addAttribute("mail",mail);
	}
	
	//보낸 메일 상세 보기
	@GetMapping("/sendMailView.do")
	public void selectOneSendMail(@RequestParam int no, Model model) {
		
//		MailExt mail = mailService.selectOneMailCollection2(no);
		MailExt mail = mailService.selectOneMailCollection(no);
		
		log.debug("mail = {}", mail);
		
		model.addAttribute("mail",mail);
	}

	//파일 다운로드
	@GetMapping("fileDownload.do")
	public ResponseEntity<Resource> fileDownloadWithResponseEntity(@RequestParam int no) throws UnsupportedEncodingException{// 실제 응답에 작성할 타입을 <>(제네릭) 안에 적어둠
		ResponseEntity<Resource> responseEntity = null;
		try {
			MailAttach attach = mailService.selectOneAttachment(no);
			if(attach == null) {
				return ResponseEntity.notFound().build();
			}
			
			String saveDirectory = application.getRealPath("/resources/upload/mail");
			File downFile = new File(saveDirectory, attach.getRenamedFilename());
			Resource resource = resourceLoader.getResource("file:" + downFile);
			String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
			
			responseEntity = 
					ResponseEntity
						.ok()
						.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + filename)
						.body(resource);
		} catch(Exception e) {
			log.error("파일 다운로드 오류", e);
			throw e;
		}
		return responseEntity;
	}
	
	//메일 검색
	@GetMapping("/searchMail.do")
	@ResponseBody
	public Map<String, Object> searchMail(@RequestParam String searchMail){
		log.debug("searchMail = {}", searchMail);
		
		List<Mail> list = mailService.searchMail(searchMail);
		log.debug("list = {}", list);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("searchMail", searchMail);
		return map;
	}
	
	//메일 삭제
	//한 명만 지워도 둘 다 지워지는 상황 -> 수정 필요
	@PostMapping("/deleteMail.do")
	public String deleteMail(HttpServletRequest request) {
		
		
		String[] arr = request.getParameterValues("valueArr");
		int size = arr.length;
		for(int i = 0; i < arr.length; i++) {
			mailService.deleteMail(arr[i]);
		}
		
//		return "redirect:/mail/sendMailList.do";
		
		return "";
	}

}
