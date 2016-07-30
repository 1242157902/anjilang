package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.DaoDemo;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.EntityDemo;


@Repository
public class DaoDemoImpl extends GenericHibernateDao<EntityDemo, Long> implements DaoDemo {

}
