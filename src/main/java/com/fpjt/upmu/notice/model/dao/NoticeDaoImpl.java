package com.fpjt.upmu.notice.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertNotice(Notice notice) {
		return session.insert("notice.insertNotice", notice);
	}

}
