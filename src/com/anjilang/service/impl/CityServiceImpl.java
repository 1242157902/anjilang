package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.CityDao;
import com.anjilang.entity.City;
import com.anjilang.service.CityService;
import com.anjilang.util.AjlException;

@Service
public class CityServiceImpl implements CityService {
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private CityDao cityDao;

	@Override
	public List<City> queryCityByParentId(Long parentId) throws AjlException {
		try{
			String hql = "FROM City WHERE cityParent = " + parentId;
			return cityDao.find(hql);
		}catch(Exception e) {
			log.error("查询城市失败", e);
			throw AjlException.createErr("5003");
		}
	}

	@Override
	public City queryById(Long id) {
		return cityDao.load(id);
	}
	
}
