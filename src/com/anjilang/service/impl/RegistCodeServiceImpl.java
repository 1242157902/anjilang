package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.RegistCodeDao;
import com.anjilang.entity.RegistCode;
import com.anjilang.service.RegistCodeService;
import com.anjilang.util.AjlException;
@Service
public class RegistCodeServiceImpl implements RegistCodeService {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private RegistCodeDao registCodeDao;

	@Override
	@Transactional
	public void save(RegistCode registCode) throws AjlException {
		try {
			log.info("添加注册码:" + registCode.toString());
			registCodeDao.save(registCode);
			log.info("添加注册码成功:" + registCode.toString());
		} catch (Exception e) {
			log.error("添加失败:" + registCode.getEmail(), e);
			throw AjlException.createErr("5012");
		}
	}

	@Override
	public RegistCode queryRegistCode(String email, String uuid)
			throws AjlException {
		log.info("查询验证码:email="+email+";uuid="+uuid+";"); 
		String hql = "FROM RegistCode WHERE email='"+email+"' and uuid='"+uuid+"' order by createTime desc";
		List<RegistCode> list;
		try{
			list = registCodeDao.find(hql);
		} catch(Exception e) {
			log.error("查询验证码失败:email="+email+";uuid="+uuid+";", e);
			throw AjlException.createErr("5013");
		}
		if(list == null || list.size() < 1 || list.get(0) ==null) {
			log.error("查询验证码不存在:email="+email+";uuid="+uuid+";");
			throw AjlException.createErr("5014");
		}
		
		return list.get(0);
	}
}
