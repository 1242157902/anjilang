package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.RegistCodeDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.RegistCode;
@Repository
public class RegistCodeDaoImpl extends GenericHibernateDao<RegistCode, Long>
		implements RegistCodeDao {
}
