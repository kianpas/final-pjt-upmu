package com.fpjt.upmu.mail.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.mail.model.dao.MailDao;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailReceiver;
import com.fpjt.upmu.mail.model.vo.MailAttach;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailServiceImpl implements MailService {

	@Autowired
	private MailDao mailDao;

	@Override
	public int insertMail(MailExt mail) {
		int result = 0;

		result = mailDao.insertMail(mail);
		log.debug("mail = {}", mail);

		if(mail.getAttachList().size() > 0) {
			for(MailAttach attach : mail.getAttachList()) {
				attach.setMailNo(mail.getMailNo());
				result = insertAttachment(attach);
			}
		}
		return result;
	}
	
	@Override
	public int insertAttachment(MailAttach attach) {
		return mailDao.insertAttachment(attach);
	}

	@Override
	public int selectReceiveTotalContents(String i) {
		return mailDao.selectReceiveTotalContents(i);
	}

	@Override
	public int selectSendTotalContents(int i) {
		return mailDao.selectSendTotalContents(i);
	}
	
	@Override
	public List<Mail> selectReceiveList(Map<String, Object> param, String i) {
		return mailDao.selectReceiveList(param, i);
	}

	@Override
	public List<Mail> selectSendList(Map<String, Object> param, int i) {
		return mailDao.selectSendList(param, i);
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
	public List<Mail> searchMail(Map<String, Object> searchMail, int i) {
		return mailDao.searchMail(searchMail, i);
	}
	
	@Override
	public List<MailReceiver> searchReceiver(String searchReceiver) {
		return mailDao.searchReceiver(searchReceiver);
	}

	@Override
	public String deleteMail(String str, int who, int now) {
		return mailDao.deleteMail(str, who, now);
	}

}
