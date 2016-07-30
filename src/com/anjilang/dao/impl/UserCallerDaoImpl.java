package com.anjilang.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.UserCallerDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.UserCaller;

@Repository
public class UserCallerDaoImpl extends GenericHibernateDao<UserCaller, Long> implements UserCallerDao{

	@Override
	public List<UserCaller> query(Map<String, String> maps) {
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		String userId = maps.get("userId");
		String pageSizeStr = maps.get("pageSize");
		String pageNoStr = maps.get("pageNo");
		StringBuffer sb = new StringBuffer("from UserCaller where 1=1 ");
		if(userId!=null && !"".equals(userId)){
			sb.append(" and callerUserId=" + Long.parseLong(userId));
		}
		sb.append(" group by userId order by id desc");
		Query query = session.createQuery(sb.toString());
		int pageSize=10;
		int pageNo=1;
		if(pageSizeStr!=null && !"".equals(pageSizeStr)){
			pageSize = Integer.parseInt(pageSizeStr);
		}
		if(pageNoStr!=null && !"".equals(pageNoStr)){
			pageNo = Integer.parseInt(pageNoStr);
		}
		query.setFirstResult((pageNo - 1) * pageSize);
		query.setMaxResults(pageSize);
		List<UserCaller> lists = query.list();
		session.close();
		return lists;
	}

	@Override
	public Long queryCount(Map<String, String> maps) {
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		String userId = maps.get("userId");
		StringBuffer sb = new StringBuffer("select count(*) from UserCaller where 1=1 ");
		if(userId!=null && !"".equals(userId)){
			sb.append(" and callerUserId="+Long.parseLong(userId));
		}
		Query query = session.createQuery(sb.toString());
		List list = query.list();
		session.close();
		if(list != null && list.size()>0){
			return Long.parseLong(list.get(0).toString());
		}
		
		return 0L;
	}

}
