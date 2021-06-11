package com.fpjt.upmu.chat.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.fpjt.upmu.chat.model.service.ChatService;
import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	// private final ChatRoomRepository chatRoomRepository;

	@Autowired
	private ChatService chatService;

	// 채팅리스트 화면
	@GetMapping("/chatRoomList.do")
	public String chatRoomList(Model model) {

		try {
			List<ChatRoom> chatRoomList = chatService.chatRoomList();
			log.debug("chatRoomList {}", chatRoomList);
			model.addAttribute("chatRoomList", chatRoomList);
			return "chat/chatRoomList";
		} catch (Exception e) {
			log.error("채팅 리스트 조회 오류", e);
			throw e;
		}
	}

	
	@GetMapping("/chatRoomDelete/{chatroomNo}")
	public String chatRoomDelete(@PathVariable int chatroomNo) {
		log.debug("chatroomNo = {}", chatroomNo);
		int result = chatService.deleteChatRoom(chatroomNo);
		return  "redirect:/chat/chatRoomList";
	}
	


	// 채팅방 생성
	@PostMapping("/room")
	public String createRoom(@RequestBody ChatRoom chatRoom) {
		log.debug("chatRoom {}", chatRoom);

		int result = chatService.insertChatRoom(chatRoom);
		log.debug("result {}", result);
		return "redirect:/chat/chatRoomList";
	}

	// 채팅방 입장
	@GetMapping("/room/enter/{chatroomNo}")
	public String roomDetail(Model model, @PathVariable int chatroomNo) {

		log.debug("chatroomNo {}", chatroomNo);
		// 기존에 저장된 채팅메세지
		List<ChatMsg> chatMsgList = chatService.selectedRoomChatList(chatroomNo);

		model.addAttribute("chatMsgList", chatMsgList);
		model.addAttribute("chatroomNo", chatroomNo);
		return "/chat/roomDetail";
	}

	
	//----------------- 메세지 관련 ---------------------

	// 메세지 출력
	@MessageMapping("/message")
	public void message(ChatMsg chatMsg) {
		int result = chatService.insertChatMsg(chatMsg);
		log.debug("msg {}", chatMsg);
		simpMessagingTemplate.convertAndSend("/topic/chat/room/" + chatMsg.getChatroomNo(), chatMsg);
	}
	
	// 참여 내용 출력
	@MessageMapping("/join")
	public void join(ChatRoomJoin chatroomJoin) {
		log.debug("chatroomJoin {}", chatroomJoin);
		int result = chatService.joinChatRoom(chatroomJoin);
		simpMessagingTemplate.convertAndSend("/topic/chat/greeting/" + chatroomJoin.getChatroomNo(), chatroomJoin.getEmpNo());
	}
	
	@MessageMapping("/directMsg")
	public void grreting(DirectMsg directMsg) {
		log.debug("directMsg {}", directMsg);
		simpMessagingTemplate.convertAndSendToUser(String.valueOf(directMsg.getMessageReceiver()), "/directMsg", directMsg);
	}
	
	@MessageMapping("/disconnect")
	public void disconnect(ChatRoomJoin chatroomJoin) {
		log.debug("chatroomJoin {}", chatroomJoin);
		int result = chatService.disconnectChatRoom(chatroomJoin);
		simpMessagingTemplate.convertAndSend("/topic/chat/disconnect/" + chatroomJoin.getChatroomNo(), chatroomJoin.getEmpNo());
	}
	
	
	private Set<String> connectedUsers = new HashSet<>();

	// 채팅방에 입장한 유저 출력
	@MessageMapping("/register")
	@SendToUser("/queue/newMember")
	public Set<String> registerUser(String webChatUsername) {
		log.debug("webChatUsername {}", webChatUsername);
		if (!connectedUsers.contains(webChatUsername)) {
			connectedUsers.add(webChatUsername);
			log.debug("connectedUsers {}", connectedUsers);
			simpMessagingTemplate.convertAndSend("/topic/newMember", webChatUsername);
			return connectedUsers;
		} else {
			return new HashSet<>();
		}
	}

}
