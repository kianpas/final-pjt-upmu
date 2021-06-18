package com.fpjt.upmu.address.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpjt.upmu.address.model.service.AddressService;
import com.fpjt.upmu.address.model.vo.Address;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/address")
public class AddressController {
	
	@Autowired
	private AddressService addressService;

	@PostMapping("/save")
	@ResponseBody
	public Map<String, Object> insertAddr(@RequestBody Address address){
		
		log.debug("Address {}", address.getByEmp(), address.getSavedEmp());
				
		int result = addressService.insertAddr(address);
		
		Map<String, Object> map = new HashMap<>();
		
		return map;
	}
	
	@GetMapping("/addressDuplicate")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam int byEmp, @RequestParam int savedEmp) {
		//1. 업무로직
		Address address = new Address(0, byEmp, savedEmp);
		Address addr = addressService.selectOneAddr(address);
		boolean available = addr == null;
		log.debug("byEmp {}, savedEmp {}", byEmp, savedEmp);
		//2. Map에 속성 저장
		Map<String, Object> map = new HashMap<>();
		map.put("available", available);
		map.put("addr", addr);		
		
		return map;
	}
	
	@GetMapping("/addrList/{byEmp}")
	@ResponseBody
	public List<Address> selectAddrList(@PathVariable int byEmp){
		 List<Address> list = addressService.selectAddrList(1);
		log.debug("list {}", list);
		return list;
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> deleteAddr(@RequestBody  Address address){
		log.debug("address {}", address);
		int result = addressService.deleteAddr(address);
		
		Map<String, Object> map = new HashMap<>();
		return map;
	}
}
