package com.fpjt.upmu.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.board.model.vo.Board;
import com.fpjt.upmu.board.model.vo.Attachment;
import com.fpjt.upmu.board.model.vo.BoardExt;
import com.fpjt.upmu.board.model.dao.BoardDao;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Board> selectBoardList() {
		return session.selectList("board.selectBoardList");
	}

	@Override
	public List<BoardExt> selectBoardList(Map<String, Object> param) {
		int offset = (int)param.get("offset");
		int limit = (int)param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("board.selectBoardList", null, rowBounds);
	}

	@Override
	public int selectBoardTotalContents() {
		return session.selectOne("board.selectBoardTotalContents");
	}

	@Override
	public int insertBoard(BoardExt board) {
		return session.insert("board.insertBoard", board);
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return session.insert("board.insertAttachment", attach);
	}

	@Override
	public BoardExt selectOneBoard(int no) {
		return session.selectOne("board.selectOneBoard", no);
	}

	@Override
	public List<Attachment> selectAttachList(int boardNo) {
		return session.selectList("board.selectAttachList", boardNo);
	}

	@Override
	public BoardExt selectOneBoardCollection(int no) {
		return session.selectOne("board.selectOneBoardCollection", no);
	}

	@Override
	public Attachment selectOneAttachment(int no) {
		
		return session.selectOne("board.selectOneAttachment", no);
	}

	
	@Override
	public int boardUpdate(BoardExt boardExt) {
		
		return session.update("board.boardUpdate", boardExt);
	}

	@Override
	public int boardDelete(int no) {
		
		return session.delete("board.boardDelete", no);
	}

	@Override
	public List<BoardExt> boardSearch(String search) {
		
		return session.selectList("board.boardSearch", search);
	}

	@Override
	public void readCount(int no) {
		
		session.update("board.readCount", no);
		
	}

	@Override
	public int deleteFile(int no) {
		
		return session.update("board.deleteFile", no);
	}

	@Override
	public List<BoardExt> mainBoardList() {
		
		return session.selectList("board.mainBoardList");
	}
	
	
	
	
}

