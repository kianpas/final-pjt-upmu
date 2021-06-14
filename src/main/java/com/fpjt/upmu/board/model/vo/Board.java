package com.fpjt.upmu.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {


	private int no;
	private String title;
	private String memberId;
	private String content;
	private Date regDate;
	private int readCount;
		

	private int board_no;
	private String board_title;
	private String emp_no;
	private String board_content;
	private Date board_time;
	private int board_count;

}
