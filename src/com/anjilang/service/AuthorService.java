package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Author;
import com.anjilang.entity.SpecCol;


/**
 * 作者服务；
 * @author Jane
 *
 */
public interface AuthorService {

	public List<Author> query();
	
	public void save(Author author);

	public Author findById(Long id);

	public void delete(Author author);

	public PaginationSupport<Author> queryAll(boolean display, Integer pageSize,
			Integer pageNo);

	public PaginationSupport<Author> queryPage(Map<String, Object> params,
			String[] order, int pageSize, int pageNo);

	public List<Author> queryOtherAuthor(Long long1);
	
}
