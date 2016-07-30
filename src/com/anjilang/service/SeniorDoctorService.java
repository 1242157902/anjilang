package com.anjilang.service;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SeniorDoctor;

/**
 * 资深医生服务
 * @author xym
 *
 */
public interface SeniorDoctorService {
	/**
	 * 保存资深医生
	 * @param sDoc
	 * @param logFlag
	 */
	public void save(SeniorDoctor sDoc, String logFlag);
	
	/**
	 * 查询资深医生
	 * @param id 如果id为null返回null
	 * @param logFlag
	 */
	public SeniorDoctor queryById(Long id, String logFlag);
	
	/**
	 * 分页查询所有的数据
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<SeniorDoctor> queryAll(boolean display, int pageSize, int pageNo);
	
	/**
	 * 修改咨询医生
	 * @param sDoc
	 * @param logFlag
	 */
	public void update(SeniorDoctor sDoc, String logFlag);

	public void delete(SeniorDoctor seniorDoctor, String logFlag);
}
