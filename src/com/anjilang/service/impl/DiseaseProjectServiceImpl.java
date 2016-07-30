package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.DiseaseProjectDao;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.util.AjlException;

@Service
public class DiseaseProjectServiceImpl implements DiseaseProjectService {
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private DiseaseProjectDao diseaseProjectDao;
	@Override
	public List<DiseaseProject> queryAll() throws AjlException {
		try{
			String hql = "FROM DiseaseProject";
			return diseaseProjectDao.find(hql);
		}catch(Exception e) {
			log.error("查询城市失败", e);
			throw AjlException.createErr("5005");
		}
		
	}
	
	@Override
	@Transactional
	public void save(DiseaseProject diseaseProject) {
		diseaseProjectDao.saveOrUpdate(diseaseProject);
	}

	@Override
	public DiseaseProject findById(Long id) {
		return diseaseProjectDao.get(id);
	}

	@Override
	@Transactional
	public void delete(DiseaseProject diseaseProject) {
		diseaseProjectDao.delete(diseaseProject);
	}

	@Override
	public List<DiseaseProject> queryById(String[] ids) {
		List<DiseaseProject> projects = new ArrayList<DiseaseProject>();
		if(ids == null || ids.length == 0){
			return null;
		}
		for(int i=0;i<ids.length;i++){
			if(ids[i] != null && !"".equals(ids[i])){
				DiseaseProject project = diseaseProjectDao.get(Long.parseLong(ids[i]));
				projects.add(project);
			}
		}
		return projects;
	}
	
}
