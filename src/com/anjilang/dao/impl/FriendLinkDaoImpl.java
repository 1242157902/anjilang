/**  
 * @Title: FriendLinkDaoImpl.java
 * @Package com.anjilang.dao.impl
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.FriendLinkDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.FriendLink;

/**
 * ClassName: FriendLinkDaoImpl 
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
@Repository
public class FriendLinkDaoImpl extends GenericHibernateDao<FriendLink, Long> implements FriendLinkDao{

}
