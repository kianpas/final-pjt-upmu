package com.fpjt.upmu.mail.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.mail.model.vo.MailAttach;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;

public interface MailDao {

	MailExt selectOneMailCollection(int no);

	int insertMail(MailExt mail);

	int insertAttachment(MailAttach attach);

	int selectMailTotalContents1(int i);

	int selectMailTotalContents2(int i);

	List<Mail> selectMailList1(Map<String, Object> param, int i);

	List<Mail> selectMailList2(Map<String, Object> param, int i);

	MailAttach selectOneAttachment(int no);
	
	List<MailAttach> selectAttachList(int no);

	List<Mail> searchMail(String searchMail);

	int deleteMail(String str);

//	MailExt selectOneMailCollection1(int no);

}
