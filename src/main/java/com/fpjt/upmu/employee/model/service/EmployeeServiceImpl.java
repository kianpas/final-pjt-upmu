package com.fpjt.upmu.employee.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.employee.model.dao.EmployeeDao;
import com.fpjt.upmu.employeeList.model.vo.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao memberDao;

	@Override
	public int insertEmployee(Employee employee) {
		return memberDao.insertEmployee(employee);
	}
}
