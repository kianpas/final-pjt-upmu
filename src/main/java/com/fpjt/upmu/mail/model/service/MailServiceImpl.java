package com.fpjt.upmu.mail.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpjt.upmu.mail.model.dao.MailDao;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailAttach;
//import com.kh.spring.board.model.vo.Attachment;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailServiceImpl implements MailService {

	@Autowired
	private MailDao mailDao;

	@Override
	public int insertMail(MailExt mail) {
		int result = 0;
		//1. board 등록
		result = mailDao.insertMail(mail);
		log.debug("mail = {}", mail);
		//2. attachment등록
		if(mail.getAttachList().size() > 0) {
			for(MailAttach attach : mail.getAttachList()) {
				attach.setMailNo(mail.getMailNo());
				result = insertAttachment(attach);
			}
		}
		return result;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertAttachment(MailAttach attach) {
		return mailDao.insertAttachment(attach);
	}

	@Override
	public int selectMailTotalContents1(int i) {
		return mailDao.selectMailTotalContents1(i);
	}

	@Override
	public int selectMailTotalContents2(int i) {
		return mailDao.selectMailTotalContents2(i);
	}
	
	@Override
	public List<Mail> selectMailList1(Map<String, Object> param, int i) {
		return mailDao.selectMailList1(param, i);
	}

	@Override
	public List<Mail> selectMailList2(Map<String, Object> param, int i) {
		return mailDao.selectMailList2(param, i);
	}

	@Override
	public MailExt selectOneMailCollection(int no) {
		return mailDao.selectOneMailCollection(no);
	}

	@Override
	public MailAttach selectOneAttachment(int no) {
		return mailDao.selectOneAttachment(no);
	}

	@Override
	public List<Mail> searchMail(String searchMail) {
		return mailDao.searchMail(searchMail);
	}

	@Override
	public int deleteMail(String str) {
		return mailDao.deleteMail(str);
	}
	
	

//	@Override
//	public MailExt selectOneMailCollection1(int no) {
//		return mailDao.selectOneMailCollection1(no);
//	}
	
	
	
	
}
