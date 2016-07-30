package com.anjilang.dao.impl;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.BookDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Book;

@Repository
public class BookDaoImpl extends GenericHibernateDao<Book, Long> implements BookDao {
	
}
