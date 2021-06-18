package com.fpjt.upmu.document.model.vo;


import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Document {
	
	private int docNo;
	private String title;
	private int writer;
	private String content;
	private Date requestDate;
	private Date endDate;
	//private String status;
	
	private List<DocLine> docLine;
	
	private String writerName;
}
