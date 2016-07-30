package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SpecCol;

/**
 * 专栏首页展示
 * @author xym
 *
 */
public interface SpecColService {
	/**
	 * 保存专栏首页展示
	 * @param specCol
	 * @param logFlag
	 */
	public void save(SpecCol specCol, String logFlag);
	
	/**
	 * 查询专栏首页展示
	 * @param id 如果id为null返回null
	 * @param logFlag
	 */
	public SpecCol queryById(Long id, String logFlag);
	
	/**
	 * 分页查询所有的数据
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<SpecCol> queryAll(boolean display, int pageSize, int pageNo);
	
	/**
	 * 修改专栏首页展示
	 * @param specCol
	 * @param logFlag
	 */
	public void update(SpecCol specCol, String logFlag);

	public void delete(SpecCol specCol, String logFlag);
	public PaginationSupport<SpecCol> queryPage(Map<String, Object> params,
			String[] order, int i, int pageNo);
	public List<SpecCol> query();
}
