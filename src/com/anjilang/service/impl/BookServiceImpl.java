package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.BookDao;
import com.anjilang.entity.Book;
import com.anjilang.service.BookService;
@Service
public class BookServiceImpl implements BookService {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private BookDao bookdao;
	
	@Override
	@Transactional
	public List<Book> query() {
		String hql="from Book ";
		return bookdao.find(hql);
		 
	}

	@Override
	public void save(Book book) {
		bookdao.saveOrUpdate(book);
		
	}

	@Override
	public Book findById(Long id) {
		return bookdao.get(id);
		
	}

	@Override
	public void delete(Book book) {
		bookdao.delete(book);
		
	}

}
