package com.fpjt.upmu.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.fpjt.upmu.chat.model.service.ChatService;
import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	@Autowired
	private ChatService chatService;

	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;

	// 메세지 출력
	@MessageMapping("/message")
	public void message(ChatMsg chatMsg) {

		try {
			int result = chatService.insertChatMsg(chatMsg);

			log.debug("msg {}", chatMsg);
		} catch (Exception e) {
			log.error("메세지 조회 오류", e);
			throw e;
		}

		simpMessagingTemplate.convertAndSend(
				"/topic/chat/room/" + chatMsg.getChatroomNo(), chatMsg);
	}

	// 참여 내용 출력
	@MessageMapping("/join")
	public void join(ChatRoomJoin chatroomJoin) {

		try {
			
			int result = chatService.joinChatRoom(chatroomJoin);
			//ChatRoomJoin joinInfo = chatService.selectChatRoomJoin(chatroomJoin);
			log.debug("chatroomJoin {}", chatroomJoin);
		} catch (Exception e) {
			log.error("챗룸 참여 오류", e);
			throw e;
		}

		simpMessagingTemplate.convertAndSend("/topic/chat/greeting/" + chatroomJoin.getChatroomNo(),
				chatroomJoin);
	}

	// 개인메세지 출력
	@MessageMapping("/directMsg")
	public void directMsg(DirectMsg directMsg) {
		try {
			log.debug("directMsg {}", directMsg);
			int result = chatService.insertDirectMsg(directMsg);
		} catch (Exception e) {
			log.error("개인메세지 입력 오류", e);
			throw e;
		}
		simpMessagingTemplate.convertAndSendToUser(
				String.valueOf(directMsg.getMessageReceiver()), "/directMsg",
				directMsg);
	}

	// 메세지 수정
	@MessageMapping("/update")
	public void updateMsg(ChatMsg chatMsg) {
		try {
			log.debug("chatMsgchatMsgchatMsgchatMsg {}", chatMsg);
			int result = chatService.updateChat(chatMsg);

		} catch (Exception e) {
			log.error("개인메세지 입력 오류", e);
			throw e;
		}
		simpMessagingTemplate.convertAndSend(
				"/topic/chat/updated/" + chatMsg.getChatroomNo(), chatMsg);

	}

	// 메세지 삭제
	@MessageMapping("/delete")
	public void deleteMsg(ChatMsg chatMsg) {
		int roomNo = 0;
		try {
			roomNo = chatMsg.getChatroomNo();
			log.debug("roomNo {}", roomNo);
			log.debug("chatMsgchatMsgchatMsgchatMsg {}", chatMsg);
			int result = chatService.deleteChat(chatMsg.getMsgNo());

		} catch (Exception e) {
			log.error("개인메세지 입력 오류", e);
			throw e;
		}

		simpMessagingTemplate.convertAndSend(
				"/topic/chat/deleted/" + roomNo, roomNo);

	}

	// 메세지 수정
	@MessageMapping("/updateDm")
	public void updateDm(DirectMsg directMsg) {
		try {
			log.debug("chatMsgchatMsgchatMsgchatMsg {}", directMsg);
			int result = chatService.updateDm(directMsg);

		} catch (Exception e) {
			log.error("개인메세지 입력 오류", e);
			throw e;
		}
		simpMessagingTemplate.convertAndSendToUser(
				String.valueOf(directMsg.getMessageReceiver()), "/updated",
				directMsg);

	}

	// 메세지 삭제
	@MessageMapping("/deleteDm")
	public void deleteDm(DirectMsg directMsg) {
		int result = 0;
		try {

			log.debug("directMsg {}", directMsg);
			result = chatService.deleteDm(directMsg.getMessageNo());

		} catch (Exception e) {
			log.error("개인메세지 입력 오류", e);
			throw e;
		}

		simpMessagingTemplate.convertAndSendToUser(
				String.valueOf(directMsg.getMessageReceiver()), "/deleted", result);

	}

	// 나갈경우 출력메세지
	@MessageMapping("/disconnect")
	public void disconnect(ChatRoomJoin chatroomJoin) {
		try {
			log.debug("chatroomJoin {}", chatroomJoin);
			int result = chatService.disconnectChatRoom(chatroomJoin);
		} catch (Exception e) {
			log.error("챗룸 퇴장 오류", e);
			throw e;
		}
		simpMessagingTemplate.convertAndSend("/topic/chat/disconnect/" 
		+ chatroomJoin.getChatroomNo(),
				chatroomJoin.getEmpNo());
	}

	// 테스트용
//		private Set<String> connectedUsers = new HashSet<>();
	//
//		// 채팅방에 입장한 유저 출력
//		@MessageMapping("/register")
//		@SendToUser("/queue/newMember")
//		public Set<String> registerUser(String webChatUsername) {
//			log.debug("webChatUsername {}", webChatUsername);
//			if (!connectedUsers.contains(webChatUsername)) {
//				connectedUsers.add(webChatUsername);
//				log.debug("connectedUsers {}", connectedUsers);
//				simpMessagingTemplate.convertAndSend("/topic/newMember", webChatUsername);
//				return connectedUsers;
//			} else {
//				return new HashSet<>();
//			}
//		}
}
