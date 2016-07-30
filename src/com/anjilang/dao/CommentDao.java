package com.anjilang.dao;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Comment;

public interface CommentDao extends GenericDao<Comment,Long> {

	PaginationSupport<Comment> queryCommentByInforId(long id, Integer pageSize,
			Integer pageNo);


}
