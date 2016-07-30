package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.UserCallerDao;
import com.anjilang.dao.UserDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.UserCaller;
import com.anjilang.service.UserCallerService;
import com.anjilang.util.AjlException;

@Service
public class UserCallerServiceImpl implements UserCallerService {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private UserCallerDao userCallerDao;
	@Autowired
	private UserDao userDao;

	@Override
	@Transactional
	public void save(UserCaller userCaller) throws AjlException {
		log.info("保存访问对象:" + userCaller.toString());
		try {
			userCallerDao.save(userCaller);
		} catch (Exception e) {
			log.error("UserCaller=保存失败", e);
			throw AjlException.createErr("5008");
		}
	}

	@Override
	public void delet(Long id) throws AjlException {
		log.info("删除访问对象:id=" + id);
		try {
			UserCaller userCaller = userCallerDao.get(id);
			if(userCaller != null){
				userCallerDao.delete(userCaller);
			}else{
				log.error("要删除的对象不存在 id="+id);
				throw AjlException.createErr("5008");
			}
		} catch (AjlException e) {
			throw e;
		} catch (Exception e) {
			log.error("UserCaller 删除实体失败 id=" + id, e);
			throw AjlException.createErr("5008");
		}
	}

	@Override
	@Transactional
	public void update(UserCaller userCaller) throws AjlException {
		log.info("修改访问对象:" + userCaller);
		try {
			UserCaller modefyUserCaller = userCallerDao.get(userCaller.getId());
			if(modefyUserCaller != null){
				userCallerDao.update(userCaller);
			}else{
				log.error("要修改的对象不存在 id="+userCaller.getId());
				throw AjlException.createErr("5008");
			}
		} catch (AjlException e) {
			throw e;
		} catch (Exception e) {
			log.error("UserCaller 修改实体失败 id=" + userCaller.getId(), e);
			throw AjlException.createErr("5008");
		}
	}

	@Override
	public List<UserCaller> query(Map<String, String> maps) {
		String userId = maps.get("userId");
		String pageSize = maps.get("pageSize");
		String pageNo = maps.get("pageNo");
		Map<String,Object> params = new HashMap<String,Object>();
		if(userId != null && !"".equals(userId)){
			params.put("userId", userId);
		}
		maps.put("pageSize", pageSize);
		maps.put("pageNo", pageNo);
		return userCallerDao.query(maps);
	}

	@Override
	public Long queryCount(Map<String, String> maps) {
		String userId = maps.get("userId");
		Map<String,Object> params = new HashMap<String,Object>();
		if(userId != null && !"".equals(userId)){
			params.put("userId", userId);
		}
		return userCallerDao.queryCount(maps);
	}
}
