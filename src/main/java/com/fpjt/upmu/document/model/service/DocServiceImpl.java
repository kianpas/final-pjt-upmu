package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpjt.upmu.document.model.dao.DocDao;
import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocLine;
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


}
