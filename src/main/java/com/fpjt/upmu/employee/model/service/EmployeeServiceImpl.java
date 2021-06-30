package com.fpjt.upmu.employee.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.employee.model.dao.EmployeeDao;
import com.fpjt.upmu.employeeList.model.vo.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao empDao;

	@Override
	public int insertEmployee(Employee employee) {
		return	empDao.insertEmployee(employee);
	}

	@Override
	public Employee selectOneEmp(String id) {
		return empDao.selectOneEmp(id);
	}

	@Override
	public String selectId(Map<String, String> emp) {
		return empDao.selectId(emp);
	}

	@Override
	public String selectCheckId(String id) {
		return empDao.selectCheckId(id);
	}
	
	
}
