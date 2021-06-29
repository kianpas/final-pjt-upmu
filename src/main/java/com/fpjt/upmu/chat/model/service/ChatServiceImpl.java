package com.fpjt.upmu.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.chat.model.dao.ChatDao;
import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatMsgExt;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;
	
	@Override
	public List<ChatRoom> chatRoomList() {
		
		return chatDao.chatRoomList();
	}

	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		
		return chatDao.insertChatRoom(chatRoom);
	}

	@Override
	public List<ChatMsgExt> selectedRoomChatList(int chatroomNo) {
		
		return chatDao.selectedRoomChatList(chatroomNo);
	}

	@Override
	public int deleteChatRoom(int chatroomNo) {
		
		return chatDao.deleteChatRoom(chatroomNo);
	}

	@Override
	public int insertChatMsg(ChatMsg chatMsg) {
		
		return chatDao.insertChatMsg(chatMsg);
	}

	@Override
	public int joinChatRoom(ChatRoomJoin chatroomJoin) {
		
		return chatDao.joinChatRoom(chatroomJoin);
	}

	@Override
	public int disconnectChatRoom(ChatRoomJoin chatroomJoin) {
		
		return chatDao.disconnectChatRoom(chatroomJoin);
	}

	@Override
	public List<Map<String, Object>> roomUserList(int chatroomNo) {
		
		return chatDao.roomUserList(chatroomNo);
	}

	@Override
	public int insertDirectMsg(DirectMsg directMsg) {
		
		return chatDao.insertDirectMsg(directMsg);
	}

	@Override
	public int updateChatRoom(ChatRoom chatRoom) {
		
		return chatDao.updateChatRoom(chatRoom);
	}

	@Override
	public List<DirectMsg> selectDmList(Map<String, Object> map) {
		
		return chatDao.selectDmList(map);
	}

	@Override
	public int updateChat(ChatMsg chatMsg) {
		
		return chatDao.updateChat(chatMsg);
	}

	@Override
	public int deleteChat(int msgNo) {
		
		return chatDao.deleteChat(msgNo);
	}

	@Override
	public int updateDm(DirectMsg directMsg) {
		
		return chatDao.updateDm(directMsg);
	}

	@Override
	public int deleteDm(int messegeNo) {
		
		return chatDao.deleteDm(messegeNo);
	}

	@Override
	public ChatRoom selectOneChatRoom(int chatroomNo) {
		
		return chatDao.selectOneChatRoom(chatroomNo);
	}

	@Override
	public List<Map<String, Object>> joinList(int empNo) {
		
		return chatDao.joinList(empNo);
	}

	@Override
	public ChatRoomJoin selectOneJoin(ChatRoomJoin chatRoomJoin) {
		
		return chatDao.selectOneJoin(chatRoomJoin);
	}

	
	
}
