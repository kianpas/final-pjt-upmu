package com.fpjt.upmu.comment.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.comment.model.vo.Cmt;
import com.fpjt.upmu.comment.model.vo.CmtExt;

@Repository
public class CmtDaoImpl implements CmtDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertComment(Cmt cmt) {
		
		return session.insert("cmt.insertComment", cmt);
	}

	@Override
	public List<CmtExt> selectCommentList(int boardNo) {
		
		return session.selectList("cmt.selectCommentList", boardNo);
	}

	@Override
	public int deleteComment(int cmtNo) {
		
		return session.delete("cmt.deleteComment", cmtNo);
	}

	@Override
	public int editComment(Cmt cmt) {
		
		return session.update("cmt.editComment", cmt);
	}

	
	
}
