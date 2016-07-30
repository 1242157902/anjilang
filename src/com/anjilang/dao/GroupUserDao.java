package com.anjilang.dao;

import java.util.Map;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupUser;


/**
 * @author  JYM
 * 2015-7-20 下午2:20:38
 */
public interface GroupUserDao extends GenericDao<GroupUser, GroupIdAndUserid>{

	/**
	 * @param id
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	PaginationSupport<Long> myqueryPage(GroupIdAndUserid id, int pageSize,
			int pageNo);

	

}
