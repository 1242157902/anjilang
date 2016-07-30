package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.CityDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.City;

@Repository
public class CityDaoImpl extends GenericHibernateDao<City, Long> implements CityDao{

}
