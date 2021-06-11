package com.fpjt.upmu.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ChatDaoImpl implements ChatDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<ChatRoom> chatRoomList() {
		
		return session.selectList("chat.chatRoomList");
	}

	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
	
		return session.insert("chat.insertChatRoom", chatRoom);
	}

	@Override
	public List<ChatMsg> selectedRoomChatList(int chatroomNo) {
		
		return session.selectList("chat.selectedRoomChatList", chatroomNo);
	}

	@Override
	public int deleteChatRoom(int chatroomNo) {
		
		return session.delete("chat.deleteChatRoom", chatroomNo);
	}

	@Override
	public int insertChatMsg(ChatMsg chatMsg) {
		
		return session.insert("chat.insertChatMsg", chatMsg);
	}

	@Override
	public int joinChatRoom(ChatRoomJoin chatroomJoin) {
		
		return session.insert("chat.joinChatRoom", chatroomJoin);
	}

	@Override
	public int disconnectChatRoom(ChatRoomJoin chatroomJoin) {
	
		return session.delete("chat.disconnectChatRoom", chatroomJoin);
	}
	
	
	
}

