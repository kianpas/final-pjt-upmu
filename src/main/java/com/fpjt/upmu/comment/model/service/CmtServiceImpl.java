package com.fpjt.upmu.comment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.comment.model.dao.CmtDao;
import com.fpjt.upmu.comment.model.vo.Cmt;
import com.fpjt.upmu.comment.model.vo.CmtExt;

@Service
public class CmtServiceImpl implements CmtService {

	@Autowired
	private CmtDao cmtDao;

	@Override
	public int insertComment(Cmt cmt) {
		
		return cmtDao.insertComment(cmt);
	}

	@Override
	public List<CmtExt> selectCommentList(int boardNo) {
		
		return cmtDao.selectCommentList(boardNo);
	}

	@Override
	public int deleteComment(int cmtNo) {
	
		return cmtDao.deleteComment(cmtNo);
	}

	@Override
	public int editComment(Cmt cmt) {
		
		return cmtDao.editComment(cmt);
	}
	
	
}
