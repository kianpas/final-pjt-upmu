package com.fpjt.upmu.chat.model.dao;

import java.util.List;

import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

public interface ChatDao {

	List<ChatRoom> chatRoomList();

	int insertChatRoom(ChatRoom chatRoom);

	List<ChatMsg> selectedRoomChatList(int chatroomNo);

	int deleteChatRoom(int chatroomNo);

	int insertChatMsg(ChatMsg chatMsg);

	int joinChatRoom(ChatRoomJoin chatroomJoin);

	int disconnectChatRoom(ChatRoomJoin chatroomJoin);

	List<ChatRoomJoin> roomUserList(int chatroomNo);

	int insertDirectMsg(DirectMsg directMsg);

	int updateChatRoom(ChatRoom chatRoom);

}
