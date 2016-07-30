package com.anjilang.dao.impl;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.PatientGroupDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.PatientGroup;

/**
 * @author  JYM
 * 2015-7-8 下午6:56:12
 */
@SuppressWarnings("unchecked")
@Repository
public class PatientGroupDaoImpl extends GenericHibernateDao<PatientGroup, Long> implements PatientGroupDao{
	//jym
			public void myupdate(GroupUser entity) {
				Session session = getSession();
				session.beginTransaction();

				session.update(entity);
				session.getTransaction().commit();
				
			}
	

}
