package com.fpjt.upmu.notice.model.dao;

import java.util.List;

import com.fpjt.upmu.notice.model.vo.Notice;

public interface NoticeDao {

	int insertNotice(Notice notice);

	List<Notice> selectNoticeList(int empNo);

}
