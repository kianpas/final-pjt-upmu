package com.fpjt.upmu.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.notice.model.dao.NoticeDao;
import com.fpjt.upmu.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public List<Notice> selectNoticeList(int empNo) {
		return noticeDao.selectNoticeList(empNo);
	}



}
