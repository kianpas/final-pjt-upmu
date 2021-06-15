package com.fpjt.upmu.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.member.model.dao.MemberDao;
import com.fpjt.upmu.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectOneMember(int emp_no) {
		return memberDao.selectOneMember(emp_no);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}


}
