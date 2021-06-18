package com.fpjt.upmu.board.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.board.model.vo.Board;

public interface BoardDao {

	List<Board> selectBoardList();

	List<Board> selectBoardList(Map<String, Object> param);

}
