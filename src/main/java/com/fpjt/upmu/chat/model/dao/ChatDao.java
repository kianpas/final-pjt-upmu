package com.fpjt.upmu.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.chat.model.vo.ChatMsg;
import com.fpjt.upmu.chat.model.vo.ChatMsgExt;
import com.fpjt.upmu.chat.model.vo.ChatRoom;
import com.fpjt.upmu.chat.model.vo.ChatRoomJoin;
import com.fpjt.upmu.chat.model.vo.DirectMsg;

public interface ChatDao {

	List<ChatRoom> chatRoomList();

	int insertChatRoom(ChatRoom chatRoom);

	List<ChatMsgExt> selectedRoomChatList(int chatroomNo);

	int deleteChatRoom(int chatroomNo);

	int insertChatMsg(ChatMsg chatMsg);

	int joinChatRoom(ChatRoomJoin chatroomJoin);

	int disconnectChatRoom(ChatRoomJoin chatroomJoin);

	List<Map<String, Object>> roomUserList(int chatroomNo);

	int insertDirectMsg(DirectMsg directMsg);

	int updateChatRoom(ChatRoom chatRoom);

	List<DirectMsg> selectDmList(Map<String, Object> map);

	int updateChat(ChatMsg chatMsg);

	int deleteChat(int msgNo);

	int updateDm(DirectMsg directMsg);

	int deleteDm(int messegeNo);

	ChatRoom selectOneChatRoom(int chatroomNo);

	List<Map<String, Object>> joinList(int empNo);

	ChatRoomJoin selectOneJoin(ChatRoomJoin chatRoomJoin);

}
