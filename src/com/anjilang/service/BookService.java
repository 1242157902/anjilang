package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.Book;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.Information;

/**
 * 推荐书籍服务
 * @author Jane
 *
 */
public interface BookService {
	/**
	 * 查询书籍信息
	 * @return
	 */
	public List<Book> query();

	public void save(Book book);

	public Book findById(Long id);

	public void delete(Book book);
}
