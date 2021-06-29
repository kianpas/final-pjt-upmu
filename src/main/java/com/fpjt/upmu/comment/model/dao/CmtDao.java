package com.fpjt.upmu.comment.model.dao;

import java.util.List;

import com.fpjt.upmu.comment.model.vo.Cmt;
import com.fpjt.upmu.comment.model.vo.CmtExt;

public interface CmtDao {

	int insertComment(Cmt cmt);

	List<CmtExt> selectCommentList(int boardNo);

	int deleteComment(int cmtNo);

	int editComment(Cmt cmt);

}
