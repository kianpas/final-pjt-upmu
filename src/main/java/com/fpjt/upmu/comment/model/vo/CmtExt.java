package com.fpjt.upmu.comment.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CmtExt extends Cmt {
	
	private String empName;

}
