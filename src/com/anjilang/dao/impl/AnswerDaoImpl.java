package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.AnswerDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Answer;

/**   
 * @Title: AnswerDaoImpl.java 
 * @Package com.anjilang.dao.impl 
 * @Description: 问答dao实现
 * @author liudebing
 * @date 2015-1-6 下午21:44:10 
 * @version V1.0   
 */
@Repository
public class AnswerDaoImpl extends GenericHibernateDao<Answer, Long> implements AnswerDao{

}
