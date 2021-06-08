package com.fpjt.upmu.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fpjt.upmu.chat.model.service.ChatService;
import com.fpjt.upmu.chat.model.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chatRoomList.do")
	public String chatRoomList() {
		
		List<ChatRoom> chatRoomList = chatService.chatRoomList();
		
		return "chat/chatRoomList";
	}

}
