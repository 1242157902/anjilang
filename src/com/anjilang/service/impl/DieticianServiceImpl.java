package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.DieticianDao;
import com.anjilang.dao.InforDao;
import com.anjilang.dao.SpecColDao;
import com.anjilang.entity.Information;
import com.anjilang.entity.SpecCol;
import com.anjilang.service.DieticianService;
import com.anjilang.util.AjlException;

@Service
public class DieticianServiceImpl implements DieticianService {
	
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private DieticianDao dietDao;
	private SpecColDao   specDao;
	
	
	@Override
	@Transactional
	public Information findById(Long id) {
		Information  information=null;
		try {
			information=dietDao.get(id);
			if (information == null) {
				log.error("获取图片信息失败，文章id=" + id);
			}
			
		} catch (Exception e) {
			System.out.println("查询信息失败！");
		}
		return information;
	}


	@Override
	@Transactional
	public Information queryPrev(Long id) {
		Information contentPrev=null;
		try {
			contentPrev=dietDao.get(id-1);
			if (contentPrev == null) {
				log.error("获取文章信息失败，文章id=" + id);
			}
			
		} catch (Exception e) {
			System.out.println("查询信息失败！");
		}
		return contentPrev;
	}


	@Override
	@Transactional
	public Information queryNext(Long id) {
		Information contentPrev=null;
		try {
			contentPrev=dietDao.get(id+1);
			if (contentPrev == null) {
				log.error("获取文章信息失败，文章id=" + id);
			}
			
		} catch (Exception e) {
			System.out.println("查询信息失败！");
		}
		return contentPrev;
	}


	@Override
	public List<SpecCol> findAll() {
		List<SpecCol> list=null;
		try{
			String hql ="FROM SpecCol";
			 list=specDao.find(hql);
		}catch(Exception e) {
			log.error("查询专栏信息失败", e);
		}
		return list;
	}


	@Override
	public SpecCol qureyById(long id) {
		SpecCol  information=null;
		try {
			information=specDao.get(id);
			if (information == null) {
				log.error("获取图片信息失败，文章id=" + id);
			}
			
		} catch (Exception e) {
			System.out.println("查询信息失败！");
		}
		return information;
	}


	
}
