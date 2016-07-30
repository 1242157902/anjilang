package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.Information;
import com.anjilang.entity.SpecCol;
import com.anjilang.util.AjlException;


/**
 * @Title: DieticianService.java 
 * @Package com.anjilang.service 
 * @Description: 营养师专栏服务；
 * @author linqingsong
 * @date 2015-1-1 下午1:37:15 
 * @version V1.0 
 *
 */
public interface DieticianService {
	
	/**
	 * 通过id查询对象
	 * @param id
	 * @return
	 */
	public Information findById(Long id);
	
	/**
	 * 查询前一条数据
	 * @return
	 */
	public Information queryPrev(Long id);
	
	/**
	 * 查询下一条数据
	 * @return
	 */
	public Information queryNext(Long id);
	/**
	 * 查询所有专栏信息；
	 * @return
	 * @throws AjlException 
	 */
	public List<SpecCol> findAll() throws AjlException;
	/**
	 * 通过id查询对象
	 * @param id
	 * @return
	 * @throws AjlException 
	 */
	public SpecCol qureyById(long id) throws AjlException;
}
