package com.fpjt.upmu.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.chat.model.dao.ChatDao;
import com.fpjt.upmu.chat.model.vo.ChatRoom;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;
	
	@Override
	public List<ChatRoom> chatRoomList() {
		
		return chatDao.chatRoomList();
	}

}
