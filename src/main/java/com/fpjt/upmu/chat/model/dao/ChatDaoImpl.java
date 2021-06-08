package com.fpjt.upmu.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.chat.model.vo.ChatRoom;

@Repository
public class ChatDaoImpl implements ChatDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<ChatRoom> chatRoomList() {
		
		return session.selectList("chat.chatRoomList");
	}
	
	
}

