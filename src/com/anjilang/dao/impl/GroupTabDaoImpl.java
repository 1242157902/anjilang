package com.anjilang.dao.impl;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.GroupTabDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.GroupTab;
import com.anjilang.entity.GroupUser;


/**
 * @author  JYM
 * 2015-7-12 下午10:26:16
 */
@SuppressWarnings("unchecked")
@Repository
public class GroupTabDaoImpl extends GenericHibernateDao<GroupTab, Long> implements GroupTabDao{
	
	//jym
	public void myupdate(GroupUser entity) {
		Session session = getSession();
		session.beginTransaction();

		session.update(entity);
		session.getTransaction().commit();

	}

}
