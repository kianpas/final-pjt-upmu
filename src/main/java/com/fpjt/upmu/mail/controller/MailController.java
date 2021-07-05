package com.fpjt.upmu.mail.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.mail.model.service.MailService;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailReceiver;
import com.fpjt.upmu.mail.model.vo.MailAttach;

//외부 메일
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.core.Authentication;
import org.springframework.core.io.FileSystemResource;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mail")
@Slf4j
public class MailController {
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private MailService mailService;
	
	//외부메일
	@Autowired
	JavaMailSenderImpl mailSender;
	
//	String saveDirectory = null;
	
	//받은 메일함
	@GetMapping("/receiveMailList.do")
	public String receiveMailList(
				Authentication authentication,
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

			Employee principal = (Employee)authentication.getPrincipal();
			principal.setEmpName(":"+principal.getEmpName()+":");

			List<Mail> list = mailService.selectReceiveList(param, principal.getEmpName());

			int totalContents = mailService.selectReceiveTotalContents(principal.getEmpName());
			
			String url = request.getRequestURI();
			
			log.debug("totalContents = {}, url = {}", totalContents, url);
			
			String pageBar = UpmuUtils.getPageBar(totalContents, cpage, limit, url);
			
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			
			principal.setEmpName(principal.getEmpName().replace(":", ""));
			
		} catch(Exception e) {
			log.error("받은 메일함 조회 오류!", e);
			throw e;
		}
		
