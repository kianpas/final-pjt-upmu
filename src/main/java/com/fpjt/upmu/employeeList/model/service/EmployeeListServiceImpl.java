package com.fpjt.upmu.employeeList.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springsource.loaded.Log;

import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.dao.EmployeeListDao;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Job;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class EmployeeListServiceImpl implements EmployeeListService {

	@Autowired
	EmployeeListDao elDao;
	
	@Override
	public List<Employee> selectEmployeeList() {
		return elDao.selectEmployeeList();
	}

	@Override
	public List<Department> selectDeptList() {
		return elDao.selectDeptList();
	}

	@Override
	public int insertDept(Department dept) {
		return elDao.insertDept(dept);
	}

	@Override
	public List<Employee> selectDeptEmpList(String depNo) {
		return elDao.selectDeptEmpList(depNo);
	}

	@Override
	public List<Employee> selectSearchList(Map<String, String> keyword) {
		return elDao.selectSearchList(keyword);
	}

	@Override
	public int deleteDept(String param) {
		return elDao.deleteDept(param);
	}

	@Override
	public int updateDept(Map<String, Object> map) {
		return elDao.updateDept(map);
	}

	@Override
	public List<Job> selectJobList() {
		return elDao.selectJobList();
	}

	@Override
	public Employee selectOneEmp(String param) {
		return elDao.selelctOneEmp(param);
	}
	
	
}
