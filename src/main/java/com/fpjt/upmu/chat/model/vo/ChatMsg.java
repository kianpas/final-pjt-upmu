package com.fpjt.upmu.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChatMsg {
	
	private int msgNo;
	private int chatroomNo;
	private int writerNo;
	private String msg;
	private Date regDate;
	
	
}
