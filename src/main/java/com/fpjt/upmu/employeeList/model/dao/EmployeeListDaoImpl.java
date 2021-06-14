package com.fpjt.upmu.employeeList.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Employee;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class EmployeeListDaoImpl implements EmployeeListDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Employee> selectEmployeeList() {
		return session.selectList("employeeList.selectEmployeeList");
	}

	@Override
	public List<Department> selectDeptList() {
		return session.selectList("employeeList.selectDeptList");
	}

	@Override
	public int insertDept(Department dept) {
		return session.insert("employeeList.insertDept", dept);
	}

	@Override
	public List<Employee> selectDeptEmpList(String depNo) {
		return session.selectList("employeeList.selectDeptEmpList", depNo);
	}

	@Override
	public List<Employee> selectSearchList(Map<String, String> keyword) {
		return session.selectList("employeeList.selectSearchList", keyword);
	}

	@Override
	public int deleteDept(String param) {
		return session.delete("employeeList.deleteDept", param);
	}
}
