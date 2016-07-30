package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.UserDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.User;
@Repository
public class UserDaoImpl extends GenericHibernateDao<User, Long> implements
		UserDao {

}
