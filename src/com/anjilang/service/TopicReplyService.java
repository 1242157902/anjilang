package com.anjilang.service;

import java.util.List;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-30 上午11:47:20
 */
public interface TopicReplyService {
	
	/**
	 * 回复
	 * @param 
	 * @throws AjlException
	 */
	public void addReply(TopicReply topicReply) throws AjlException;

	/**
	 * 计算回复的楼层
	 * @param 
	 * @throws AjlException
	 * 
	 */
	public List<TopicReply> countTP(Long topicid) throws AjlException;
	
	
	/**
	 * 回复分页表
	 * @param groupid
	 * @param ismember
	 * @throws AjlException
	 */
	public PaginationSupport<TopicReply>  queryByTopicid(Long topicid,int pageSize, int pageNo,User user) throws AjlException;
	
	
	/**
	 * 获取回复数量
	 * @param id
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
    public  Integer  count(Long topicid) throws AjlException;
    
  /**
   * 
   * @return:       TopicReply 
   * @param topicid
   * @return
   * @throws AjlException
   * <p>Description: 根据topicid来获取该TopicReply <p>
   * @date:          2015年8月19日下午2:55:44
   * @author         ysl
   */
    public   TopicReply getTopicReply(Long topicid) throws AjlException;
    
    /**
     * 
     * @return:       void 
     * @param repid
     * @throws AjlException
     * <p>Description: 根据主键删除TopicReply<p>
     * @date:          2015年8月20日下午2:07:09
     * @author         ysl
     */
    public void deleteTopicReply(Long repid) throws AjlException;
    
    
    /**
     * 
     * @return:       void 
     * @param topicReply
     * @throws Exception
     * <p>Description: 更新TopicReply实体信息<p>
     * @date:          2015年8月20日下午3:54:22
     * @author         ysl
     */
    public void updateTopicReply(TopicReply topicReply)throws Exception;
}
