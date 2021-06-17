package com.fpjt.upmu.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.board.model.vo.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Board> selectBoardList() {
		return session.selectList("board.selectBoardList");
	}

//	@Override
//	public List<Board> selectBoardList(Map<String, Object> param) {
//		int offset = (int)param.get("offset");
//		int limit = (int)param.get("limit");
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return session.selectList("board.selectBoardList", null, rowBounds);
//	}
	
}

