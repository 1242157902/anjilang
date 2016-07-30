package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.GroupTab;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-13 下午8:15:11
 */
public interface GroupTabService {
	
	/**
	 * 管理者添加分类
	 * @param groupTab
	 * @throws AjlException
	 */
	
	public void UaddGroupTab(GroupTab groupTab) throws AjlException;
	
	/**
	 * 管理者给分类排序
	 * @param groupTab
	 * @throws AjlException
	 */
	public List<GroupTab>  SortTab(Long groupid) throws AjlException;
	
	
	/**
	 * 管理者分类编辑
	 * @param groupTab
	 * @throws AjlException
	 */
	public void edit(GroupTab  groupTab) throws AjlException;
	
	
	/**
	 * 管理者查找分类
	 * @param groupTab
	 * @throws AjlException
	 */

	public GroupTab  getById(Long id) throws AjlException;
}
