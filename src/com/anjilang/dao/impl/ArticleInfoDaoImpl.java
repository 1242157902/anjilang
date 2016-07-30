package com.anjilang.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.classic.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.ArticleInfoDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.ArticleInfo;

@Repository
public class ArticleInfoDaoImpl extends GenericHibernateDao<ArticleInfo, Long> implements ArticleInfoDao{
	@Override
	public Long queryCount(Map<String, String> maps) {
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		String userId = maps.get("userId");
		StringBuffer sb = new StringBuffer("select count(*) from ArticleInfo where 1=1 ");
		if(userId!=null && !"".equals(userId)){
			sb.append(" and userId="+Long.parseLong(userId));
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
