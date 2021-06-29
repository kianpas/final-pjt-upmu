package com.fpjt.upmu.notice.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.notice.model.vo.Notice;

public interface NoticeService {

	int insertNotice(Notice notice);

	List<Notice> selectNoticeList(int empNo);

	int deleteNotice(int no);

	int updateNotice(int no);

	int countNoticeList(int empNo);

	int deleteNoticeList(Map<String, Object> map);

}
