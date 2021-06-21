package com.fpjt.upmu.address.model.service;

import java.util.List;

import com.fpjt.upmu.address.model.vo.Address;

public interface AddressService {

	int insertAddr(Address address);

	List<Address> selectAddrList(int byEmp);

	int deleteAddr(Address address);

	Address selectOneAddr(Address address);

	
}
