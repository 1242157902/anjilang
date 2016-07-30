package com.anjilang.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.ReportDao;
import com.anjilang.entity.FriendLink;
import com.anjilang.entity.Report;
import com.anjilang.service.ReportService;
import com.anjilang.util.AjlException;

/**
 * 
 * <p>Title：        ReportServiceImpl<p>
 * <p>Description: 举报service <p>
 * @date:           2015年8月19日下午9:48:13
 * @author:         ysl
 * @version         1.0
 */
@Service
public class ReportServiceImpl implements ReportService{
	
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private ReportDao reportDao;
	
	
	@Override
	@Transactional
	public void addReport(Report report) throws AjlException {
		 if(report !=null)
		 {
			 reportDao.save(report);
		 }
		
	}
	
	
	@Override
	public List<Report> queryAjax() throws AjlException {
		return reportDao.loadAll();
	}


	@Override
	public Report getReportByRepid(Long repid) throws AjlException {
		try {
			log.info("查询["+repid+"]");
			String hql = "FROM  Report  WHERE 1=1";
			if(repid!=null){
				hql += " AND  topicReply.id = '" +  repid + "'";
			}
			hql += "ORDER BY reportDate desc";
			
			List<Report> reportList =  reportDao.find(hql);
			if (reportList != null) {
				return reportList.get(0);
			}
		} catch (Exception e) {
			log.error("根据repid查询举报失败["+repid+"]", e);
			throw AjlException.createErr("5000");
		}
		return null;
	}

	
	@Override
	@Transactional
	public void delete(Report report) {
		reportDao.delete(report);
	}


	@Override
	public Report load(Long id) throws Exception {
		
		return reportDao.load(id);
	}
}
