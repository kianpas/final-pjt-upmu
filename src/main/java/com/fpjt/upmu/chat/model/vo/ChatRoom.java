package com.fpjt.upmu.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChatRoom {

	private int chatRoomNo;
	private String title;
	private int empCreate;
	private Date regDate;
}
