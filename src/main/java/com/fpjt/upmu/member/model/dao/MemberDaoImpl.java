package com.fpjt.upmu.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(int emp_no) {
		return session.selectOne("member.selectOneMember", emp_no);
	}

	@Override
	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember", member);
	}

}
