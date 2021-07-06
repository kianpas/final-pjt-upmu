package com.fpjt.upmu.schedule.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
	
	private int schNo;
	private int empNo;
	private String schTitle;
	private String schContent;
	private String schStart;
	private String schEnd;
	private String schType;
	private String shareSch;

}
