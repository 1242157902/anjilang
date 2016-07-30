package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.DiseaseProject;
import com.anjilang.util.AjlException;

public interface DiseaseProjectService {
	public List<DiseaseProject> queryAll() throws AjlException;
	
	/**
	 * 保存疾病
	 * @param diseaseProject
	 */
	public void save(DiseaseProject diseaseProject);
	
	/**
	 * 通过id查询
	 * @param id
	 * @return
	 */
	public DiseaseProject findById(Long id);
	
	/**
	 * 删除对象
	 * @param diseaseProject
	 * @return
	 */
	public void delete(DiseaseProject diseaseProject);
	
	/**
	 * 通过id数组查询记录数
	 * @param ids
	 * @return
	 */
	public List<DiseaseProject> queryById(String[] ids);
}
