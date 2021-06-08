package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.document.model.dao.DocDao;
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

}
