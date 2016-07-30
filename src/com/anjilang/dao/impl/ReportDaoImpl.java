package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.ReportDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Report;

@SuppressWarnings("unchecked")
@Repository
public class ReportDaoImpl extends GenericHibernateDao<Report, Long> implements ReportDao{

}
