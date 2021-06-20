package com.fpjt.upmu.document.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocAttach {
	private int no;
	private int docNo;
	private String originalFilename;
	private String renamedFilename;
	private Date uploadDate;
	private boolean status;	//status ----- 'Y', 'N'
}
