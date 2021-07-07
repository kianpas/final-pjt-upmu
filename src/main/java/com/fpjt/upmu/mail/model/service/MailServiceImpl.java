package com.fpjt.upmu.mail.model.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional(rollbackFor = Exception.class)
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
	public int selectReceiveTotalContents(String empName) {
		return mailDao.selectReceiveTotalContents(empName);
	}

	@Override
	public int selectSendTotalContents(int i) {
		return mailDao.selectSendTotalContents(i);
	}
	
	@Override
	public List<Mail> selectReceiveList(Map<String, Object> param, String empName) {
		return mailDao.selectReceiveList(param, empName);
	}

	@Override
	public List<Mail> selectSendList(Map<String, Object> param, int empNo) {
		return mailDao.selectSendList(param, empNo);
	}

	@Override
	public MailExt selectOneMailCollection(int no) {
		
		MailExt mail = mailDao.selectOneMailCollection(no);
		
		String receiver = null;
		if(mail != null) {
			receiver = mail.getReceiverAdd();
			receiver = receiver.substring(1, receiver.length()-1);
			mail.setReceiverAdd(receiver);
		}
		
		return mail;
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

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReceiveMail(Map<String, Object> del, String saveDirectory) {
		MailExt mail = selectOneMailCollection((int)del.get("mailNo"));
		
		int result = 0;
		
		String receiver = mail.getReceiverAdd();
		String receiverDel = mail.getReceiverDel();
			
		if(mail.getSenderDel() != 1) {
			del.put("empName", "," + del.get("empName"));
			result = mailDao.hideReceiveMail(del);
		
		} else {
			//받는 사람이 한명
			if(!receiver.contains(",")) {
				//첨부파일이 있다면
				if (mail.getAttachList().get(0).getAttachNo() != 0) {
					deleteAttach(mail.getAttachList(), saveDirectory);
				}

				result = mailDao.deleteMail((int)del.get("mailNo"));	
			} else {
				//받는 사람이 n명			
				if(receiverDel != null) {

					int receiverNum = 0;
					for(int i = 0; i < receiver.length(); i++) {
						if(receiver.charAt(i) == ',')
							receiverNum++;
					}
					
					int receiverDelNum = 0;
					String receiverDel2 = receiverDel.substring(1);
					for(int i = 0; i < receiverDel2.length(); i++) {
						if(receiverDel2.charAt(i) == ',')
							receiverDelNum++;
					}
					
					if(receiverDelNum == receiverNum) {
					
						if (mail.getAttachList().get(0).getAttachNo() != 0) {
							deleteAttach(mail.getAttachList(), saveDirectory);							
						}
						result = mailDao.deleteMail((int)del.get("mailNo"));
						
					} else {
						del.put("empName", mail.getReceiverDel() + del.get("empName"));
						result = mailDao.hideReceiveMail(del);
					}
				} else {
					del.put("empName", "," + del.get("empName"));
					result = mailDao.hideReceiveMail(del);
				}
			}
		}		
		
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteSendMail(int mailNo, String saveDirectory) {
		
		MailExt mail = selectOneMailCollection(mailNo);
	
		int result = 0;
		
		String receiver = mail.getReceiverAdd();
		String receiverDel = mail.getReceiverDel();
		
		//받는 사람이 1명
		if(!receiver.contains(",")) {

			if(receiverDel == null) {
				result = mailDao.hideSendMail(mailNo);
			} else {
				if (mail.getAttachList().get(0).getAttachNo() != 0) {			
					deleteAttach(mail.getAttachList(), saveDirectory);
				}
				result = mailDao.deleteMail(mailNo);
			}		
		} else {
			//받는 사람이 n명			
			if(receiverDel != null) {
			
				int receiverNum = 0;
				for(int i = 0; i < receiver.length(); i++) {
					if(receiver.charAt(i) == ',')
						receiverNum++;
				}
				
				int receiverDelNum = 0;
				String receiverDel2 = receiverDel.substring(1);
				for(int i = 0; i < receiverDel2.length(); i++) {
					if(receiverDel2.charAt(i) == ',')
						receiverDelNum++;
				}
				
				if(receiverDelNum == receiverNum) {

					if (mail.getAttachList().get(0).getAttachNo() != 0) {					
						deleteAttach(mail.getAttachList(), saveDirectory);						
					}
					result = mailDao.deleteMail(mailNo);
					
				} else {
					result = mailDao.hideSendMail(mailNo);
				}
			} else {
				result = mailDao.hideSendMail(mailNo);
			}
		}
		return result;
	}
	
	public void deleteAttach(List<MailAttach> delAttach, String saveDirectory) {

		for(int j = 0; j < delAttach.size(); j ++) {
			MailAttach attach = delAttach.get(j);
			String filePath = saveDirectory + "\\" + attach.getRenamedFilename();
			
			File deleteFile = new File(filePath);
			
			if(deleteFile.exists()) {
				deleteFile.delete();
			
			} else {
				System.out.println("파일이 존재하지 않습니다.");
			}
		}
	}
}
