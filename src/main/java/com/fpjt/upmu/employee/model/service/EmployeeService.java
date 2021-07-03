package com.fpjt.upmu.employee.model.service;

import java.util.Map;

import com.fpjt.upmu.employeeList.model.vo.Employee;

public interface EmployeeService {

	int insertEmployee(Employee employee);

	Employee selectOneEmp(String id);

	String selectId(Map<String, String> emp);

	String selectCheckId(String id);

	String sendMail(String id, String encodedNum);

	int insertPwSearch(Map<String, String> map);

	String selectCheckPwSearch(String id);

	void deleteSearchPw(String id);

	String selectPwSearchId(String authVal);

	int updatePw(Map<String, String> map);

	void updateEmp(Map<String, Object> rawEmp);

	void deleteEmp(String empEmail);

}
