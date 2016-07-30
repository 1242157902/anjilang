package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.InforTypeDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.InformationType;

/**   
 * @Title: DaoInformationTypeImpl.java 
 * @Package com.anjilang.dao.impl 
 * @Description: 咨询分组dao实现
 * @author linqingsong
 * @date 2014-12-28 下午10:45:36 
 * @version V1.0   
 */
@Repository
public class InforTypeDaoImpl extends GenericHibernateDao<InformationType, Long> implements InforTypeDao{

}
