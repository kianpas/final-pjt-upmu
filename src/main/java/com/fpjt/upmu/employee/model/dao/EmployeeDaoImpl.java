package com.fpjt.upmu.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.employeeList.model.vo.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertEmployee(Employee employee) {
		return session.insert("member.insertMember", employee);
	}
	

}
