package com.fpjt.upmu.address.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.address.model.vo.Address;

@Repository
public class AddressDaoImpl implements AddressDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertAddr(Address address) {
		
		return session.insert("address.insertAddr", address);
	}

	@Override
	public List<Address> selectAddrList(int byEmp) {
		
		return session.selectList("address.selectAddrList", byEmp);
	}

	@Override
	public int deleteAddr(Address address) {
		
		return session.delete("address.deleteAddr", address);
	}

	@Override
	public Address selectOneAddr(Address address) {
		
		return session.selectOne("address.selectOneAddr", address);
	}
	
	
}
