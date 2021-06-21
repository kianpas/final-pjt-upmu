package com.fpjt.upmu.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChatRoomJoin {
	
	private int joinId;
	private int empNo;
	private int chatroomNo;
	private Date regDate;
}
