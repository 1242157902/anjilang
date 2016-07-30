package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.QuestionDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Question;

/**   
 * @Title: QuestionDaoImpl.java 
 * @Package com.anjilang.dao.impl 
 * @Description: 问题dao实现
 * @author linqingsong
 * @date 2015-1-1 下午10:35:31 
 * @version V1.0   
 */
@Repository
public class QuestionDaoImpl extends GenericHibernateDao<Question, Long> implements QuestionDao{

}
