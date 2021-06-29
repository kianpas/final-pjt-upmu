package com.fpjt.upmu.comment.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Cmt {

	private int cmtNo;
	private int boardNo;
	private int empNo;
	private String cmtContent;
	private Date cmtTime;
}
