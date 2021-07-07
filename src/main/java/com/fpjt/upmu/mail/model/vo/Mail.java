package com.fpjt.upmu.mail.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Mail {
	
	private int mailNo;
	private int senderAdd;
	private String receiverAdd;
	private String mailTitle;
	private String mailContent;
	private Date sendDate;
	private String readChk;
	//
	private int senderDel;
	private String receiverDel;
	//
	private String senderName;
	

}
