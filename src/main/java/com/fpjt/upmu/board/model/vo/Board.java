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
	private String emp_no;
	private String content;
	private Date regDate;
	private int readCount;

}
