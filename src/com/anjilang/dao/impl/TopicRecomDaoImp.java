package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.TopicRecomDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.TopicRecom;

/**
 * @author  JYM
 * 2015-8-12 下午6:58:26
 */
@SuppressWarnings("unchecked")
@Repository
public class TopicRecomDaoImp  extends GenericHibernateDao<TopicRecom, Long> implements TopicRecomDao{

}
