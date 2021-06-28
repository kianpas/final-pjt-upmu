package com.fpjt.upmu.notice;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fpjt.upmu.document.model.service.DocService;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.DocReply;
import com.fpjt.upmu.document.model.vo.Document;
import com.fpjt.upmu.notice.model.service.NoticeService;
import com.fpjt.upmu.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Aspect
public class NoticeAspect {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private DocService docService;
	
//	@Pointcut("execution(* com.fpjt.upmu.document..selectDocNo(..))")
//	public void noticePointcut() {}
	
//	@Around("noticePointcut()")
	@Around("execution(* com.fpjt.upmu.document.model.service.DocService.selectDocNo(..))")
	public Object logger(ProceedingJoinPoint joinPoint) throws Throwable {
		Signature signature = joinPoint.getSignature();

//		System.out.println("Method args names:");
//		Arrays
//			.asList(signature.getName())
//			.stream()
//			.forEach(s -> System.out.println("arg name: " + s));

//		System.out.println("Method args types:");
//		Arrays
//			.asList(signature.getDeclaringType())
//			.stream()
//			.forEach(s -> System.out.println("arg type: " + s));
		
		System.out.println("Method args values:");
		Arrays.stream(joinPoint.getArgs()).forEach(o -> System.out.println("arg value: " + o.toString()));
		//before
		
		//주업무 joinPoint실행
		Object returnObj = joinPoint.proceed();
		
		//after
		
		return returnObj;
	}

//	@Around("execution(* com.fpjt.upmu.document.model.service.DocService.insertReply(..))")
//	public Object replyLogger(ProceedingJoinPoint joinPoint) throws Throwable {
//		//before
//		Signature signature = joinPoint.getSignature();
//		Arrays.stream(joinPoint.getArgs()).forEach(o -> System.out.println("arg value: " + o.toString()));
//		
//		//proceed
//		Object returnObj = joinPoint.proceed();
//		
//		//after
//		List<DocReply> list = new ArrayList<>();
//		Arrays.stream(joinPoint.getArgs()).forEach(o -> list.add((DocReply) o));
//		
//		int docNo = list.get(0).getDocNo();
//		Document document = docService.selectOnedocumentSimple(docNo);
//		//System.out.printf("docNo = %d, writer = %d%n", docNo, writer);
//		
//		int empNo = document.getWriter();
//		String linkAddr = "/document/docDetail?docNo="+docNo;
//		String notiType = "docReply";
//		
//		Notice notice = new Notice();
//		notice.setEmpNo(empNo);
//		notice.setLinkAddr(linkAddr);
//		notice.setNotiType(notiType);
//		
//		int result = noticeService.insertNotice(notice);
//		
//		return returnObj;
//	}
	
	/**
	 * 댓글알림
	 * @param joinPoint
	 * @throws Throwable
	 */
	@AfterReturning("execution(* com.fpjt.upmu.document.model.service.DocService.insertReply(..))")
	public void replyLogger2(JoinPoint joinPoint) throws Throwable {
		List<DocReply> list = new ArrayList<>();
		Arrays.stream(joinPoint.getArgs()).forEach(o -> list.add((DocReply) o));
		
		int docNo = list.get(0).getDocNo();
		Document document = docService.selectOnedocumentSimple(docNo);
		
		int empNo = document.getWriter();
		String linkAddr = "/document/docDetail?docNo="+docNo;
		String notiType = "docReply";
		
		Notice notice = new Notice();
		notice.setEmpNo(empNo);
		notice.setLinkAddr(linkAddr);
		notice.setNotiType(notiType);
		
		int result = noticeService.insertNotice(notice);
	}	
	
	
	/**
	 * 결재문서 발생 알림
	 * @param joinPoint
	 * @throws Throwable
	 */
	//이거 왜 com.fpjt.upmu.document.model.service.DocService.insertDocLine(..)는 작동을 안하지?
	@AfterReturning("execution(* com.fpjt.upmu.document.model.dao.DocDao.insertDocLine(..))")
	public void docLineLogger(JoinPoint joinPoint) throws Throwable {
		
		Arrays
			.stream(joinPoint.getArgs())
			.forEach(o -> System.out.println("arg value: " + o.toString()));
		
		List<DocLine> list = new ArrayList<>();
		Arrays
			.stream(joinPoint.getArgs())
			.forEach(o -> list.add((DocLine) o));
		
		int docNo = list.get(0).getDocNo();
		int empNo = list.get(0).getApprover();
		String linkAddr = "/document/docDetail?docNo="+docNo;
		String notiType = "docLine";
		
		Notice notice = new Notice();
		notice.setEmpNo(empNo);
		notice.setLinkAddr(linkAddr);
		notice.setNotiType(notiType);
		
		int result = noticeService.insertNotice(notice);
	}
}
