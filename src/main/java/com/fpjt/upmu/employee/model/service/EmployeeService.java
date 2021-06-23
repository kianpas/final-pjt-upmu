package com.fpjt.upmu.employee.model.service;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeService {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);
}
