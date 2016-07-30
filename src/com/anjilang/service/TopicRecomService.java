package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.TopicRecom;

/**
 * @author  JYM
 * 2015-8-12 下午7:01:31
 */
public interface TopicRecomService {
	
	
	public List<TopicRecom>  queryAll();
	
	public  TopicRecom getbyId(Long id);

}
