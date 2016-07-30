package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.DoctorTypeDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.DoctorType;

@Repository
public class DoctorTypeDaoImpl extends GenericHibernateDao<DoctorType, Long>
		implements DoctorTypeDao {

}
