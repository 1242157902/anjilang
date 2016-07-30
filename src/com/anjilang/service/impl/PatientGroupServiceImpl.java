package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.GroupTabDao;
import com.anjilang.dao.PatientGroupDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.PatientGroup;
import com.anjilang.service.PatientGroupService;
import com.anjilang.util.AjlException;
import com.anjilang.util.StringUtil;

/**
 * 患友会小组
 * @author  JYM
 * 2015-7-10 上午9:45:01
 */

@Service
public class PatientGroupServiceImpl implements PatientGroupService{
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private PatientGroupDao patientGroupDao;
	
	@Autowired
	private GroupTabDao groupTabDao;
	
	
	@Override
	public void addPatientGroup(PatientGroup patientGroup) throws AjlException {
		patientGroupDao.save(patientGroup);
	}

	
	@Override
	public PatientGroup getByid(Long id) throws AjlException {
		try {
			PatientGroup entity=patientGroupDao.get(id);
			if(entity==null){
				log.error("获取小组信息失败，小组id=" + id);
				throw AjlException.createErr("5000");
			}
			return entity;
		} catch (AjlException e) {
			throw e;
		}
	
	}

	
	
	@Override
	public void update(PatientGroup patientGroup) throws AjlException {
		patientGroupDao.myupdate(patientGroup);
		
	}
	
	@Override
	public List<PatientGroup> queryGroupByAudit(String audit)
			throws AjlException {
		try {
			log.info("查询小组audit["+audit+"]");
			String hql = "FROM  PatientGroup  WHERE 1=1";
			if(StringUtil.isNotEmpty(audit)) {
				hql += " AND audit = '" + audit + "'";
			}
			hql += "AND cancel="+0+" ORDER BY createtime desc";
			return patientGroupDao.find(hql);
		} catch (Exception e) {
			log.error("根据小组名查询小组失败["+audit+"]", e);
			throw AjlException.createErr("5006");
		}
	}

	@Override
	public PaginationSupport<PatientGroup> queryGroupByAudit(String audit,
			int pageSize, int pageNo) {
		pageSize = (pageSize < 0) ? 5 : pageSize;
		pageNo = (pageNo < 0) ? 1 : pageNo;
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtil.isNotEmpty(audit)) {
			params.put("audit", audit);
		}
		return patientGroupDao.queryPage(params, new String[]{"createtime"}, pageSize, pageNo);
	}


	
	@Override
	public List<PatientGroup> queryByCount() throws AjlException {
		String hql = "FROM  PatientGroup  WHERE 1=1 AND cancel="+0+" AND audit="+2+"ORDER BY personcount desc";
		return patientGroupDao.find(hql);		
	}


}
