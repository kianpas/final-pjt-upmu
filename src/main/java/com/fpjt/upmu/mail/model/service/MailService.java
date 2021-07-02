package com.fpjt.upmu.mail.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.mail.model.vo.MailAttach;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailReceiver;

public interface MailService {

	int insertMail(MailExt mail);

	MailExt selectOneMailCollection(int no);

	int insertAttachment(MailAttach attach);

	int selectReceiveTotalContents(String i);
	int selectSendTotalContents(int i);
	

	List<Mail> selectReceiveList(Map<String, Object> param, String i);
	List<Mail> selectSendList(Map<String, Object> param, int i);

	MailAttach selectOneAttachment(int no);

	List<Mail> searchMail(Map<String, Object> searchMail, int i);
	
	List<MailReceiver> searchReceiver(String searchReceiver);

	String deleteMail(String str, int who, int now);
	
}
