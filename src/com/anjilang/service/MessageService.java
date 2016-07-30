/**  
 * @Title: MessageService.java
 * @Package com.anjilang.service
 * @Description: TODO
 * @author linqingsong
 * @date 2015年1月8日
 */
package com.anjilang.service;

import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Message;

/**
 * ClassName: MessageService 
 * @Description: 站内消息
 * @author linqingsong
 * @date 2015年1月8日
 */
public interface MessageService {
	
	/**
	 * 保存消息
	 * @param message
	 */
	public void save(Message message);
	
	/**
	 * 删除消息
	 * @param message
	 */
	public void delete(Message message);
	
	/**
	 * 修改短消息
	 * @param message
	 */
	public void modify(Message message);
	
	/**
	 * 分页查询当前用户短消息
	 * @param toUserId
	 * @return
	 */
	public PaginationSupport<Message> findByUserId(Map<String, Object> params, String[] order, int pageSize, int pageNo);
}
