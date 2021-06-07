package com.fpjt.upmu.document.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.document.model.vo.Document;

@Repository
public class DocDaoImpl implements DocDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Document> selectDocList() {
		return session.selectList("document.selectDocList");
	}

}
