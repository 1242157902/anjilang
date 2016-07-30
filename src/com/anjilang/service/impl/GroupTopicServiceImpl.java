package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.GroupTopicDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.PatientGroup;
import com.anjilang.service.GroupTopicService;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-26 下午8:45:45
 */
@Service
public class GroupTopicServiceImpl  implements GroupTopicService{
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private GroupTopicDao groupTopicDao;
	
	@Override
	public void publish(GroupTopic groupTopic) throws AjlException {
		groupTopicDao.mysaveOrUpdate(groupTopic);
		
		
	}

	
	@Override
	public List<GroupTopic> tolist(Long groupid) throws AjlException {
		try {
			log.info("查询标签groupid["+groupid+"]");
			String hql = "FROM  GroupTopic  WHERE 1=1";
			if(groupid!=null){
				hql += " AND groupid = '" + groupid + "'";
			}
			hql += "AND cancel="+0+"ORDER BY  createtime";
			return groupTopicDao.find(hql);
		} catch (Exception e) {
			log.error("根据小组查询列表["+groupid+"]", e);
			throw AjlException.createErr("5000");
		}
	}


	
	@Override
	public GroupTopic getById(Long id) throws AjlException {
		try {
			GroupTopic groupTopic=groupTopicDao.get(id);
			if(groupTopic==null){
				log.error("获取文章失败，文章id=" + id);
				throw AjlException.createErr("5000");
			}
			return groupTopic;
			
		} catch (AjlException e) {
			throw e;
		}
	}


	
	@Override
	public PaginationSupport<GroupTopic> queryPage(PatientGroup patientGroup, Long tabid,Integer cancel,
			int pageSize, int pageNo) throws AjlException {
		pageSize = (pageSize < 0) ? 5 : pageSize;
		pageNo = (pageNo < 0) ? 1 : pageNo;
		  HashMap<String, Object> params = new HashMap<String, Object>();
		if (patientGroup != null) {
			params.put("patientGroup", patientGroup);
		}
		if (tabid != null) {
			params.put("tabid",tabid);
		}
		if (cancel == 0) {
			params.put("cancel",cancel);
		}
		return groupTopicDao.queryPage(params, new String[]{"createtime"}, pageSize, pageNo);
	}


	
	@Override
	public PaginationSupport<GroupTopic> queryRepPage(
			PatientGroup patientGroup, Long tabid, Integer cancel,
			int pageSize, int pageNo) throws AjlException {
		 HashMap<String, Object> params = new HashMap<String, Object>();
			if (patientGroup != null) {
				params.put("patientGroup", patientGroup);
			}
			if (tabid != null) {
				params.put("tabid",tabid);
			}
			if (cancel == 0) {
				params.put("cancel",cancel);
			}
			return groupTopicDao.queryPage(params, new String[]{"rep"}, pageSize, pageNo);
	}


	
	@Override
	public List<GroupTopic>   RecomTopic(Integer recommended) throws AjlException {
		try {
			log.info("查询标签recommmend["+recommended+"]");
			String hql = "FROM  GroupTopic  WHERE 1=1";
			if(recommended!=null){
				hql += " AND recommended = '" + recommended + "'";
			}
			hql += "AND cancel="+0+"ORDER BY  rectime desc";
			return groupTopicDao.find(hql);
		} catch (Exception e) {
			log.error("根据推荐标签查询列表["+recommended+"]", e);
			throw AjlException.createErr("5000");
		}
	
		
	}


	
	@Override
	public List<GroupTopic> queryByNew() throws AjlException {
		try {
			String hql = "FROM  GroupTopic  WHERE 1=1";
			hql += "AND cancel="+0+"ORDER BY  createtime desc";
			return groupTopicDao.find(hql);
		} catch (Exception e) {
			throw AjlException.createErr("5000");
		}
	
	}

	
}
