package com.fpjt.upmu.employee.model.dao;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeDao {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);
	
}
