package com.fpjt.upmu.employee.model.dao;

import java.util.Map;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeDao {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);

	String selectId(Map<String, String> emp);

	String selectCheckId(String id);
	
}
