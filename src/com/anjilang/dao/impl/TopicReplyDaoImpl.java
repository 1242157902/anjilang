package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.TopicReplyDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.TopicReply;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-30 上午11:44:31
 */
@SuppressWarnings("unchecked")
@Repository
public class TopicReplyDaoImpl  extends GenericHibernateDao<TopicReply, Long> implements TopicReplyDao{

	

}
