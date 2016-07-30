package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.SpecColDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.SpecCol;
/**
 * 专栏首页展示数据
 * @author xym
 *
 */
@SuppressWarnings("unchecked")
@Repository
public class SpecColDaoImpl extends GenericHibernateDao<SpecCol, Long>
		implements SpecColDao {

}
