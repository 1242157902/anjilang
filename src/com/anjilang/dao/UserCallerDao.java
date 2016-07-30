package com.anjilang.dao;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.entity.UserCaller;

/**
 * 访客Dao接口
 * @author Administrator
 *
 */
public interface UserCallerDao extends GenericDao<UserCaller, Long> {
	
	public List<UserCaller> query(Map<String,String> maps);
	
	public Long queryCount(Map<String,String> maps);
}
