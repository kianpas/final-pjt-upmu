package com.fpjt.upmu.chat.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString(callSuper = true)
@Data
@NoArgsConstructor
public class ChatRoomJoinExt extends ChatRoomJoin {

	private String empName;
}
