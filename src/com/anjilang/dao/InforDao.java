package com.anjilang.dao;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.entity.Information;

/**   
 * @Title: InforDao.java 
 * @Package com.anjilang.dao 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author linqingsong
 * @date 2015-1-1 下午1:42:54 
 * @version V1.0   
 */
public interface InforDao extends GenericDao<Information, Long>{

	/**
	 * @param id
	 * @return
	 */
	Long findBytypeId(Long id);

}
