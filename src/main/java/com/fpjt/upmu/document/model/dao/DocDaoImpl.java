package com.fpjt.upmu.document.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.Document;

@Repository
public class DocDaoImpl implements DocDao {
	
	@Autowired
	private SqlSessionTemplate session;


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

	@Override
	public List<String> selectDocNo(Map<String, Object> param) {
		return session.selectList("document.selectDocNo", param);
	}

	@Override
	public Document selectOneDocumentByParam(Map<String, Object> param) {
		return session.selectOne("document.selectOneDocumentByParam", param);
	}

	@Override
	public int insertDocument(Document document) {
		return session.insert("document.insertDocument", document);
	}

	@Override
	public int insertDocLine(DocLine docLine) {
		return session.insert("document.insertDocLine", docLine);
	}

	@Override
	public int insertDocAttach(DocAttach docAttach) {
		return session.insert("document.insertDocAttach", docAttach);
	}

	

}
