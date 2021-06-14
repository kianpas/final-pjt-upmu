package com.fpjt.upmu.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Member {

	private int emp_no; //사원사번
	private String emp_name; //사원이름
	private String emp_pw; //사원비밀번호
	private int emp_phone; //사원핸드폰번호
	private String emp_email; //사원이메일아이디
	private String emp_addr; //사원주소
	private Date emp_birth; //사원 생일
	private String emp_state; //사원계정상태
	private Date emp_hiredate; //사원입사일
	private String department; //사원부서
	private String emp_gender; //사원성별
}
