package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.SeniorDoctorDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SeniorDoctor;
import com.anjilang.service.SeniorDoctorService;

/**
 * 资深医生服务
 * 
 * @author xym
 * 
 */
@Service
public class SeniorDoctorServiceImpl implements SeniorDoctorService {
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private SeniorDoctorDao seniorDoctorDao;

	@Override
	@Transactional
	public void save(SeniorDoctor sDoc, String logFlag) {
		try {
			seniorDoctorDao.save(sDoc);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]保存失败", e);
		}
	}

	@Override
	public SeniorDoctor queryById(Long id, String logFlag) {
		try {
			return seniorDoctorDao.get(id);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]保存失败", e);
		}
		return null;
	}

	@Override
	public PaginationSupport<SeniorDoctor> queryAll(boolean display,
			int pageSize, int pageNo) {
		Map<String, Object> paramsNotEqs = null;
		if (display) {
			paramsNotEqs = new HashMap<String, Object>();
			paramsNotEqs.put("sort", 0);
		}
		return seniorDoctorDao.queryPage(null, paramsNotEqs, null,
				new String[] { "sort" }, pageSize, pageNo, true);
	}

	@Override
	@Transactional
	public void update(SeniorDoctor sDoc, String logFlag) {
		try {
			seniorDoctorDao.update(sDoc);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]修改失败", e);
		}
	}

	@Override
	@Transactional
	public void delete(SeniorDoctor seniorDoctor, String logFlag) {
		try {
			seniorDoctorDao.delete(seniorDoctor);
		} catch (Throwable e) {
			log.error("[" + logFlag + "]seniorDoctor["+seniorDoctor.toString()+"]删除失败", e);
		}
	}

}
