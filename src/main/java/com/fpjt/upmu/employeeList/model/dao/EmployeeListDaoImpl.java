package com.fpjt.upmu.employeeList.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.employee.model.vo.Employee;
import com.fpjt.upmu.employeeList.model.vo.Department;
import com.fpjt.upmu.employeeList.model.vo.Job;

import lombok.extern.slf4j.Slf4j;

@Repository
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

	@Override
	public int updateDept(Map<String, Object> map) {
		return session.update("employeeList.updateDept", map);
	}

	@Override
	public List<Job> selectJobList() {
		return session.selectList("employeeList.selectJobList");
	}

	@Override
	public Employee selelctOneEmp(String param) {
		return session.selectOne("employeeList.selectOneEmp", param);
	}

	
}
