package com.fpjt.upmu.employee.model.dao;

import java.util.Map;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeDao {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);

	String selectId(Map<String, String> emp);

	String selectCheckId(String id);

	int insertPwSearch(Map<String, String> map);

	String selectCheckPw(String id);

	void deleteSearchPw(String id);

	String selectPwSearchId(String authVal);

	int updatePw(Map<String, String> map);

	void updateEmp(Map<String, Object> rawEmp);
	
}
