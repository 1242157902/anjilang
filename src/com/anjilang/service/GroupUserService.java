package com.anjilang.service;

import java.util.List;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.User;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-20 下午2:26:35
 */
public interface GroupUserService {
	

	/**
	 * 加入小组
	 * @param groupTab
	 * @throws AjlException
	 */
	
	public void JoinGroup(GroupUser groupUser) throws AjlException;
	
	
	/**
	 * 退出小组
	 * @param groupTab
	 * @throws AjlException
	 */
	
	public void QuitGroup(GroupUser  groupUser) throws AjlException;
	
	/**
	 * 根据id
	 * @param groupIdAndUserid
	 * @throws AjlException
	 */
	public GroupUser getById(GroupIdAndUserid groupIdAndUserid) throws AjlException;
	
	/**
	 * 获取成员列表
	 * @param groupid
	 * @param ismember
	 * @throws AjlException
	 */
	public List<GroupUser> memberList(GroupIdAndUserid groupIdAndUserid) throws AjlException;
	
	
	/**
	 * 获取小组列表
	 * @param groupid
	 * @param ismember
	 * @throws AjlException
	 */
	public List<GroupUser> groupList(GroupIdAndUserid groupIdAndUserid) throws AjlException;
	
	
	
	/**
	 * 成员列表分页
	 * @param groupid
	 * @param ismember
	 * @throws AjlException
	 */
	public PaginationSupport<Long> queryByUserMem(GroupIdAndUserid id,int pageSize, int pageNo) throws AjlException;
	
	/**
	 * 获取委员组成员
	 * @param groupid
	 * @param ismember
	 * @throws AjlException
	 */
	public List<GroupUser> listByUser(GroupIdAndUserid id) throws AjlException;
	
	
	
}
