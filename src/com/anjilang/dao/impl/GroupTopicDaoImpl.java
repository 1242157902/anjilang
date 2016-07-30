package com.anjilang.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.GroupTopicDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.GroupTopic;


/**
 * @author  JYM
 * 2015-7-26 下午8:26:33
 */
@SuppressWarnings("unchecked")
@Repository
public class GroupTopicDaoImpl extends GenericHibernateDao<GroupTopic, Long> implements GroupTopicDao{
	// jym
	@Override
	public void mysaveOrUpdate(GroupTopic entity) {
		Session session = getSession();
		session.beginTransaction();

		session.saveOrUpdate(entity);
		session.getTransaction().commit();
	}

	
		
}
