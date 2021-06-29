package com.fpjt.upmu.chat.model.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class ChatMsgExt extends ChatMsg {

	private String empName;
}
