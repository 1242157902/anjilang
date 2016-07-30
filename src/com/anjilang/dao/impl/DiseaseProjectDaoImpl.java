package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.DiseaseProjectDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.DiseaseProject;

@Repository
public class DiseaseProjectDaoImpl extends GenericHibernateDao<DiseaseProject, Long> implements
		DiseaseProjectDao {

}
