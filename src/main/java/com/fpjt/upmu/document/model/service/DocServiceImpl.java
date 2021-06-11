package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.document.model.dao.DocDao;
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
	public List<Document> selectDocList(Map<String, Object> param) {
		return docDao.selectDocList(param);
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



}
