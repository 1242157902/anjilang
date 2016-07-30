package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.GroupTabDao;
import com.anjilang.entity.GroupTab;
import com.anjilang.service.GroupTabService;
import com.anjilang.util.AjlException;
import com.anjilang.util.StringUtil;

/**
 * @author  JYM
 * 2015-7-13 下午8:17:58
 */
@Service
public class GroupTabServiceImpl implements GroupTabService{
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private GroupTabDao groupTabDao;

	@Override
	public void UaddGroupTab(GroupTab groupTab) throws AjlException {
		groupTabDao.save(groupTab);
	}

	
	@Override
	public void edit(GroupTab groupTab) throws AjlException {
		try {
			groupTabDao.myupdate(groupTab);
			
		} catch (Exception e) {
			log.error("编辑分类失败，" + groupTab.toString());
		}
		
		
	}

	
	@Override
	public List<GroupTab> SortTab(Long groupid) throws AjlException {
		try {
			log.info("查询标签groupid["+groupid+"]");
			String hql = "FROM  GroupTab  WHERE 1=1";
			if(groupid!=null){
				hql += " AND groupid = '" + groupid + "'";
			}
			hql += "AND cancel = "+0+"ORDER BY sortorder ";
			return groupTabDao.find(hql);
		} catch (Exception e) {
			log.error("根据小组查标签失败["+groupid+"]", e);
			throw AjlException.createErr("5000");
		}
	}


	
	@Override
	public GroupTab getById(Long id) throws AjlException {
		try {
			GroupTab groupTab=groupTabDao.get(id);
			if(groupTab==null){
				log.error("获取分类信息失败，小组id=" + id);
				throw AjlException.createErr("5000");
			}
			return groupTab;
			
		} catch (AjlException e) {
			throw e;
		}
		
	}

	
	
}
