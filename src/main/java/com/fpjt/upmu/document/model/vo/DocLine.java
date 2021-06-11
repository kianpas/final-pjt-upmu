package com.fpjt.upmu.document.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocLine {
	
	private String docNo;
	private int approver;
	private String approverType;
	private int lv;
	private String status;
	private String maxAuthority;
	
	private String empName;
	private String jobName;
}
