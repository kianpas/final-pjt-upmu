package com.fpjt.upmu.board.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.board.model.vo.Board;

public interface BoardService {

	List<Board> selectBoardList();

	List<Board> selectBoardList(Map<String, Object> param);

}
