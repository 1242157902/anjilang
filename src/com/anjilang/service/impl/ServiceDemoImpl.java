package com.anjilang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.DaoDemo;
import com.anjilang.service.ServiceDemo;

@Service
public class ServiceDemoImpl implements ServiceDemo {
	@Autowired
	private DaoDemo daoDemo;

}
