package com.fpjt.upmu.notice.model.service;

import java.util.List;

import com.fpjt.upmu.notice.model.vo.Notice;

public interface NoticeService {

	int insertNotice(Notice notice);

	List<Notice> selectNoticeList(int empNo);

}
