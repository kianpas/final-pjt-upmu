package com.fpjt.upmu.document.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DocForm {
	
	private int no;
	private String title;
	private String content;
	private String type;

}
