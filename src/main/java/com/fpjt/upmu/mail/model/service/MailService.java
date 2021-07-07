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

	int selectReceiveTotalContents(String empName);
	int selectSendTotalContents(int i);
	
	List<Mail> selectReceiveList(Map<String, Object> param, String empName);
	List<Mail> selectSendList(Map<String, Object> param, int empNo);

	MailAttach selectOneAttachment(int no);

	List<Mail> searchMail(Map<String, Object> searchMail, int i);
	
	List<MailReceiver> searchReceiver(String searchReceiver);
	
	int deleteReceiveMail(Map<String, Object> del, String saveDirectory);
	int deleteSendMail(int mailNo, String saveDirectory);
	
}
