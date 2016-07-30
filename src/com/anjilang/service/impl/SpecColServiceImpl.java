package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.SpecColDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SpecCol;
import com.anjilang.service.SpecColService;

@Service
public class SpecColServiceImpl implements SpecColService {
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private SpecColDao specColDao;
	
	@Override
	@Transactional
	public void save(SpecCol specCol, String logFlag) {
		try {
			specColDao.save(specCol);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]保存失败", e);
		}
		
	}

	@Override
	public SpecCol queryById(Long id, String logFlag) {
		try {
			return specColDao.get(id);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]保存失败", e);
		}
		return null;
	}

	@Override
	public PaginationSupport<SpecCol> queryAll(boolean display, int pageSize,
			int pageNo) {
		Map<String, Object> paramsNotEqs = null;
		if (display) {
			paramsNotEqs = new HashMap<String, Object>();
			paramsNotEqs.put("sort", 0);
		}
		return specColDao.queryPage(null, paramsNotEqs, null,
				new String[] { "sort" }, pageSize, pageNo, true);
	}

	@Override
	@Transactional
	public void update(SpecCol specCol, String logFlag) {
		try {
			specColDao.update(specCol);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]修改失败", e);
		}
	}

	@Override
	@Transactional
	public void delete(SpecCol specCol, String logFlag) {
		try {
			specColDao.delete(specCol);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]specCol["+specCol.toString()+"]删除失败", e);
		}
	}
	
	
	@Override
	public List<SpecCol> query() {
		String hql="from SpecCol s order by s.id desc";
		return specColDao.find(hql);
	}
	

	@Override
	public PaginationSupport<SpecCol> queryPage(Map<String, Object> params,
			String[] order, int i, int pageNo) {
		return	specColDao.queryPage(params, order, i, pageNo);
	}

}
