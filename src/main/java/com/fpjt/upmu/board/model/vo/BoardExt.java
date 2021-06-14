package com.fpjt.upmu.board.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class BoardExt extends Board {
	
	private boolean hasAttachment;

	
	
	
}
