package com.anjilang.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.TopicRecomDao;
import com.anjilang.entity.TopicRecom;
import com.anjilang.service.TopicRecomService;

/**
 * @author  JYM
 * 2015-8-12 下午7:16:20
 */

@Service
public class TopicRecomServiceImpl implements TopicRecomService{
	
	@Autowired
	private TopicRecomDao topicRecomDao;

	@Override
	public List<TopicRecom> queryAll() {
		String hql = "FROM  TopicRecom WHERE 1=1";
		return topicRecomDao.find(hql);
	}

	
	@Override
	public TopicRecom getbyId(Long id) {
		return topicRecomDao.get(id);
	}

}
