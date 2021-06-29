package com.fpjt.upmu.board.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.board.model.vo.Board;
import com.fpjt.upmu.board.model.vo.Attachment;
import com.fpjt.upmu.board.model.vo.BoardExt;

public interface BoardService {

	List<Board> selectBoardList();

	List<BoardExt> selectBoardList(Map<String, Object> param);

	int selectBoardTotalContents();

	int insertBoard(BoardExt board);
	
	int insertAttachment(Attachment attach);

	BoardExt selectOneBoard(int no);

	BoardExt selectOneBoardCollection(int no);

	Attachment selectOneAttachment(int no);
	
	int boardUpdate(BoardExt boardExt);

	int boardDelete(int no);

	List<BoardExt> boardSearch(String search);

	void readCount(int no);

	

}
