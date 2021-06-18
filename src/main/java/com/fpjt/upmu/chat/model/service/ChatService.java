package com.fpjt.upmu.chat.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

public interface ChatService {

	public List<ChatRoom> chatRoomList();

	public int insertChatRoom(ChatRoom chatRoom);

	public List<ChatMsg> selectedRoomChatList(int chatroomNo);

	public int deleteChatRoom(int chatroomNo);

	public int insertChatMsg(ChatMsg chatMsg);

	public int joinChatRoom(ChatRoomJoin chatroomJoin);

	public int disconnectChatRoom(ChatRoomJoin chatroomJoin);

	public List<ChatRoomJoin> roomUserList(int chatroomNo);

	public int insertDirectMsg(DirectMsg directMsg);

	public int updateChatRoom(ChatRoom chatRoom);

	public List<DirectMsg> selectDmList(Map<String, Object> map);

	public int updateChat(ChatMsg chatMsg);

	public int deleteChat(int msgNo);

	public int updateDm(DirectMsg directMsg);

	public int deleteDm(int messegeNo);

		

}
