package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.SeniorDoctorDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.SeniorDoctor;
/**
 * 资深医生Dao
 * @author xym
 *
 */
@Repository
public class SeniorDoctorDaoImpl extends
		GenericHibernateDao<SeniorDoctor, Long> implements SeniorDoctorDao {

}
