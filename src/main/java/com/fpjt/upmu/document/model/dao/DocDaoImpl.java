package com.fpjt.upmu.document.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocForm;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.DocReply;
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
		//paging added
		int offset = (int) param.get("offset");
		int limit = (int)param.get("limit");
		RowBounds rowBounds = new RowBounds(offset,limit);		
		return session.selectList("document.selectDocNo", param,rowBounds);
		//return session.selectList("document.selectDocNo", param);
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

	@Override
	public List<DocAttach> selectDocAttachList(String docNo) {
		return session.selectList("document.selectDocAttachList", docNo);
	}

	@Override
	public DocAttach selectOneAttachment(int no) {
		return session.selectOne("document.selectOneAttachment", no);
	}

	@Override
	public int insertReply(DocReply docReply) {
		return session.insert("document.insertReply", docReply);
	}

	@Override
	public List<DocReply> selectDocReplyList(String docNo) {
		return session.selectList("document.selectDocReplyList", docNo);
	}

	@Override
	public DocForm selectOneDocForm(String no) {
		return session.selectOne("document.selectOneDocForm", no);
	}

	@Override
	public int insertDocForm(DocForm docForm) {
		return session.insert("document.insertDocForm", docForm);
	}

	@Override
	public int updateDocForm(DocForm docForm) {
		return session.update("document.updateDocForm", docForm);
	}

	@Override
	public List<DocForm> selectDocFormList() {
		return session.selectList("document.selectDocFormList");
	}

	@Override
	public Document selectOnedocumentSimple(int docNo) {
		return session.selectOne("document.selectOnedocumentSimple", docNo);
	}

	@Override
	public int selectDocCount(Map<String, Object> param) {
		return session.selectOne("document.selectDocCount", param);
	}

	@Override
	public int deleteDocument(int docNo) {
		return session.delete("document.deleteDocument", docNo);
	}

	@Override
	public List<Document> selectDocumentList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int)param.get("limit");
		RowBounds rowBounds = new RowBounds(offset,limit);		
		return session.selectList("document.selectDocumentList", param,rowBounds);
	}

	

}
