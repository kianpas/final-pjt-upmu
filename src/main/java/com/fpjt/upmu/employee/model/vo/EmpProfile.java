package com.fpjt.upmu.employee.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmpProfile {

	private int empNo;
	private String originalFilename;
	private String renamedFilename;
}
