package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.City;
import com.anjilang.util.AjlException;

public interface CityService {
	/**
	 * 根据父id查询子城市列表
	 * @param parentId
	 * @return
	 */
	public List<City> queryCityByParentId(Long parentId) throws AjlException;
	
	/**
	 * 查询城市 省份信息
	 * @param id
	 */
	public City queryById(Long id);
}
