package com.anjilang.dao.impl;

import org.springframework.stereotype.Repository;

import com.anjilang.dao.PictureDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Picture;

/**   
 * @Title: PictureDaoImpl.java 
 * @Package com.anjilang.dao.impl 
 * @Description: dao实现
 * @author linqingsong
 * @date 2015-1-3 下午4:13:33 
 * @version V1.0   
 */
@Repository
public class PictureDaoImpl extends GenericHibernateDao<Picture, Long> implements PictureDao{

}
