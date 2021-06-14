package com.fpjt.upmu.member.model.dao;

import com.fpjt.upmu.member.model.vo.Member;

public interface MemberDao {

	int insertMember(Member member);
	
	Member selectOneMember(int emp_no);
	
	int updateMember(Member member);
}
