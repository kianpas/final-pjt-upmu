package com.fpjt.upmu.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.security.model.dao.SecurityDao;

import lombok.extern.slf4j.Slf4j;

@Service("securityService")
@Slf4j
public class SecurityServiceImpl implements SecurityService {


	@Autowired
	private SecurityDao securityDao;

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		UserDetails employee = securityDao.loadUserByUsername(id);
		log.debug("employee = {}", employee);
		if(employee == null)
			throw new UsernameNotFoundException(id);
		return employee;
	}

}
