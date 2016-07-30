package com.anjilang.service.impl;

import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.PictureDao;
import com.anjilang.entity.Picture;
import com.anjilang.service.PictureService;

/**   
 * @Title: PictureServiceImpl.java 
 * @Package com.anjilang.service.impl 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author linqingsong
 * @date 2015-1-3 下午4:15:02 
 * @version V1.0   
 */
@Service
public class PictureServiceImpl implements PictureService{
	@Autowired
	private PictureDao pictureDao;

	@Override
	public List<Picture> query(int type) {
		String hql = "FROM Picture WHERE type="+type+" ORDER BY sortNum ASC ";
		return pictureDao.find(hql);
	}


	@Override
	@Transactional
	public void save(Picture pic) {
		pictureDao.save(pic);
	}

	@Override
	@Transactional
	public void update(Picture pic) {
		pictureDao.update(pic);
		
	}

	@Override
	@Transactional
	public void delete(Picture pic) {
		pictureDao.delete(pic);
	}

	@Override
	public Picture findById(Long id) {
		return pictureDao.load(id);
	}


	@Override
	public List<Picture> newQuery(int type) {
		String hql = "FROM Picture WHERE type="+type+" ORDER BY sortNum ASC";
		return pictureDao .find(hql);
	}
	
	
}
