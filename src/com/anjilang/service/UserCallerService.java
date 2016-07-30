package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.User;
import com.anjilang.entity.UserCaller;
import com.anjilang.util.AjlException;

/**
 * 访客
 * @author xym
 *
 */
public interface UserCallerService {

	/**
	 * 保存访客记录
	 * @param userCaller
	 * @throws AjlException
	 */
	public void save(UserCaller userCaller) throws AjlException;

	/**
	 * 删除访客
	 * @param id
	 * @throws AjlException
	 */
	public void delet(Long id) throws AjlException;
	
	/**
	 * 修改访客
	 * @param userCaller
	 * @throws AjlException
	 */
	public void update(UserCaller user)throws AjlException;
	
	/**
	 * 根据条件分页查询访客
	 * @param maps 查询条件
	 * @return 
	 */
//	public PaginationSupport<UserCaller> query(Map<String,String> maps);
	/**
	 * 根据条件分页查询访客
	 * @param maps 查询条件
	 * @return 
	 */
	public List<UserCaller> query(Map<String,String> maps);
	/**
	 * 根据条件统计访客
	 * @param maps 查询条件
	 * @return 
	 */
	public Long queryCount(Map<String,String> maps);

}
