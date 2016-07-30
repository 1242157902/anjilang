package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.DoctorTypeDao;
import com.anjilang.entity.DoctorType;
import com.anjilang.service.DoctorTypeService;
@Service
public class DoctorTypeServiceImpl implements DoctorTypeService {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private DoctorTypeDao doctorTypeDao;

	@Override
	@Transactional
	public void save(DoctorType doctorType) {
		doctorTypeDao.save(doctorType);
		
	}

	@Override
	public List<DoctorType> queryAll() {
		String hql = "FROM DoctorType";
		return doctorTypeDao.find(hql);
	}

	@Override
	public DoctorType queryById(Long id) {
		return doctorTypeDao.load(id);
	}
	
}
