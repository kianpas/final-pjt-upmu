package com.fpjt.upmu.notice.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {

	private int no;
	private int empNo;
	private String linkAddr;
	private String notiType;
	private boolean checked;
	private Date regDate;

}
