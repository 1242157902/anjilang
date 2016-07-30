package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.AuthorDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Author;
import com.anjilang.entity.SpecCol;
import com.anjilang.service.AuthorService;
@Service
public class AuthorServiceImpl implements AuthorService {
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private AuthorDao Dao;
	@Override
	@Transactional
	public List<Author> query() {
		String hql="from Author";
		return Dao.find(hql);
	}
	@Override
	public void save(Author author) {
		Dao.save(author);
		
	}
	@Override
	public Author findById(Long id) {
		return Dao.get(id);
	}
	@Override
	public void delete(Author author) {
		Dao.delete(author);
	}
	@Override
	public PaginationSupport<Author> queryAll(boolean display, Integer pageSize,
			Integer pageNo) {
		Map<String, Object> paramsNotEqs = null;
		if (display) {
			paramsNotEqs = new HashMap<String, Object>();
			paramsNotEqs.put("sort", 0);
		}
		return Dao.queryPage(null, paramsNotEqs, null,
				new String[] { "sort" }, pageSize, pageNo, true);
	}
	@Override
	public PaginationSupport<Author> queryPage(Map<String, Object> params,
			String[] order, int pageSize, int pageNo) {
		return	Dao.queryPage(params, order, pageSize, pageNo);
	}
	@Override
	public List<Author> queryOtherAuthor(Long long1) {
		String hql = "FROM Author a WHERE a.id!="+long1+"";
		return Dao.find(hql);
	}

}
