package com.anjilang.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.TopicReplyDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.service.TopicReplyService;
import com.anjilang.util.AjlException;
import com.anjilang.util.StringUtil;

/**
 * @author  JYM
 * 2015-7-30 上午11:51:20
 */
@Service
public class TopicReplyServiceImpl  implements TopicReplyService{
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private TopicReplyDao topicReplyDao;

	
	@Override
	public void addReply(TopicReply topicReply) throws AjlException {
		 topicReplyDao.save(topicReply);
	}


	
	@Override
	public List<TopicReply> countTP(Long topicid) throws AjlException {
		try {
			log.info("查询标签groupid["+topicid+"]");
			String hql = "FROM  TopicReply  WHERE 1=1";
			if(topicid!=null){
				hql += " AND  topicid = '" +  topicid + "'";
			}
			hql += "ORDER BY reptime desc";
			return topicReplyDao.find(hql);
		} catch (Exception e) {
			log.error("根据小组查标签失败["+topicid+"]", e);
			throw AjlException.createErr("5000");
		}
	
	}



	
	@Override
	public PaginationSupport<TopicReply> queryByTopicid(Long topicid,
			int pageSize, int pageNo,User user) throws AjlException {
		pageSize = (pageSize < 0) ? 1 : pageSize;
		pageNo = (pageNo < 0) ? 1 : pageNo;
		Map<String, Object> params = new HashMap<String, Object>();
		//Map<String, Object> params1 = new HashMap<String, Object>();
		if(topicid!=null) {
			params.put("topicid", topicid);
		}
		if(topicid!=null) {
			params.put("user", user);
		}
		//params1.put("isDelete", true);
	/*	return topicReplyDao.queryPage(params, new String[]{"floor"}, pageSize, pageNo);*/
		return topicReplyDao.queryPage(params, null, null, new String[]{"floor"}, pageSize, pageNo, false);
	}



	
	@Override
	public Integer count(Long topicid) throws AjlException {
		try {
			log.info("查询标签groupid["+topicid+"]");
			String hql = "FROM  TopicReply  WHERE 1=1";
			if(topicid!=null){
				hql += " AND  topicid = '" +  topicid + "'";
			}
			hql += "ORDER BY reptime desc";
			List<TopicReply>  replys=topicReplyDao.find(hql);
			Integer count=replys.size();
			return count;
		} catch (Exception e) {
			log.error("根据小组查标签失败["+topicid+"]", e);
			throw AjlException.createErr("5000");
		}
	}

	@Override
	public TopicReply getTopicReply(Long topicid) throws AjlException {
		if (topicid == null) {
			log.error("["+topicid+"]不存在该回复");
			return null;
		}
		return topicReplyDao.get(topicid);
	}



	@Override
	@Transactional
	public void deleteTopicReply(Long repid) throws AjlException {
		TopicReply topicReply = topicReplyDao.load(repid);
		topicReplyDao.delete(topicReply);		
	}



	@Override
	public void updateTopicReply(TopicReply topicReply) throws Exception {
		if (topicReply != null) {
			topicReplyDao.saveOrUpdate(topicReply);
		}else{
			return ;
		}
	}

	

	
	
}
