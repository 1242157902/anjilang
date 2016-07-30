package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.DoctorType;

public interface DoctorTypeService {
	
	public void save(DoctorType doctorType);
	
	public List<DoctorType> queryAll();
	
	public DoctorType queryById(Long id);
	
}
