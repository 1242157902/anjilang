package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Information;

/**   
 * @Title: InforService.java 
 * @Package com.anjilang.service 
 * @Description: 资讯服务 
 * @author linqingsong
 * @date 2015-1-1 下午1:37:15 
 * @version V1.0   
 */
public interface InforService {
	/**
	 * 保存资讯分组
	 * @param informationType
	 */
	public void save(Information information);
	
	/**
	 * 查询列表
	 * @return
	 */
	public List<Information> query(int typeId);
	
	/**
	 * 删除对象
	 * @param informationType
	 */
	public void delete(Information information); 
	
	/**
	 * 通过id查询对象
	 * @param id
	 * @return
	 */
	public Information findById(Long id);
	
	/**
	 * 查询本月热点
	 * @return
	 */
	public List<Information> queryHot();
	
	/**
	 * 查询前一条数据
	 * @return
	 */
	public List<Information> queryPrev(Long id);
	
	/**
	 * 查询下一条数据
	 * @return
	 */
	public List<Information> queryNext(Long id);
	
	/**
	 * 分页查询
	 * @param params
	 * @param order
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<Information> queryPage(Map<String, Object> params, String[] order, int pageSize, int pageNo);

	/**
	 * @param id
	 * @return
	 */
	public Long findBytypeId(Long id);
}
