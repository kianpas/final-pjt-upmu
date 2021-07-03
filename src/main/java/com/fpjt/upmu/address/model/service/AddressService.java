package com.fpjt.upmu.address.model.service;

import java.util.List;

import com.fpjt.upmu.address.model.vo.Address;
import com.fpjt.upmu.address.model.vo.AddressExt;

public interface AddressService {

	int insertAddr(Address address);

	List<AddressExt> selectAddrList(int byEmp);

	int deleteAddr(Address address);

	AddressExt selectOneAddr(AddressExt address);

	
}
