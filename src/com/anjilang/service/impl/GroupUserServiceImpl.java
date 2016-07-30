package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.GroupUserDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.User;
import com.anjilang.service.GroupUserService;
import com.anjilang.util.AjlException;

/**
 * 加入小组和退出小组
 * 小组和用户的中间表
 * @author  JYM
 * 2015-7-20 下午2:29:45
 */
@Service
public class GroupUserServiceImpl  implements GroupUserService{
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private GroupUserDao groupUserDao;

	
	@Override
	public void JoinGroup(GroupUser groupUser) throws AjlException {
			groupUserDao.mysaveOrUpdate(groupUser);
	}

	
	@Override
	public void QuitGroup(GroupUser groupUser) throws AjlException {
		try {
			String hql="update GroupUser set ismember=? where id=?";
			Object[] values ={groupUser.getIsmember(),groupUser.getId()};
			groupUserDao.myupdate(groupUser);
		} catch (Exception e) {
			log.error("退出小组失败，" + groupUser.toString());
			throw AjlException.createErr("5005");
		}

	}


	@Override
	public GroupUser getById(GroupIdAndUserid groupIdAndUserid)
			throws AjlException {
	GroupUser  groupUser =  groupUserDao.myget(groupIdAndUserid);
		return groupUser;
	}


	@Override
	public List<GroupUser> memberList(GroupIdAndUserid groupIdAndUserid)
			throws AjlException {
		try {
			String hql = "FROM  GroupUser  WHERE 1=1";
			if (groupIdAndUserid!= null ) {
				hql += " AND groupid = '" + groupIdAndUserid.getGroupid() + "'";
			}
			hql += " AND  ismember>0  ORDER BY jointime desc";
			return groupUserDao.myfind(hql);
			} catch (Exception e) {
				log.error("根据小组查标签失败["+groupIdAndUserid.getGroupid()+"]", e);
				throw AjlException.createErr("5006");
		}
		
	}


	
	@Override
	public PaginationSupport<Long> queryByUserMem(GroupIdAndUserid id,
			int pageSize, int pageNo) throws AjlException {
		
	
		pageSize=(pageSize<0)? 12:pageSize;
		pageNo = (pageNo < 0) ? 1 : pageNo;
	
		return  groupUserDao.myqueryPage(id, pageSize, pageNo);
	}


	@Override
	public List<GroupUser> groupList(GroupIdAndUserid groupIdAndUserid)
			throws AjlException {
		try {
			String hql = "FROM  GroupUser  WHERE 1=1";
			if (groupIdAndUserid!= null ) {
				hql += " AND userid = '" + groupIdAndUserid.getUserid() + "'";
			}
			hql += " AND  ismember>0";
			return groupUserDao.myfind(hql);
			} catch (Exception e) {
				log.error("根据小组查标签失败["+groupIdAndUserid.getUserid()+"]", e);
				throw AjlException.createErr("5006");
		}
		
		
	}


	
	@Override
	public List<GroupUser> listByUser(GroupIdAndUserid id) throws AjlException {
		
		try {
			String hql = "FROM  GroupUser  WHERE 1=1";
			if (id!= null ) {
				hql += " AND groupid = '" + id.getGroupid() + "'";
			}
			hql += " AND  ismember=2";
			return groupUserDao.myfind(hql);
			} catch (Exception e) {
				log.error("根据小组查标签失败["+id.getGroupid()+"]", e);
				throw AjlException.createErr("5006");
		}
	}


	
	


	
	

	
	

}
