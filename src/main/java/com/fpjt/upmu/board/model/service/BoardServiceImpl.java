package com.fpjt.upmu.board.model.service;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.board.model.dao.BoardDao;
import com.fpjt.upmu.board.model.vo.Board;
import com.fpjt.upmu.board.model.vo.Attachment;
import com.fpjt.upmu.board.model.vo.BoardExt;
import com.fpjt.upmu.board.model.service.BoardService;
import com.fpjt.upmu.board.model.service.BoardServiceImpl;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> selectBoardList() {
		return boardDao.selectBoardList();
	}

	@Override
	public List<BoardExt> selectBoardList(Map<String, Object> param) {
		return boardDao.selectBoardList(param);
	}

	@Override
	public int selectBoardTotalContents() {
		return boardDao.selectBoardTotalContents();
	}
	
	@Override
	public int insertBoard(BoardExt board) {
		int result = 0; 
		//1.board 등록
		result = boardDao.insertBoard(board);
		log.debug("board = {}", board);
		//2.attachment 등록
		if(board.getAttachList().size() > 0) {
			for(Attachment attach : board.getAttachList()) {
				attach.setBoardNo(board.getNo()); 
				result = insertAttachment(attach);
			}
		}
		
		return result; 
	}
	
	@Override
	public int insertAttachment(Attachment attach) {
		return boardDao.insertAttachment(attach);
	}

	@Override
	public BoardExt selectOneBoard(int no) {
		BoardExt board = boardDao.selectOneBoard(no);
		List<Attachment> attachList = boardDao.selectAttachList(no); // boardNo로 조회
		board.setAttachList(attachList);
		return board;
	}

	@Override
	public BoardExt selectOneBoardCollection(int no) {
		return boardDao.selectOneBoardCollection(no);
	}

	@Override
	public Attachment selectOneAttachment(int no) {
		
		return boardDao.selectOneAttachment(no);
	}

	
	@Override
	public int boardUpdate(BoardExt boardExt) {
		int result = 0; 
		//1.board 등록
		result = boardDao.boardUpdate(boardExt);
		log.debug("boardExt = {}", boardExt);
		//2.attachment 등록
		if(boardExt.getAttachList().size() > 0) {
			for(Attachment attach : boardExt.getAttachList()) {
				attach.setBoardNo(boardExt.getNo()); 
				result = insertAttachment(attach);
			}
		}
		return result;
		
	}

	@Override
	public int boardDelete(int no) {
		
		return boardDao.boardDelete(no);
	}

	@Override
	public List<BoardExt> boardSearch(String search) {
		
		return boardDao.boardSearch(search);
	}

	@Override
	public void readCount(int no) {
		boardDao.readCount(no);
		
	}

	@Override
	public int deleteFile(int no) {
		
		return boardDao.deleteFile(no);
	}
	
	
}
