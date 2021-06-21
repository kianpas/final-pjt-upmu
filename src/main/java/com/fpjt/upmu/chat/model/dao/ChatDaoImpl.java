package com.fpjt.upmu.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

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

	@Override
	public List<ChatRoomJoin> roomUserList(int chatroomNo) {
	
		return session.selectList("chat.roomUserList", chatroomNo);
	}

	@Override
	public int insertDirectMsg(DirectMsg directMsg) {
		
		return session.insert("chat.insertDirectMsg", directMsg);
	}

	@Override
	public int updateChatRoom(ChatRoom chatRoom) {
		
		return session.update("chat.updateChatRoom", chatRoom);
	}

	@Override
	public List<DirectMsg> selectDmList(Map<String, Object> map) {
		
		return session.selectList("chat.selectDmList", map);
	}

	@Override
	public int updateChat(ChatMsg chatMsg) {
		
		return session.update("chat.updateChat", chatMsg);
	}

	@Override
	public int deleteChat(int msgNo) {
		
		return session.delete("chat.deleteChat", msgNo);
	}

	@Override
	public int updateDm(DirectMsg directMsg) {
		
		return session.update("chat.updateDm", directMsg);
	}

	@Override
	public int deleteDm(int messegeNo) {
		
		return session.delete("chat.deleteDm", messegeNo);
	}

	@Override
	public ChatRoom selectOneChatRoom(int chatroomNo) {
		
		return session.selectOne("chat.selectOneChatRoom", chatroomNo);
	}

	@Override
	public List<Map<String, Object>> joinList(int empNo) {
		
		return session.selectList("chat.joinList", empNo);
	}
	
	
	
}

