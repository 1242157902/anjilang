package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.InformationType;

/**   
 * @Title: ServiceInformationType.java 
 * @Package com.anjilang.service 
 * @Description: 咨询分组manger
 * @author linqingsong
 * @date 2014-12-28 下午10:48:57 
 * @version V1.0   
 */
public interface InforTypeService {
	
	/**
	 * 保存资讯分组
	 * @param informationType
	 */
	public void save(InformationType informationType);
	
	/**
	 * 查询列表
	 * @return
	 */
	public List<InformationType> query();
	
	/**
	 * 删除对象
	 * @param informationType
	 */
	public void delete(InformationType informationType); 
	
	/**
	 * 通过id查询对象
	 * @param id
	 * @return
	 */
	public InformationType findById(Long id);
	
	/**
	 * 首页查询资讯分组
	 * @return
	 */
	public List<InformationType> queryIndex();
}
