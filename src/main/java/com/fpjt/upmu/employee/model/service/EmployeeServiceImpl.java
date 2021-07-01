package com.fpjt.upmu.employee.model.service;

import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.employee.model.dao.EmployeeDao;
import com.fpjt.upmu.employeeList.model.vo.Employee;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao empDao;

	@Autowired
    JavaMailSender mailSender;
	
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

	@Override
	public String sendMail(String id) {
		//이메일 객체
		MimeMessage ms = mailSender.createMimeMessage();
		
		try {
			//수신 설정
			ms.addRecipient(RecipientType.TO, new InternetAddress(id));
			
			//송신 설정
			ms.addFrom(new InternetAddress[] { new InternetAddress("theupmuteam@gmail.com", "UPMU팀")});
			
			//이메일 제목
			ms.setSubject("UPMU 비밀번호 재설정", "utf-8");
			//이메일 내용
			ms.setContent("<a href='http://localhost:9090/upmu/employee/mailPwSearch.do'>클릭하시면 비밀번호를 다시 설정할 수 있습니다.</a>", "text/html;charset=euc-kr");
			
			mailSender.send(ms);
		} catch (Exception e) {
			log.error("비번찾기 이메일 송신 오류");
		}

		return "";
	}
	
	
}
