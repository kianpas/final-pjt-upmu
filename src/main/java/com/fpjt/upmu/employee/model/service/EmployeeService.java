package com.fpjt.upmu.employee.model.service;

import java.util.Map;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeService {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);

	String selectId(Map<String, String> emp);

	String selectCheckId(String id);

	String sendMail(String id);
}
