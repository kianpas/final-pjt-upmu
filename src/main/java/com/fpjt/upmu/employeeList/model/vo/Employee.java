package com.fpjt.upmu.employeeList.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Employee {

	private int empNo;
	private String empName;
	private String empPw;
	private String empPhone;
	private String empEmail;
	private String empAddr;
	private Date empBirth;
	private String empState;
	private Date empHiredate;
	private String empDept;
	private String empJob;
	
}
