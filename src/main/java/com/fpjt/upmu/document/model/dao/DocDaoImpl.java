package com.fpjt.upmu.document.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.Document;

@Repository
public class DocDaoImpl implements DocDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Document> selectDocList(Map<String, Object> param) {
		return session.selectList("document.selectDocList",param);
	}

	@Override
	public List<Document> selectDocLineList(int id) {
		return session.selectList("document.selectDocLineList",id);
	}

	@Override
	public Document selectOneDocument(String docNo) {
		return session.selectOne("document.selectOneDocument", docNo);
	}

	@Override
	public int updateDocument(Map<String, Object> param) {
		return session.update("document.updateDocument", param);
	}

	@Override
	public int updateMyDocLineStatus(DocLine docLine) {
		return session.update("document.updateMyDocLineStatus", docLine);
	}

	@Override
	public int updateOthersDocLineStatus(DocLine docLine) {
		return session.update("document.updateOthersDocLineStatus", docLine);
	}

	

}
