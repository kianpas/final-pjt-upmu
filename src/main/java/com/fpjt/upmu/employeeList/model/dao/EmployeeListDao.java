package com.fpjt.upmu.employeeList.model.dao;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.vo.Job;

public interface EmployeeListDao {

	List<Employee> selectEmployeeList();

	List<Department> selectDeptList();

	int insertDept(Department dept);

	List<Employee> selectDeptEmpList(String depNo);

	List<Employee> selectSearchList(Map<String, String> keyword);

	int deleteDept(String param);

	int updateDept(Map<String, Object> map);

	List<Job> selectJobList();

	Employee selelctOneEmp(String param);

}