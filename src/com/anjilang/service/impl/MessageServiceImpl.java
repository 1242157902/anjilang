/**  
 * @Title: MessageServiceImpl.java
 * @Package com.anjilang.service.impl
 * @Description: TODO
 * @author linqingsong
 * @date 2015年1月8日
 */
package com.anjilang.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.MessageDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Message;
import com.anjilang.service.MessageService;

/**
 * ClassName: MessageServiceImpl 
 * @Description: TODO
 * @author linqingsong
 * @date 2015年1月8日
 */
@Service
public class MessageServiceImpl implements MessageService{

	@Autowired
	private MessageDao messageDao;
	
	@Override
	public void save(Message message) {
		messageDao.save(message);
	}

	@Override
	public void delete(Message message) {
		messageDao.delete(message);
	}

	@Override
	public void modify(Message message) {
		messageDao.update(message);
	}


	@Override
	public PaginationSupport<Message> findByUserId(
			Map<String, Object> params, String[] order, int pageSize, int pageNo) {
		return messageDao.queryPage(params, order, pageSize, pageNo);
	}

}
