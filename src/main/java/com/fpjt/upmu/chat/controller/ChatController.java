package com.fpjt.upmu.chat.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.HtmlUtils;

import com.fpjt.upmu.address.model.vo.Address;
import com.fpjt.upmu.chat.model.service.ChatService;
import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatMsgExt;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

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
			log.error("채팅룸 리스트 조회 오류", e);
			throw e;
		}
	}

	// 채팅리스트2 화면(임시)
	@GetMapping("/chatRoomList2.do")
	public String chatRoomList2(Model model) {

		try {
			List<ChatRoom> chatRoomList = chatService.chatRoomList();
			log.debug("chatRoomList {}", chatRoomList);
			model.addAttribute("chatRoomList", chatRoomList);
			return "chat/chatRoomList2";
		} catch (Exception e) {
			log.error("채팅룸 리스트 조회 오류", e);
			throw e;
		}
	}

	// 채팅방 생성
	@PostMapping("/room")
	public String createRoom(ChatRoom chatRoom, RedirectAttributes redirectAttr) {

		try {
			log.debug("chatRoom {}", chatRoom);
			int result = chatService.insertChatRoom(chatRoom);
			return "redirect:/chat/chatRoomList.do";
		} catch (Exception e) {
			log.error("채팅룸 생성 오류", e);
			throw e;
		}
	}

	// 채팅방 삭제
	@PostMapping("/chatRoomDelete/{chatroomNo}")
	public String chatRoomDelete(@PathVariable int chatroomNo, RedirectAttributes redirectAttr) {

		try {
			log.debug("chatroomNo = {}", chatroomNo);
			int result = chatService.deleteChatRoom(chatroomNo);
			return "redirect:/chat/chatRoomList.do";
		} catch (Exception e) {
			log.error("채팅룸 삭제 오류", e);
			throw e;
		}
	}

	// 채팅방 수정
	@PostMapping("/chatRoomUpdate")
	public String chatRoomUpdate(ChatRoom chatRoom, RedirectAttributes redirectAttr) {

		try {
			log.debug("upchatRoom = {}", chatRoom);
			int result = chatService.updateChatRoom(chatRoom);
			return "redirect:/chat/chatRoomList.do";
		} catch (Exception e) {
			log.error("채팅룸 수정 오류", e);
			throw e;
		}
	}

	// 채팅방 입장
	@GetMapping("/room/enter/{chatroomNo}")
	public String roomDetail(Model model, @PathVariable int chatroomNo) {

		try {
			log.debug("chatroomNo {}", chatroomNo);
			// 기존에 저장된 채팅메세지
			ChatRoom chatroom = chatService.selectOneChatRoom(chatroomNo);
			// 유저리스트 가져오기
			List<Map<String, Object>> userList = chatService.roomUserList(chatroomNo);

			log.debug("userList ---  {}", userList);
			model.addAttribute("chatroom", chatroom);
			model.addAttribute("chatroomNo", chatroomNo);
			
			return "/chat/roomDetail";
		} catch (Exception e) {
			log.error("채팅룸 입장 오류", e);
			throw e;
		}
	}

	// 채팅리스트 json으로
	@GetMapping("/room/chatList/{chatroomNo}")
	@ResponseBody
	public List<ChatMsgExt> chatList(Model model, @PathVariable int chatroomNo) {

		try {
			log.debug("chatroomNo {}", chatroomNo);
			// 기존에 저장된 채팅메세지
			List<ChatMsgExt> chatMsgList = chatService.selectedRoomChatList(chatroomNo);
			// 유저리스트 가져오기
			List<Map<String, Object>> userList = chatService.roomUserList(chatroomNo);

			log.debug("userList ---  {}", userList);
			// model.addAttribute("chatMsgList", chatMsgList);
			model.addAttribute("chatroomNo", chatroomNo);
			return chatMsgList;
		} catch (Exception e) {
			log.error("채팅리스트 조회 오류", e);
			throw e;
		}
	}

	// json으로 보낼경우 @ResponseBody 사용
	@GetMapping("/userList/{chatroomNo}")
	@ResponseBody
	public List<Map<String, Object>> userList(@PathVariable int chatroomNo) {

		try {
			log.debug("chatroomNo +++{}", chatroomNo);
			// 유저리스트 가져오기
			//List<ChatRoomJoin> userList = chatService.roomUserList(chatroomNo);
			List<Map<String, Object>> userList = chatService.roomUserList(chatroomNo);
			log.debug("userList +++  {}", userList);

			return userList;

		} catch (Exception e) {
			log.error("유저리스트 조회 오류", e);
			throw e;
		}
	}
	
	// json으로 보낼경우 @ResponseBody 사용
		@GetMapping("/joinList/{empNo}")
		@ResponseBody
		public List<Map<String, Object>> joinList(@PathVariable int empNo) {

			try {
				log.debug("empNo +++{}", empNo);
				// 참여 리스트 가져오기
				List<Map<String, Object>> joinList = chatService.joinList(empNo);
				log.debug("joinList +++  {}", joinList);

				return joinList;

			} catch (Exception e) {
				log.error("참여리스트 조회 오류", e);
				throw e;
			}
		}

	// 개인메세지
	@GetMapping("/dmList/{username}/{recvname}")
	@ResponseBody
	public List<DirectMsg> dmList(@PathVariable int username, @PathVariable int recvname) {

		try {
			log.debug("recvname +++{}", recvname);
			log.debug("username +++{}", username);
			Map<String, Object> map = new HashMap<>();
			map.put("username", username);
			map.put("recvname", recvname);
			// 개인메세지리스트 가져오기
			List<DirectMsg> dmList = chatService.selectDmList(map);

			return dmList;

		} catch (Exception e) {
			log.error("개인메세지 조회 오류", e);
			throw e;
		}
	}

	@GetMapping("/checkJoinDuplicate")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam int empNo, @RequestParam int chatroomNo) {
		//1. 업무로직
		try {
			ChatRoomJoin chatRoomJoin = new ChatRoomJoin(0, empNo, chatroomNo, null);
			ChatRoomJoin join = chatService.selectOneJoin(chatRoomJoin);
			boolean available = join == null;
			log.debug("empNo {}, chatroomNo {}", empNo, chatroomNo);
			log.debug("join {}", join);
			//2. Map에 속성 저장
			Map<String, Object> map = new HashMap<>();
			map.put("available", available);
			map.put("join", join);		
			
			return map;
		} catch (Exception e) {
			log.error("중복여부 조회 오류", e);
			throw e;
		}
	}
}
