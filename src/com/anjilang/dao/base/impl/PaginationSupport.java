package com.anjilang.dao.base.impl;

import java.util.List;

public class PaginationSupport<T> {
	private int pageSize;
	private long totalCount;
	private List<T> items;

	public PaginationSupport(int pageSize) {
		this.setPageSize(pageSize);
	}

	/**
	 * <strong>最经常使用的构造函数</strong>
	 * 
	 * @param items
	 *            查询结果集合
	 * @param totalCount
	 *            总记录数
	 * @param pageSize
	 *            每页显示条数
	 */
	public PaginationSupport(List<T> items, long totalCount, int pageSize) {
		this.setPageSize(pageSize);
		this.setTotalCount(totalCount);
		this.setItems(items);
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	public long getTotalCount() {
		return totalCount;
	}
	
	/**
	 * 获取总页数
	 * @return
	 */
	public long getPageCount() {
		long count = totalCount / pageSize;
		if (totalCount % pageSize > 0)
			count++;
		return count;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public List<T> getItems() {
		return items;
	}

	public void setItems(List<T> items) {
		this.items = items;
	}
}
