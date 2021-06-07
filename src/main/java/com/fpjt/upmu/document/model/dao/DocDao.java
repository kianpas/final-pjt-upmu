package com.fpjt.upmu.document.model.dao;

import java.util.List;

import com.fpjt.upmu.document.model.vo.Document;

public interface DocDao {

	List<Document> selectDocList();

}
