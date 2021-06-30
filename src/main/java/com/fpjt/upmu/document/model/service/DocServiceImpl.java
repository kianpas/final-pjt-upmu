package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpjt.upmu.document.model.dao.DocDao;
import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocForm;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.DocReply;
import com.fpjt.upmu.document.model.vo.Document;

@Service
public class DocServiceImpl implements DocService {
	
	@Autowired
	private DocDao docDao;


	@Override
	public List<Document> selectDocLineList(int id) {
		return docDao.selectDocLineList(id);
	}


	@Override
	public Document selectOneDocument(String docNo) {
		return docDao.selectOneDocument(docNo);
	}


	@Override
	public int updateDocument(Map<String, Object> param) {
		return docDao.updateDocument(param);
	}


	@Override
	public int updateMyDocLineStatus(DocLine docLine) {
		return docDao.updateMyDocLineStatus(docLine);
	}


	@Override
	public int updateOthersDocLineStatus(DocLine docLine) {
		return docDao.updateOthersDocLineStatus(docLine);
	}


	@Override
	public List<String> selectDocNo(Map<String, Object> param) {
		return docDao.selectDocNo(param);
	}


	@Override
	public Document selectOneDocumentByParam(Map<String, Object> param) {
		return docDao.selectOneDocumentByParam(param);
	}

	@Transactional
	@Override
	public int insertDocument(Document document, List<DocAttach> attachList) {
		try {
			int result = 0;
			result = docDao.insertDocument(document);

			if(document.getDocLine().size()>0) {
				for (DocLine docLine : document.getDocLine()) {
					docLine.setDocNo(document.getDocNo());
					result = insertDocLine(docLine);
				}
			}
			if(attachList!=null) {
				for (DocAttach docAttach : attachList) {
					docAttach.setDocNo(document.getDocNo());
					result = insertDocAttach(docAttach);
				}
			}
			return result;
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public int insertDocAttach(DocAttach docAttach) {
		return docDao.insertDocAttach(docAttach);
	}


	@Override
	public int insertDocLine(DocLine docLine) {
		return docDao.insertDocLine(docLine);
	}


	@Override
	public List<DocAttach> selectDocAttachList(String docNo) {
		return docDao.selectDocAttachList(docNo);
	}


	@Override
	public DocAttach selectOneAttachment(int no) {
		return docDao.selectOneAttachment(no);
	}


	@Override
	public int insertReply(DocReply docReply) {
		return docDao.insertReply(docReply);
	}

	@Override
	public List<DocReply> selectDocReplyList(String docNo) {
		return docDao.selectDocReplyList(docNo);
	}


	@Override
	public DocForm selectOneDocForm(String no) {
		return docDao.selectOneDocForm(no);
	}


	@Override
	public int insertDocForm(DocForm docForm) {
		return docDao.insertDocForm(docForm);
	}


	@Override
	public int updateDocForm(DocForm docForm) {
		return docDao.updateDocForm(docForm);
	}


	@Override
	public List<DocForm> selectDocFormList() {
		return docDao.selectDocFormList();
	}


	@Override
	public Document selectOnedocumentSimple(int docNo) {
		return docDao.selectOnedocumentSimple(docNo);
	}


	@Override
	public int selectDocCount(Map<String, Object> param) {
		return docDao.selectDocCount(param);
	}


}
