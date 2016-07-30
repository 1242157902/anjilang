package com.anjilang.dao.impl;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.DieticianDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Information;

@Repository
public class DieticianDaoImpl extends GenericHibernateDao<Information, Long> implements DieticianDao {

}
