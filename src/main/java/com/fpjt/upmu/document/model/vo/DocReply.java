package com.fpjt.upmu.document.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//no	number		NOT NULL,
//doc_no	number		NOT NULL,
//writer	number		NOT NULL,
//content	varchar2(2048)		NOT NULL,
//reg_date	date		NOT NULL

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocReply {
	private int no;
	private int docNo;
	private int writer;
	private String content;
	private Date regDate;
	
	private String writerName;
	private String depName;
	private String jobName;
}
