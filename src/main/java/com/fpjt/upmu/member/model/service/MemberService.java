package com.fpjt.upmu.member.model.service;

import com.fpjt.upmu.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);
	
	Member selectOneMember(int emp_no);
	
	int updateMember(Member member);
}
