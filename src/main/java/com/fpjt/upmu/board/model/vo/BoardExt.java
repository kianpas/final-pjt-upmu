package com.fpjt.upmu.board.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
//@ToString(callSuper = true)
@NoArgsConstructor
public class BoardExt extends Board {
	
	private boolean hasAttachment;

	public BoardExt(int board_no, String board_title, String emp_no, String board_content, Date board_time,
			int board_count, boolean hasAttachment) {
		super(board_no, board_title, emp_no, board_content, board_time, board_count);
		this.hasAttachment = hasAttachment;
	}
	
}
