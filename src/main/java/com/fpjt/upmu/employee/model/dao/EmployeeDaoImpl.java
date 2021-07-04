package com.fpjt.upmu.employee.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.employee.model.vo.EmpProfile;
import com.fpjt.upmu.employee.model.vo.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertEmployee(Employee employee) {
		return session.insert("employee.insertEmp", employee);
	}

	@Override
	public int insertRole(String empEmail) {
		return session.insert("employee.insertRole", empEmail);
	}

	
	@Override
	public void insertAuth(String email) {
		session.insert("employee.insertAuth", email);
	}

	@Override
	public void deleteAuth(String email) {
		session.delete("employee.deleteAuth", email);
	}

	@Override
	public Employee selectOneEmp(String id) {
		return session.selectOne("employee.selectOneEmp", id);
	}

	@Override
	public String selectId(Map<String, String> emp) {
		return session.selectOne("employee.selectId", emp);
	}

	@Override
	public String selectCheckId(String id) {
		return session.selectOne("employee.selectCheckId", id);
	}

	@Override
	public int insertPwSearch(Map<String, String> map) {
		return session.insert("employee.insertPwSearch", map);
	}

	@Override
	public String selectCheckPw(String id) {
		return session.selectOne("employee.selectCheckPw", id);
	}

	@Override
	public void deleteSearchPw(String id) {
		session.delete("employee.deleteSearchPw", id);
	}

	@Override
	public String selectPwSearchId(String authVal) {
		return session.selectOne("employee.selectPwSearchId", authVal);
	}

	@Override
	public int updatePw(Map<String, String> map) {
		return session.update("employee.updatePw", map);
	}

	@Override
	public void updateEmp(Map<String, Object> rawEmp) {
		session.update("employee.updateEmp", rawEmp);
	}

	@Override
	public void deleteEmp(String empEmail) {
		session.delete("employee.deleteEmp", empEmail);	
	}

	@Override
	public int insertProfile(EmpProfile profile) {
		return session.insert("employee.insertProfile", profile);
	}

	@Override
	public String selectProfileName(int empNo) {
		return session.selectOne("employee.selectProfileName", empNo);
	}

	@Override
	public int updateProfile(EmpProfile profile) {
		return session.update("employee.updateProfile", profile);
	}

	@Override
	public String selectProfile(String param) {
		return session.selectOne("employee.selectProfile", param);
	}
	
	
}
