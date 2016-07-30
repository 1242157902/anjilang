package com.anjilang.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.PatientGroup;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-26 下午8:36:47
 */
public interface GroupTopicService {
	

	/**
	 * 用户发表文章
	 * @param groupTopic
	 * @throws AjlException
	 */
	
	public void publish(GroupTopic groupTopic) throws AjlException;
	
	
	/**
	 * 话题列表
	 * @param groupTopic
	 * @throws AjlException
	 */
	public List<GroupTopic> tolist(Long groupid) throws AjlException;
	
	/**
	 * 根据id获取文章内容
	 * @param groupTopic
	 * @throws AjlException
	 */
	public GroupTopic getById(Long id) throws AjlException;
	
	/**
	 * 根据tab文章分类
	 * 
	 * @throws AjlException
	 */
	public PaginationSupport<GroupTopic> queryPage(PatientGroup patientGroup, Long tabid,Integer cancel,
			 int pageSize, int pageNo) throws AjlException;
	
	
	/**
	 * 熱門話題
	 * 根據回復量
	 * @throws AjlException
	 **/
	public PaginationSupport<GroupTopic> queryRepPage(PatientGroup patientGroup,Long tabid,Integer cancel,
			 int pageSize, int pageNo) throws AjlException;
	
	
	
	
	/**
	 * 推荐首页图文的文章
	 * 
	 * @throws AjlException
	 **/
	public List<GroupTopic>   RecomTopic(Integer recommmend) throws AjlException;
	
	

	/**
	 * 最新发布新闻
	 * @throws AjlException
	 **/
	 
	public List<GroupTopic>   queryByNew() throws AjlException;


	
	
	
}