		return "mail/receiveMailList";
	}
	
	//보낸 메일함
	@GetMapping("/sendMailList.do")
	public String sendMailList(
				Authentication authentication,
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
			
			Employee principal = (Employee)authentication.getPrincipal();

			List<Mail> list = mailService.selectSendList(param, principal.getEmpNo());

			int totalContents = mailService.selectSendTotalContents(principal.getEmpNo());
			
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
//	@PostMapping("/mailForm.do")
//	public void mailForm2() {}
	
	//메일 보내기(답장)
	@PostMapping("/mailReply.do")
	public void mailForm3() {}
	
	@PostMapping("/mailEnroll.do")
	public String mailEnroll(
				Authentication authentication,
				@ModelAttribute MailExt mail,
				@RequestParam(name = "receiverArr") String[] receiverArr,
				@RequestParam(name = "upFile") MultipartFile[] upFiles,
				RedirectAttributes redirectAttr
			) throws Exception {
		
		try {
			
			log.debug("mail = {}", mail);

			Employee principal = (Employee)authentication.getPrincipal();

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

			for(int i = 0; i < receiverArr.length; i++) {
				String s = receiverArr[i];
				//외부메일
				if(receiverArr[i].contains("@")) {
					final MimeMessagePreparator preparator = new MimeMessagePreparator() {
						
						@Override
						public void prepare(MimeMessage mimeMessage) throws Exception {
							final MimeMessageHelper mailHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
								
							mailHelper.setFrom("theupmuteam@gmail.com");
							mailHelper.setTo(s);
							mailHelper.setSubject(mail.getMailTitle());
							mailHelper.setText(mail.getMailContent());
							
							if(attachList != null) {
								for(int i = 0; i < attachList.size(); i++) {
									FileSystemResource files = new FileSystemResource(new File(saveDirectory + "\\" + attachList.get(i).getRenamedFilename()));
									mailHelper.addAttachment(attachList.get(i).getOriginalFilename(), files);
								}
							}			
						}
					};
					mailSender.send(preparator);
				}
			
				//외부, 내부 공통
				if(mail.getReceiverAdd() == null) {
					mail.setReceiverAdd(":" + receiverArr[i] + ":");
				}
				else {
					mail.setReceiverAdd(mail.getReceiverAdd() + ",:" + receiverArr[i] + ":");
				}
			}
			mail.setSenderAdd(principal.getEmpNo());
			mail.setAttachList(attachList);			
			
			int result = mailService.insertMail(mail);
			redirectAttr.addFlashAttribute("msg", "메일 전송 성공!");
			
			} catch(Exception e) {
				log.error("메일 전송 오류!", e);
				throw e;
			}
		return "redirect:/mail/sendMailList.do";
	}
	
	//받은 메일 상세 보기
	@GetMapping("/receiveMailView.do")
	public void selectOneReceiveMail(@RequestParam int no, Model model) {
		
		MailExt mail = mailService.selectOneMailCollection(no);
		log.debug("받은 mail = {}", mail);
		model.addAttribute("mail",mail);

	}
	
	//보낸 메일 상세 보기
	@GetMapping("/sendMailView.do")
	public void selectOneSendMail(@RequestParam int no, Model model) {
		
		MailExt mail = mailService.selectOneMailCollection(no);
		
		log.debug("보낸 mail = {}", mail);
		
		String receiver = null;
		if(mail != null) {
			receiver = mail.getReceiverAdd();
			receiver = receiver.replace(":", "");
			mail.setReceiverAdd(receiver);
			model.addAttribute("mail",mail);
		}
	}

	//파일 다운로드
	@GetMapping("fileDownload.do")
	public ResponseEntity<Resource> fileDownload(@RequestParam int no) throws UnsupportedEncodingException{
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
	public Map<String, Object> searchMail(Authentication authentication, @RequestParam String searchTerm, @RequestHeader(name = "Referer") String referer){
		log.debug("searchTerm = {}", searchTerm);
		log.info("referer = {}", referer);
		
		Employee principal = (Employee)authentication.getPrincipal();
		
		Map<String, Object> searchMail = new HashMap<>();
		
		searchMail.put("searchTerm", searchTerm);
		
		List<Mail> list = null;

		if(referer.contains("send")) {
			//1 : 보낸
			searchMail.put("who", principal.getEmpNo());
			list = mailService.searchMail(searchMail, 1);
		}
		else if(referer.contains("receive")) {
			//2 : 받은
			searchMail.put("who", ":"+principal.getEmpName()+":");
			list = mailService.searchMail(searchMail, 2);
		}

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("searchMail", searchMail);
		return map;
	}
	
	//받는 사람 검색
	@GetMapping("/searchReceiver.do")
	@ResponseBody
	public Map<String, Object> searchReceiver(@RequestParam String searchReceiver){
		log.debug("searchTitle = {}", searchReceiver);

		List<MailReceiver> list = mailService.searchReceiver(searchReceiver);
		log.debug("list = {}", list);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("searchReceiver", searchReceiver);
		
		return map;	
	}
	
	//메일 삭제
	@PostMapping("/deleteMail.do")
	@ResponseBody
	public String deleteMail(@RequestParam String[] valueArr, @RequestParam int who) {
		String result = null;
		
		try {
			//
			int now = 1;
			
			for(int i = 0; i < valueArr.length; i++) {
				result = mailService.deleteMail(valueArr[i], who, now);
			
				//beforeDel인 경우
				if(result.equals("beforeDel")) {
					List<MailAttach> delAttach = mailService.selectOneMailCollection(Integer.parseInt(valueArr[i])).getAttachList();
					for(int j = 0; j < delAttach.size(); j ++) {
						
						String saveDirectory = application.getRealPath("/resources/upload/mail");
						MailAttach attach = delAttach.get(j);
						String filePath = saveDirectory + "\\" + attach.getRenamedFilename();
						
						File deleteFile = new File(filePath);
						
						if(deleteFile.exists()) {
							deleteFile.delete();
						
						} else {
							System.out.println("파일이 존재하지 않습니다.");
						}
					}
					
					now = 2;
					mailService.deleteMail(valueArr[i], who, now);
				}
			}

			result = "OK";
					
		} catch(Exception e) {
			log.error("삭제 오류!", e);
			result = "Fail";
			throw e;
			
		}

		return result;
	}

}
