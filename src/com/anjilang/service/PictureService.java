package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.Picture;

/**   
 * @Title: PictureService.java 
 * @Package com.anjilang.service 
 * @Description: 图片服务
 * @author linqingsong
 * @date 2015-1-3 下午4:14:26 
 * @version V1.0   
 */
public interface PictureService {
	/**
	 * 通过类型查询图片
	 * @param type
	 * @return
	 */
	public List<Picture> query(int type);
	
	/**
	 * 保存
	 * @param pic
	 */
	public void save(Picture pic);
	
	/**
	 * 修改
	 * @param pic
	 */
	public void update(Picture pic);
	
	/**
	 * 删除
	 * @param pic
	 */
	public void delete(Picture pic);

	public Picture findById(Long id);

	List<Picture> newQuery(int type);

}
