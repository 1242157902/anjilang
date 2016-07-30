package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.AnswerCommentDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.AnswerComment;

@Repository
public class AnswerCommentDaoImpl extends GenericHibernateDao<AnswerComment, Long> implements AnswerCommentDao{

}
