/**  
 * @Title: MessageDaoImpl.java
 * @Package com.anjilang.dao.impl
 * @Description: TODO
 * @author linqingsong
 * @date 2015年1月8日
 */
package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.MessageDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Message;

/**
 * ClassName: MessageDaoImpl 
 * @Description: TODO
 * @author linqingsong
 * @date 2015年1月8日
 */
@Repository
public class MessageDaoImpl extends GenericHibernateDao<Message, Long> implements MessageDao{

}