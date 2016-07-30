package com.anjilang.dao;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.entity.GroupTopic;

/**
 * @author  JYM
 * 2015-7-26 下午8:22:39
 */
public interface GroupTopicDao extends GenericDao<GroupTopic, Long>{

	      public void mysaveOrUpdate(GroupTopic entity) ;

}
