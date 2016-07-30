/**  
 * @Title: FriendLinkServiceImpl.java
 * @Package com.anjilang.service.impl
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
package com.anjilang.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.FriendLinkDao;
import com.anjilang.entity.FriendLink;
import com.anjilang.service.FriendLinkService;

/**
 * ClassName: FriendLinkServiceImpl 
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */

@Service
public class FriendLinkServiceImpl implements FriendLinkService{

	@Autowired
	private FriendLinkDao friendLinkDao;
	
	@Override
	@Transactional
	public void save(FriendLink friendLink) {
		friendLinkDao.save(friendLink);
	}

	@Override
	public List<FriendLink> query() {
		return friendLinkDao.loadAll();
	}

	@Override
	@Transactional
	public void modify(FriendLink friendLink) {
		friendLinkDao.update(friendLink);
	}

	@Override
	@Transactional
	public void delete(FriendLink friendLink) {
		friendLinkDao.delete(friendLink);
	}

	@Override
	public FriendLink findById(Long id) {
		return friendLinkDao.get(id);
	}

}