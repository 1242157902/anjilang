package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.GroupMessageDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.GroupMessage;

/**
 * @author  JYM
 * 2015-7-27 下午5:20:16
 */
@SuppressWarnings("unchecked")
@Repository
public class GroupMessageDaoImpl extends GenericHibernateDao<GroupMessage, Long> implements GroupMessageDao{

}
