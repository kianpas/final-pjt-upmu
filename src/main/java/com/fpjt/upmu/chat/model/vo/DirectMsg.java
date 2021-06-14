package com.fpjt.upmu.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class DirectMsg {
	
	private int messageNo;
	private String messageContent;
	private Date messageTime;
	private int messageSender;
	private int messageReceiver;
	private String readCheck;
}
